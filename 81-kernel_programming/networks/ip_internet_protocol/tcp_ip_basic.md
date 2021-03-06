### key words
|no|||
|--|--|--|
|0|IP Address||
|1|first octet rule||
|2|mask||
|3|subnet\(子网\)||
|4|||

二进制binary\
八进制octal\
十六进制hexadecimal\
十进制decimal

### IP Address

`类+网络地址+主机地址`

|||
|--|--|
|len|32 bit,4个8位组|
|表示|点分十进制|
|分类规则|利用第一个八位组规则（first octet rule）|

根据IP网络的大小，IP地址分为A类、B类、C类、D类和E类地址。A类地址表示大型的网络，支持大量的IP地址；B类地址表示中型的网络；C类表示小型的网络。为了区分这些地址，利用第一个八位组规则（first octet rule）。

#### The first octet rule
- 第一个八进制的第一位为0，表示A类地址。
- 第一个八进制的头两位为10的，表示B类地址。
- 第一个八进制的头三位为110的，表示C类地址。
- 第一个八进制的头四位为1110的，表示D类地址。
- 第一个八进制的头五位为1111的，表示E类地址。

|class|First octet rule|Maximum and minimun\(BIN\)|DEC|
|--|--|--|--|
|A|0|00000000-01111111|1~126(127保留）|
|B|10|10000000-10111111|128～191|
|C|110|11000000-11011111|192～223|
|D|1110|11100000-11101111|224～239|
|E|1111|11110000-11111111|240～255|

### mask
掩码用来区分IP地址中的网络地址和主机地址。
掩码的表示方法和IP地址一样，有十进制和二进制两种表示方法，对A类、B类、C类地址的掩码为

|Class|BIN|DEC|
|--|--|--|
|A|11111111000000000000000000000000|255\.0\.0\.0|
|B|11111111111111110000000000000000|255\.255\.0\.0|
|C|11111111111111111111111100000000|255\.255\.255\.0|

#### 网络地址的确定方法：
将二进制的掩码和IP地址的二进制位进行“与”的操作，得出的结果就是网络地址；剩余的位就是主机地址。
例如： 193.28.2.2 ，确定网络地址和主机地址：
- 先判断该IP地址是A类还是B类，C类，利用first octet 规则，193属于C类地址。
- 将193.28.2.2 AND 255.255.255.0，“与”的结果193.28.2.0，所以网络地址为：193.28.2.0
- 主机地址为2
对于有类IP地址，由网络位和主机位组成
#### 掩码另外一个作用：确定网络地址的数量和主机地址的数量。
- 网络地址的数量为： 2 n -2 (n为掩码中二进制1的数量），对于A类地址可以划分的A类网络地址的数量为28 -2 =126
- A类网络中的主机地址的数量为: 2 (32-n) -2 ，对于A类地址主机的数量为2 （32-8) -2

### 子网 subnet
对于A和B类地址，主机位的数量巨大，而网络地址的数量很少。而在现实场景中，一个网络的主机地址不需要这么多，所以对于有类的地址造成了地址的大量的浪费；同时大量的主机地址将降低网络的性能和带宽利用率。为了充分的利用主机位地址，将Host 位进行分割，分割的部分用来作为网络地址，这样即增加了网络地址，又充分利用了主机位地址。分割的部分为子网。

`类+网络地址+（子网+主机地址）`

#### 子网掩码、子网数量、主机数量的计算
子网掩码区分子网地址和子网、主机的数量。计算方法和有类网络的计算方法一样。例如：X表示网络位，Y表示子网位，Z表示主机位。
子网数量＝2^y -2（ 路由器如果支持，也可以为2^y ）
- 子网位全0，表示有类的网络地址（对于支持CIDR－无类域间路由的协议，子网全0可以视为一个子网地址，所以对于大部分的路由协议，支持的子网数量应该是2^y -1。
- 子网位全1，表示子网广播地址，也是有效的地址。
```
主机数量=2^z -2
主机位全0，表示子网地址。
主机位全1，表示该子网的广播地址。
```
#### 1、给定一个网络地址，和主机数量，计算子网地址。
- 给一个B地址，172.16.0.0，可以划分多个C类地址？
B类地址的第三个八位组主机位全部划分为子网位：2 8-1=255个子网（子网位从0～254）。
- 给一个C类（192.168.1.0)地址，每个网段的主机数量位30个，子网是多少？\
①先计算主机位，根据2 z -2=30   ,计算z＝5，所以主机位由5位。（n取整数）\
②然后计算子网位： C类地址的主机位共有8位，所以的子网位为3位，所以子网网段为(192.168.1.0,192.168.1.32,192.168.1.64,192.168.1.128,192.168.1.96,192.168.1.160, 192.168.1.192,192.168.1.256(大于255，无效的子网网段）。    
#### 2、给定一个IP地址和掩码，计算出子网地址、广播地址、和有效IP地址的范围。(172.16.103.2 255.255.252.0).。
- 子网地址计算方法：\
①从IP地址中找出“感兴趣的数值” 。对于掩码在0～255（不包括0和255）对应的IP地址的十进制，即为感兴趣的数值。对于掩码255对应的IP地址的数值，复制该数值到子网地址中。对掩码0对应的IP地址，对应的数值为0。\
②计算出魔术数（magic number）。用256减去“感兴趣数值”对应的掩码。\
③子网位= N*（magic number）< 感兴趣的数值（N为整数，并取最大值）
