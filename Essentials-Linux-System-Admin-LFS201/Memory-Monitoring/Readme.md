# Memory Monitoring

[Home](/README.md)

Learn this:

* List the primary (inter-related) considerations and tasks involved in memory tuning.

* Use entries in `/proc/sys/vm`, and decipher `/proc/meminfo`.

* Use ``vmstat`` to display information about memory, paging, I/O, processor activity, and processes' memory consumption.

* Understand how the OOM-killer decides when to take action and selects which processes should be exterminated to open up some memory.

## Memory Monitoring tweaks

When tweaking parameters in `/proc/sys/vm`, the usual best practice is to adjust one thing at a time and look for effects. The primary (inter-related) tasks are:

* Controlling flushing parameters; i.e., how many pages are allowed to be dirty and how often they are flushed out to disk.
  
  *(Pages in the main memory that have been modified during writing data to disk are marked as "dirty" and have to be flushed to disk before they can be freed. When a file write occurs, the cached page for the particular block is looked up.)*

* Controlling swap behavior; i.e., how much pages that reflect file contents are allowed to remain in memory, as opposed to those that need to be swapped out as they have no other backing store.

* Controlling how much memory overcommission is allowed, since many programs never need the full amount of memory they request, particularly because of copy on write (COW) techniques.

### Table for memory tools

| UTILITY   | PURPOSE   | PACKAGE |
| --------- | --------- | -------- |
| free  |  Brief summary of memory usage   | procps |
| vmstat  |  Detailed virtual memory statistics and block I/O, dynamically updated   | procps |
| pmap  |  Process memory map  |  procps |


## /proc/meminfo

* remember that /proc/ is a pseudo file system

* /proc/meminfo/ has a TON of info

### Table of meminfo entries

| ENTRY |   MEANING |
| ------ | ------- |
| MemTotal  |   Total usable RAM (physical minus some kernel reserved memory) |
| MemFree  |   Free memory in both low and high zones |
| Buffers  |   Memory used for temporary block I/O storage |
| Cached   |  Page cache memory, mostly for file I/O |
| SwapCached |    Memory that was swapped back in but is still in the swap file |
| Active   |  Recently used memory, not to be claimed first |
| Inactive  |   Memory not recently used, more eligible for reclamation |
| Active(anon)   |  Active memory for anonymous pages |
| Inactive(anon)   |  Inactive memory for anonymous pages |
| Active(file)   |  Active memory for file-backed pages |
| Inactive(file) |    Inactive memory for file-backed pages |
| Unevictable  |   Pages which can not be swapped out of memory or released |
| Mlocked    | Pages which are locked in memory |
| SwapTotal  |   Total swap space available |
| SwapFree  |   Swap space not being used |
| Dirty   |  Memory which needs to be written back to disk |
| Writeback  |   Memory actively being written back to disk |
| AnonPages  |   Non-file back pages in cache |
| Mapped  |   Memory mapped pages, such as libraries |
| Shmem  |   Pages used for shared memory |
| Slab  |   Memory used in slabs |
| SReclaimable |    Cached memory in slabs that can be reclaimed |
| SUnreclaim   |  Memory in slabs that can't be reclaimed |
| KernelStack  |   Memory used in kernel stack |
| PageTables |    Memory being used by page table structures |
| Bounce  |   Memory used for block device bounce buffers |
| WritebackTmp  |   Memory used by FUSE filesystems for writeback buffers |
| CommitLimit   |  Total memory available to be used, including overcommission |
| Committed_AS  |   Total memory presently allocated, whether or not it is used |
| VmallocTotal  |   Total memory available in kernel for vmalloc allocations |
| VmallocUsed  |   Memory actually used by vmalloc allocations |
| VmallocChunk  |   Largest possible contiguous vmalloc area |
| HugePages_Total  |   Total size of the huge page pool |
| HugePages_Free  |   Huge pages that are not yet allocated |
| HugePages_Rsvd  |   Huge pages that have been reserved, but not yet used |
| HugePages_Surp  |   Huge pages that are surplus, used for overcommission |
| Hugepagesize  |   Size of a huge page |


