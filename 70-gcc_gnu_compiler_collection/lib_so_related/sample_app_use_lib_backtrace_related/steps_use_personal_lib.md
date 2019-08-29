> \# note "**LIB_SHARED**" related file
\# Copyright (C) 2019 Dramalife@live.com
\# 
\# This file is part of [note](https://github.com/Dramalife/note.git)
\# 
\# note is distributed in the hope that it will be useful, but
\# WITHOUT ANY WARRANTY; without even the implied warranty of
\# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
\#
\# Init : 2019.08.23;
\# Update 
\#

#### 1. USE LIB

```diff
# vi Makefile
# Replace "backtrace_funcs" and "../lib_shared" with your library and path.
-gcc -o $(BIN_NAME)$(BIN_END) $(SRC)
+gcc -o $(BIN_NAME)$(BIN_END) $(SRC) -lbacktrace_funcs -L../lib_shared
# -L : Tell gcc the location of YOUR_LIB, if needed(not in default search path, like /lib);
```

#### 2. FIND LIB

```bash
# Error occurs:
#./a_demo.out: error while loading shared libraries: libbacktrace_funcs.so: cannot open shared object file: No such file or directory

# METHOD 1 : Run:   *NOT RECOMMENDED!!!*
export LD_LIBRARY_PATH=.:../lib_shared

# METHOD 2.1 : ldconfig 
ldconfig ../lib_shared

# METHOD 2.2 : ldconfig_config
# Add "YOUR_LIB_PATH" to /etc/ld.so.conf AND run ldconfig;

# METHOD 3 : 
# Copy YOUR_LIB.so to "/lib","/usr/lib" ...

# METHOD 4 :	**Dramalife RECOMMENDED for debugging ;)**
# Add "-L$(PATH_YOUR_LIB_IN)" to YOUR_Makefile .

```

#### 3. HEADERS

```bash
#    ./app.c: In function ‘main’:
#    ./app.c:105:18: error: ‘signal_handler’ undeclared (first use in this function)
#    signal(SIGSEGV, signal_handler); 
#    ^
#    ./app.c:105:18: note: each undeclared identifier is reported only once for each function it appears in
#    make: *** [all] Error 1

# First checkout "LIB_HAVE_HEADER_FILE" defined at "app.c";

# METHOD 1
# Add "extern TYPE signal_handler(...);" to YOUR_APP.c manually :|

# METHOD 2
# Create a header file related to YOUR_LIB.so, which regular library files are like ;)

```

#### 4. ERRORS (that occurred when compiling applications.)
> [CH]背景：新添加动态链接库，并编译依赖这个库的应用程序。
> [EN]Background:Add shared library and compile applications depending on it.

##### 4.1 "undefined reference to"

```bash
#[CH]未定义的引用：找不到函数定义（没有ldconfig新添加的动态链接库，）
#[EN]undefined reference to : 
#	Makefile : {gcc -o $(BIN_NAME)$(BIN_END) $(SRC) -v}
# app.c:(.text+0x99): undefined reference to `signal_handler'
# collect2: error: ld returned 1 exit status
# make: *** [all] Error 1
```

##### 4.2 "error: ‘signal_handler’ undeclared"

```bash
#[CH]未声明函数：缺少头文件（缺少"extern TYPE FUNC(ARGS...)"）
#[EN]undeclared:Missing header file(s);(missing "extern TYPE FUNC(ARGS...)")
./app.c:113:18: error: ‘signal_handler’ undeclared (first use in this function)
```

##### 4.3 "cannot find -lbacktrace_funcs"

```bash
#	Makefile : {gcc -o $(BIN_NAME)$(BIN_END) $(SRC) -lbacktrace_funcs -L../lib_gg -v}
/usr/bin/ld.bfd.real: cannot find -lbacktrace_funcs
collect2: error: ld returned 1 exit status
make: *** [all] Error 1
```
