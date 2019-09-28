<!--Source Url : https://www.cnblogs.com/fly-fish/archive/2012/01/13/2321952.html-->
<div id="main">
	<div id="mainContent">
	<div class="forFlow">
		<div id="post_detail">
    <!--done-->
    <div id="topics">
        <div class="post">
            <h1 class = "postTitle">
                
<a id="cb_post_title_url" class="postTitle2" href="https://www.cnblogs.com/fly-fish/archive/2012/01/13/2321952.html">交叉编译时候如何配置连接库的搜索路径</a>

            </h1>
            <div class="clear"></div>
            <div class="postBody">
                
<div id="cnblogs_post_body" class="blogpost-body ">
    <div id="blog_text" class="cnt">
<p><strong><span style="font-size: small;"><br />交叉编译的时候不能使用本地（i686机器，即PC机器，研发机器）机器上的库，但是在做编译链接的时候默认的是使用本地库，即/usr/lib,/lib两个目录。因此，在交叉编译的时候，要采取一些方法使得在编译链接的时候找到需要的库。 <br />首先，要知道：<span style="color: #0000ff;">编译的时候只需要头文档，真正实际的库文档在链接的时候用到。</span> （这是我的理解，假如有不对的地方，敬请网上各位大侠指教） 然后，讲讲如何在交叉编译链接的时候找到需要的库。<br />（1）、交叉编译时候直接使用-L和-I参数指定搜索非标准的库文档和头文档的路径。例如：<br />arm-linux-gcc test.c -L/usr/local/arm/2.95.3/arm-linux/lib -I/usr/local/arm/2.95.3/arm-linux/include <br />（2）、使用ld.so.conf文档，将用到的库所在文档目录添加到此文档中，然后使用ldconfig命令刷新缓存。 <br />（3）、使用如下命令：<br />$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/arm/2.95.3/arm-linux-lib <br />参见《ld.so.conf 文档和PKG_CONFIG_PATH变量》这篇文章。 <br />通过环境变量LD_LIBRARY_PATH指定动态库搜索路径（！）。 <br />通过设定环境变量LD_LIBRARY_PATH也可以指定动态库搜索路径。当通过该环境变量指定多个动态库搜索路径时，路径之间用冒号"："分隔。 <br />不过LD_LIBRARY_PATH的设定作用是全局的，过多的使用可能会影响到其他应用程序的运行，所以多用在调试。（LD_LIBRARY_PATH的缺陷和使用准则，可以参考《Why LD_LIBRARY_PATH is bad》 ）。通常情况下推荐还是使用gcc的-R或-rpath选项来在编译时就指定库的查找路径，并且该库的路径信息保存在可执行文件中，运行时它会直接到该路 径查找库，避免了使用LD_LIBRARY_PATH环境变量查找。 <br />（4）、交叉编译时使用软件的configure参数。例如我编译minigui-1.3.3，使用如下配置：<br />#!/bin/bash<br />rm -f config.cache config.status <br />./configure --build=i686-linux --host=arm-linux --target=arm-linux \ <br />CFLAGS=-I/usr/local/arm/2.95.3/arm-linux/include \<br />LDFLAGS=-L/usr/local/arm/2.95.3/arm-linux/lib \ <br />--prefix=/usr/local/arm/2.95.3/arm-linux \ <br />--enable-lite \ <br />--disable-galqvfb \<br />--disable-qvfbial \<br />--disable-vbfsupport \<br />--disable-ttfsupport \ <br />--disable-type1support \ <br />--disable-imegb2312py \ <br />--enable-extfullgif \ <br />--enable-extskin \<br />--disable-videoqvfb \ <br />--disable-videoecoslcd <br />这里我配置了CFLAGS和LDFLAGS参数，这样一来，我就不用去修改每个Makefile里-L和-I参数了，也不用再去配置LD_LIBRARY_PATH或改写ld.so.conf文档了。 </span></strong></p>
<p><strong><span style="font-size: small;"><span style="color: #0000ff;">Linux下动态库使用小结</span> <br /><span style="color: #993300;">1. 静态库和动态库的基本概念</span><br />静态库，是在可执行程序连接时就已经加入到执行码中，在物理上成为执行程序的一部分；使用静态库编译的程序运行时无需该库文件支持，哪里都可以用，但是生成的可执行文件较大。动态库，是在可执行程序启动时加载到执行程序中，可以被多个可执行程序共享使用。使用动态库编译生成的程序相对较小，但运行时需要库文件支持，如果机器里没有这些库文件就不能运行。<br /><span style="color: #993300;">2． 如何使用动态库</span><br />如何程序在连接时使用了共享库，就必须在运行的时候能够找到共享库的位置。linux的可执行程序在执行的时候默认是先搜索/lib和/usr/lib这两个目录，然后按照/etc/ld.so.conf里面的配置搜索绝对路径。同时，Linux也提供了环境变量LD_LIBRARY_PATH供用户选择使用，用户可以通过设定它来查找除默认路径之外的其他路径，如查找/work/lib路径,你可以在/etc/rc.d/rc.local或其他系统启动后即可执行到的脚本添加如下语句：LD_LIBRARY_PATH =/work/lib:$(LD_LIBRARY_PATH)。并且LD_LIBRARY_PATH路径优先于系统默认路径之前查找（详细参考《使用LD_LIBRARY_PATH》）。<br />不过LD_LIBRARY_PATH的设定作用是全局的，过多的使用可能会影响到其他应用程序的运行，所以多用在调试。（LD_LIBRARY_PATH的缺陷和使用准则，可以参考《Why LD_LIBRARY_PATH is bad》 ）。通常情况下推荐还是使用gcc的-R或-rpath选项来在编译时就指定库的查找路径，并且该库的路径信息保存在可执行文件中，运行时它会直接到该路径查找库，避免了使用LD_LIBRARY_PATH环境变量查找。<br />3．库的链接时路径和运行时路径<br />现代连接器在处理动态库时将链接时路径（Link-time path）和运行时路径（Run-time path）分开,用户可以通过-L指定连接时库的路径，通过-R（或-rpath）指定程序运行时库的路径，大大提高了库应用的灵活性。比如我们做嵌入式移植时#arm-linux-gcc $(CFLAGS) &ndash;o target &ndash;L/work/lib/zlib/ -llibz-1.2.3 (work/lib/zlib下是交叉编译好的zlib库)，将target编译好后我们只要把zlib库拷贝到开发板的系统默认路径下即可。或者通过-rpath（或-R ）、LD_LIBRARY_PATH指定查找路径。<br />小问题：<br />1．编译时的-L选项是否影响LD_LIBRARY_PATH的值？<br />举一个实例：<br />当前文件夹结构如下： <br />test.c tools/ <br />tool下有tool.c tool.h my_err.h 以及由此生成的libtool.so <br />tool下编译生成库文件 <br />gcc -Wall -g -shared -o tool.so tool.c <br />在当前文件夹引用： <br />gcc -Wall -g &ndash;o test.c -Ltools -ltool <br />编译不报错，但是运行加载的时候就出现cannot open shared object file。 <br />如果将该库文件拷贝到/usr/lib下就没有错误，正常运行。<br />说明编译时的-L选项并不影响环境变量LD_LIBRARY_PATH，-L只是指定了程序编译连接时库的路径，并不影响程序执行时库的路径，系统还是会到默认路径下查找该程序所需要的库。</span></strong></p>
</div>
</div>