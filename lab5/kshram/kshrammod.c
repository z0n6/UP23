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

#define NUM_DEVICES 8 // number of devices

static dev_t devnum;
static struct cdev c_dev;
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
	return 0;
}

static const struct file_operations kshrammod_dev_fops = {
	.owner = THIS_MODULE,
	.open = kshrammod_dev_open,
	.read = kshrammod_dev_read,
	.write = kshrammod_dev_write,
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
	// create char dev
	if(alloc_chrdev_region(&devnum, 0, NUM_DEVICES, "kshram") < 0)
		return -1;
	if((clazz = class_create(THIS_MODULE, "kshramclass")) == NULL)
		goto release_region;
	clazz->devnode = kshrammod_devnode;
	for (int i = 0; i < NUM_DEVICES; i++) {
		if(device_create(clazz, NULL, MKDEV(MAJOR(devnum), MINOR(devnum) + i), NULL, "kshram%d", i) == NULL)
			goto release_class;
	}
	
	
	cdev_init(&c_dev, &kshrammod_dev_fops);
	if(cdev_add(&c_dev, devnum, NUM_DEVICES) == -1)
		goto release_device;

	// create proc
	proc_create("kshram_mod", 0, NULL, &kshrammod_proc_fops);

	printk(KERN_INFO "kshrammod: initialized.\n");
	return 0;    // Non-zero return means that the module couldn't be loaded.

release_device:
	device_destroy(clazz, devnum);
release_class:
	class_destroy(clazz);
release_region:
	unregister_chrdev_region(devnum, 1);
	return -1;
}

static void __exit kshrammod_cleanup(void)
{
	remove_proc_entry("kshram_mod", NULL);

	cdev_del(&c_dev);
	for (int i = 0; i < NUM_DEVICES; i++) {
		device_destroy(clazz, MKDEV(MAJOR(devnum), MINOR(devnum) + i));
	}
	class_destroy(clazz);
	unregister_chrdev_region(devnum, NUM_DEVICES);

	printk(KERN_INFO "kshrammod: cleaned up.\n");
}

module_init(kshrammod_init);
module_exit(kshrammod_cleanup);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Chun-Ying Huang");
MODULE_DESCRIPTION("The unix programming course demo kernel module.");