## /proc/sys/vm

Here is where you can tune the Virtual Memory systems

* you can make changes by writing to the entry

* or by `sysctl`

* or by modifying `/etc/sysctl.conf` values at boot time

### Table: /proc/sys/vm Entries
| ENTRY  |  MEANING |
| ------- | ------- |
| admin_reserve_kbytes  |  Amount of free memory reserved for privileged users |
| block_dump | Enables block I/O debugging |
| compact_memory | Turns on or off memory compaction (essentially defragmentation) when configured into the kernel |
| dirty_background_bytes | Dirty memory threshold that triggers writing uncommitted pages to disk |
| dirty_background_ratio | Percentage of total pages at which kernel will start writing dirty data out to disk |
| dirty_bytes | The amount of dirty memory a process needs to initiate writing on its own |
| dirty_expire_centisecs | When dirty data is old enough to be written out in hundredths of a second) |
| dirty_ratio | Percentage of pages at which a process writing will start writing out dirty data on its own |
| dirty_writeback_centisecs	 | Interval in which periodic writeback daemons wake up to flush. If set to zero, there is no automatic periodic writeback |
| drop_caches | Echo 1 to free page cache, 2 to free dentry and inode caches, 3 to free all. Note only clean cached pages are dropped; do sync first to flush dirty pages |
| extfrag_threshold	 | Controls when the kernel should compact memory |
| hugepages_treat_as_movable | Used to toggle how huge pages are treated |
| hugetlb_shm_group	| Sets a group ID that can be used for System V huge pages |
| laptop_mode | Can control a number of features to save power on laptops |
| legacy_va_layout | Use old layout (2.4 kernel) for how memory mappings are displayed |
| lowmen_reserve_ratio | Controls how much low memory is reserved for pages that can only be there; i.e., pages which can go in high memory instead will do so. Only important on 32-bit systems with high memory |
| max_map_count | Maximum number of memory mapped areas a process may have. The default is 64 K |
| min_free_kbytes | Minimum free memory that must be reserved in each zone |
| mmap_min_addr | How much address space a user process cannot memory map. Used for security purposes, to avoid bugs where accidental kernel null dereferences can overwrite the first pages used in an application |
| nr_hugepages | Minimum size of hugepage pool |
| nr_pdflush_hugepages	| Maximum size of the hugepage pool = nr_hugepages *nr_overcommit_hugepages |
| nr_pdflush_threads	| Current number of pdflush threads; not writeable |
| oom_dump_tasks | If enabled, dump information produced when oom-killer cuts in |
| oom_kill_allocating_task | If set, the oom-killer kills the task that triggered the out of memory situation, rather than trying to select the best one |
| overcommit_kbytes | One can set either overcommit_ratio or this entry, but not both |
| overcommit_memory	| If 0, kernel estimates how much free memory is left when allocations are made. If 1, permits all allocations until memory actually does run out. If 2, prevents any overcommission |
| overcommit_ratio | If overcommit_memory = 2 memory commission can reach swap plus this percentage of RAM |
| page-cluster | Number of pages that can be written to swap at once, as a power of two. Default is 3 (which means 8 pages) |
| panic_on_oom | Enable system to crash on an out of memory situation |
| percpu_pagelist_fraction | Fraction of pages allocated for each cpu in each zone for hot-pluggable CPU machines |
| scan_unevictable_pages | If written to, system will scan and try to move pages to try and make them reclaimable |
| stat_interval | How often vm statistics are updated (default 1 second) by vmstat |
| swappiness | How aggressively should the kernel swap |
| user_reserve_kbytes | If overcommit_memory is set to 2 this sets how low the user can draw memory resources |
| vfs_cache_pressure | How aggressively the kernel should reclaim memory used for inode and dentry cache. Default is 100; if 0 this memory is never reclaimed due to memory pressure |


