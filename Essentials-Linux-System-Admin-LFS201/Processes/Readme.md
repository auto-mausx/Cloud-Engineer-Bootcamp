# Processes

## Objectives

* Describe a process and the resources associated with it.

* Describe the role of the init process.

* Distinguish between processes, programs and threads.

* Understand process attributes, permissions and states, and know how to control limits.

* Explain the difference between running in user and kernel modes.

* Describe daemon processes.

* Understand how new processes are forked (created).

* Use nice and renice to set and modify priorities.

* Understand how shared and static libraries are used.

## Programs, Processes and Threads

* a *program* is a set of instructions, along with any internal data used while carrying the instructions out. Could have internal or external data (or both)

* a *process* is an executing program and associated resources including environment open files and signal handlers. A program could be executing more than once simultaneously -- it is then responsible for multiple process.

* a **multi-threaded process** occurs when two or more task (threads of execution ) at the same time, can share various resources: like memory space, open files or a queue.

* there is mention about how there are **heavy weight** and **light weight** processes in other operation systems.  

* For linux each thread of execution is considered individually

* Linux does a much better job of context switching and creation / destruction of processes

* This means that a multi threaded app behaves much more like spawning off multiple processes.

## What is a process

* A process is an instance of a program in execution. The process may be in a number of states like running or sleeping

* Every process has :
  * `pid` -- Process ID
  * `ppid` -- Parent Process ID
  * `pgid` --Process Group ID

* Every process has the following resources :
  * program code
  * data
  * variables
  * file descriptors
  * an environment

* `init` is usually the first process to run on a system and become the ancestor of all subsequent process running on the system.

* Except for those initiated from the kernel.  Those show up with a `[]` around the name in the `ps` listing

* it is important to note that a process can spawn off children process making a *child* / *parent* relationship

* The *child* process can die early making them *zombie* processes

* part of `init`s job is clean them up often referred to a *zombie killer* or *child reaper*

* Processes are controlled by *scheduling* which is complete preemptive. only the kernel has the right to preempt a process; they cannot do it to each other

```bash
There actually is a whole lot more detail not told here about preemptive cpu architecture
and OS design.  Once upon a time you could not preempt a process in execution you would have to wait for it to be finished.
```

## Process Attributes

* All Process have these attributes:
  * The program being executed
  * Context (state)
  * Permissions
  * Associated resources.

* *contex* : when ever a process gets preempted ( another process is about to take cpu cycles), the process will take a snapshot of its state.  This will include the state of the cpu registers (again not explained, but in the registers there will be instruction and machine instructions and what is the data IN the registers. [MUL, F1, F2, L3 { Multiple whats in F1 and F2 and put it L3}.  While the new process is loading up, out of the cache the cpu will "flush" with some 0s to clean out whats left over in the registers  THIS complex: copy to l1 cache, flush, load instructions and execution is what makes context switching so important])

* Processes can be scheduled in and out when sharing CPU time with others, or be put to sleep waiting on I/O or user response.  Thus being able to store the context, load up a new set of process instruction, then swap back to the original to continue execution is critical to the kernels ability to do context switching

* "Every process has permissions based on which user has called it to execute. It may also have permissions based on who owns its program file. Programs which are marked with an ”s” execute bit have a different ”effective” user id than their ”real” user id. These programs are referred to as `setuid` programs.

* *NOTE* `setuid` programs owned be an security problem

* As an example: the `passwd` program is an example of a `setuid` program

## Process Resource Isolation

* processes are isolated in its own user space, with its own spot in memory

* creates greater stability and promotes security

* process do not have direct access to hardware

* they must rely on **System calls** to interact with the hardware

* this goes back to scheduling and context switching.  

## Controlling Processes with ulimit

* `ulimit` is a built-in bash command that displays or resets a number of resource limits associated with processes running under a shell.

* A system administrator may need to change some of these values in either direction:
  * To restrict capabilities so an individual user and/or process cannot exhaust system resources, such as memory, cpu time or the maximum number of processes on the system.
  * To expand capabilities so a process does not run into resource limits; for example, a server handling many clients may find that the default of 1024 open files makes its work impossible to perform.