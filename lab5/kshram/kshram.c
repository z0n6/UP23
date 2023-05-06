/*
 * Lab problem set for UNIX programming course
 * by Chun-Ying Huang <chuang@cs.nctu.edu.tw>
 * License: GPLv2
 */
#include <linux/module.h>	// included for all kernel modules
#include <linux/kernel.h>	// included for KERN_INFO
#include <linux/init.h>		// included for __init and __exit macros
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/errno.h>
#include <linux/sched.h>	// task_struct requried for current_uid()
#include <linux/cred.h>		// for current_uid();
#include <linux/slab.h>		// for kmalloc/kfree
#include <linux/uaccess.h>	// copy_to_user
#include <linux/string.h>
#include <linux/device.h>
#include <linux/cdev.h>
#include <linux/mm.h>

#include "kshram.h"

#define NUM_DEVICES 8 // number of devices

static dev_t devnum;
static struct cdev *c_devs;
static struct class *clazz;

static int kshrammod_dev_open(struct inode *i, struct file *f) {
	printk(KERN_INFO "kshrammod: device opened.\n");
	return 0;
}

static int kshrammod_dev_close(struct inode *i, struct file *f) {
	printk(KERN_INFO "kshrammod: device closed.\n");
	return 0;
}

static ssize_t kshrammod_dev_read(struct file *f, char __user *buf, size_t len, loff_t *off) {
	printk(KERN_INFO "kshrammod: read %zu bytes @ %llu.\n", len, *off);
	return len;
}

static ssize_t kshrammod_dev_write(struct file *f, const char __user *buf, size_t len, loff_t *off) {
	printk(KERN_INFO "kshrammod: write %zu bytes @ %llu.\n", len, *off);
	return len;
}

static long kshrammod_dev_ioctl(struct file *fp, unsigned int cmd, unsigned long arg) {
	printk(KERN_INFO "kshrammod: ioctl cmd=%u arg=%lu.\n", cmd, arg);
	switch (cmd) {
		case KSHRAM_GETSLOTS:
			return 8;
		case KSHRAM_GETSIZE:
			return fp->f_path.dentry->d_inode->i_size;
		case KSHRAM_SETSIZE:
			void *p = krealloc(fp->f_path.dentry->d_inode->i_cdev, arg, GFP_KERNEL);
			if (!p) {
				; // error handling
			}
	}

	return 0;
}

static void *kmalloc_ptr;

static int kshrammod_dev_mmaps(struct file *f, struct vm_area_struct *vma)
{
    int ret;
    long length = vma->vm_end - vma->vm_start;

    /* check length - do not allow larger mappings than the number of pages allocated */
    if (length > PAGE_SIZE)
        return -EIO;

    /* map the whole physically contiguous area in one piece */
    if ((ret = remap_pfn_range(vma,
                               vma->vm_start,
                               page_to_pfn(virt_to_page(kmalloc_ptr)),
                               length,
                               vma->vm_page_prot)) < 0) {
        return ret;
    }

    return 0;
}

static const struct file_operations kshrammod_dev_fops = {
	.owner = THIS_MODULE,
	.open = kshrammod_dev_open,
	.read = kshrammod_dev_read,
	.write = kshrammod_dev_write,
	.mmap = kshrammod_dev_mmaps,
	.unlocked_ioctl = kshrammod_dev_ioctl,
	.release = kshrammod_dev_close
};

static int kshrammod_proc_read(struct seq_file *m, void *v) {
	char buf[] = "`kshram, world!` in /proc.\n";
	seq_printf(m, buf);
	return 0;
}

static int kshrammod_proc_open(struct inode *inode, struct file *file) {
	return single_open(file, kshrammod_proc_read, NULL);
}

static const struct proc_ops kshrammod_proc_fops = {
	.proc_open = kshrammod_proc_open,
	.proc_read = seq_read,
	.proc_lseek = seq_lseek,
	.proc_release = single_release,
};

static char *kshrammod_devnode(const struct device *dev, umode_t *mode) {
	if(mode == NULL) return NULL;
	*mode = 0666;
	return NULL;
}

static int __init kshrammod_init(void)
{
	int i;
	// create char dev
	if(alloc_chrdev_region(&devnum, 0, NUM_DEVICES, "kshram") < 0)
		return -1;
	if((clazz = class_create(THIS_MODULE, "kshramclass")) == NULL)
		goto release_region;
	clazz->devnode = kshrammod_devnode;
	for (i = 0; i < NUM_DEVICES; i++) {
		if(device_create(clazz, NULL, MKDEV(MAJOR(devnum), MINOR(devnum) + i), NULL, "kshram%d", i) == NULL)
			goto release_class;
	}
	
	// allocate memory for cdevs
    c_devs = kzalloc(NUM_DEVICES * sizeof(struct cdev), GFP_KERNEL);
    if (!c_devs)
        goto release_device;

    for (i = 0; i < NUM_DEVICES; i++) {
        cdev_init(&c_devs[i], &kshrammod_dev_fops);
        if(cdev_add(&c_devs[i], MKDEV(MAJOR(devnum), MINOR(devnum) + i), 1) == -1)
            goto release_cdevs;
    }

	// create proc
	proc_create("kshram", 0, NULL, &kshrammod_proc_fops);

	printk(KERN_INFO "kshrammod: initialized.\n");
	return 0;    // Non-zero return means that the module couldn't be loaded.

release_cdevs:
	kfree(c_devs);
release_device:
	for (i = 0; i < NUM_DEVICES; i++) {
        device_destroy(clazz, MKDEV(MAJOR(devnum), MINOR(devnum) + i));
    }
release_class:
	class_destroy(clazz);
release_region:
	unregister_chrdev_region(devnum, 1);
	return -1;
}

static void __exit kshrammod_cleanup(void)
{
	remove_proc_entry("kshram", NULL);

	for (int i = 0; i < NUM_DEVICES; i++) {
		cdev_del(&c_devs[i]);
		device_destroy(clazz, MKDEV(MAJOR(devnum), MINOR(devnum) + i));
	}
	kfree(c_devs);
	class_destroy(clazz);
	unregister_chrdev_region(devnum, NUM_DEVICES);

	printk(KERN_INFO "kshrammod: cleaned up.\n");
}

module_init(kshrammod_init);
module_exit(kshrammod_cleanup);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Chun-Ying Huang");
MODULE_DESCRIPTION("The unix programming course demo kernel module.");
