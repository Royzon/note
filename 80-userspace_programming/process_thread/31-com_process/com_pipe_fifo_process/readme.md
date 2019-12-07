>PIPE : 无名管道  
FIFO  : 有名管道

### 一、PIPE
管道，通常指无名管道，是 UNIX 系统IPC最古老的形式。  
#### 特点：
1. 它是半双工的（即数据只能在一个方向上流动），具有固定的读端和写端。
2. 它只能用于具有亲缘关系的进程之间的通信（也是父子进程或者兄弟进程之间）。
3. 它可以看成是一种特殊的文件，对于它的读写也可以使用普通的read、write 等函数。但是它不是普通的文件，并不属于其他任何文件系统，并且只存在于内存中。

#### 原型
```c
#include <unistd.h>
int pipe(int fd[2]);    // 返回值：若成功返回0，失败返回-1
```
>当一个管道建立时，它会创建两个文件描述符：fd[0]为读而打开，fd[1]为写而打开  
要关闭管道只需将这两个文件描述符关闭即可。  


### 二、FIFO
FIFO，也称为命名管道，它是一种文件类型。  
FIFO的通信方式类似于在进程中使用文件来传输数据，只不过FIFO类型文件同时具有管道的特性。在数据读出时，FIFO管道中同时清除数据，并且“先进先出”。
#### 特点：
1. FIFO可以在**无关的进程**之间交换数据，与无名管道不同。
2. FIFO有路径名与之相关联，它以一种特殊**设备文件**形式存在于文件系统中。
#### 原型
```c
#include <sys/stat.h>
// 返回值：成功返回0，出错返回-1
int mkfifo(const char *pathname, mode_t mode);
```
其中的 mode 参数与open函数中的 mode 相同。一旦创建了一个 FIFO，就可以用一般的文件I/O函数操作它。  
当 open 一个FIFO时，是否设置非阻塞标志（O_NONBLOCK）的区别：
- 若没有指定O_NONBLOCK（默认），只读 open 要阻塞到某个其他进程为写而打开此 FIFO。类似的，只写 open 要阻塞到某个其他进程为读而打开它。
- 若指定了O_NONBLOCK，则只读 open 立即返回。而只写 open 将出错返回 -1 如果没有进程已经为读而打开该 FIFO，其errno置ENXIO。