## vmstat

* see [vmstat man page](https://linux.die.net/man/8/vmstat)

`vmstat` is a multi-purpose tool that displays information about memory, paging, I/O, processor activity and processes. It has many options. The general form of the command is:

`vmstat [options] [delay] [count]`

If delay is given in seconds, the report is repeated at that interval count times; if count is not given, `vmstat` will keep reporting statistics forever, until it is killed by a signal, such as Ctrl-C.

If no other arguments are given, you can see what vmstat displays, where the first line shows averages since the last reboot, while succeeding lines show activity during the specified interval.

## OOM Killer

the kernel permits overcommission of memory, but only for pages dedicated to user processes; pages used within the kernel are not swappable and are always allocated at request time.

You can modify, and even turn off this overcommission by setting the value of `/proc/sys/vm/overcommit_memory`:

0. (default) Permit overcommission, but refuse obvious overcommits, and give root users somewhat more memory allocation than normal users.

1. All memory requests are allowed to overcommit.

2. Turn off overcommission. Memory requests will fail when the total memory commit reaches the size of the swap space plus a configurable percentage (50 by default) of RAM. This factor is modified changing `/proc/sys/vm/overcommit_ratio`.

If available memory is exhausted, Linux invokes the OOM-killer (Out Of Memory) to decide which process(es) should be exterminated to open up some memory.

There is no precise science for this; the algorithm must be heuristic and cannot satisfy everyone. In the minds of many developers, the purpose of the OOM-killer is to permit a graceful shutdown, rather than be a part of normal operations.

### Real World Example of OOM:

*"An aircraft company discovered that it was cheaper to fly its planes with less fuel on board. The planes would be lighter and use less fuel and money was saved. On rare occasions however the amount of fuel was insufficient, and the plane would crash. This problem was solved by the engineers of the company by the development of a special OOF (out-of-fuel) mechanism. In emergency cases a passenger was selected and thrown out of the plane. (When necessary, the procedure was repeated.) A large body of theory was developed and many publications were devoted to the problem of properly selecting the victim to be ejected. Should the victim be chosen at random? Or should one choose the heaviest person? Or the oldest? Should passengers pay in order not to be ejected, so that the victim would be the poorest on board? And if for example the heaviest person was chosen, should there be a special exception in case that was the pilot? Should first class passengers be exempted? Now that the OOF mechanism existed, it would be activated every now and then, and eject passengers even when there was no fuel shortage. The engineers are still studying precisely how this malfunction is caused."*

In order to make decisions of who gets sacrificed to keep the system alive, a value called the badness is computed (which can be read from /proc/[pid]/oom_score) for each process on the system and the order of the killing is determined by this value.

Two entries in the same directory can be used to promote or demote the likelihood of extermination. The value of oom_adj is the number of bits the points should be adjusted by. Normal users can only increase the badness; a decrease (a negative value for oom_adj) can only be specified by a superuser. The value of oom_adj_score directly adjusts the point value. Note that the use of oom_adj is deprecated.

## Lab 13.1. Invoking the OOM-Killer

Examine what swap partitions and files are present on your system by examining ```/proc/swaps```.

Turn off all swap with the command

```$ sudo /sbin/swapoff -a```

Make sure you turn it back on later, when we are done, with

```$ sudo /sbin/swapon -a```

Now we are going to put the system under increasing memory pressure. One way to do this is to exploit the ```stress-ng``` programwe installed earlier, running it with arguments such as:

```$ stress-ng -m 12 -t 10s``` 

which would keep 3 GB busy for 10 seconds.

You should see the **OOM**(Out of Memory) killer swoop in and try to kill processes in a struggle to stay alive. You can see whatis going on by running **dmesg** or monitoring ```/var/log/ messages``` or ```/var/log/syslog```, or through graphical interfaces thatexpose the system logs. 


Who gets clobbered first?