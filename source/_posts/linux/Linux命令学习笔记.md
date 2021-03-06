---
title: Linux命令学习笔记
date: 2016-01-23 22:01:18
categories: [Linux]
tags: linux
---

TODO:
- [Linux终端：用cat命令查看不可见字符](http://www.centoscn.com/CentOS/help/2013/1223/2259.html)

## 排序(sort)

```
sort命令：

-n 按数字来排序，默认是按照字符来排序
-t <字符> 指定分割字段的分隔符
-k 指定按哪个字段排序
-u 去除重复行
-r 倒序排序
-f 忽略大小写
-o <文件> 输出到文件
-b 忽略前导空白
```

**注意：**
`-k`参数的解释：

```
 -k, --key=POS1[,POS2]
  start a key at POS1 (origin 1), end it at POS2 (default end of line)
```

`-k`可以提供两个参数，第一个参数指定那个key来排序。但是并不只是使用这个字段排序，而是**作为一个起点**。如果不指定`[,POS2]`，则会把`POS1`到结尾的字符串都用来排序。


## 建立硬/软链接(ln)

```
ln 源文件 目标文件
  -s 建立软链接（最常用）
  -f 如果目标文件已经存在，先删除再建立链接（危险哦）
  -i 在删除操作前询问（和-f不是配合关系，而是覆盖关系）
  -v 显示链接详细信息
  --backup 如果目前文件已经存在，那么先备份再创建（备份就是在文件名后面加个~）

注意一种情况：
ln -s a b
如果b已经存在，并且是个目录，那么会在b目录底下建立一个名为a的符号链接文件
```

## 查看磁盘占用(df/du)

```
df: 查看硬盘使用情况
  -h 用方便阅读的方式显示
  -T 显示文件系统类型
  -l 只显示本地文件系统

du: 查看目录或文件所占空间
  -h 用方便阅读的方式显示
  -a 显示所有文件夹与文件的大小（默认不显示文件的大小）
  -s 只显示总和
  -d N 在显示文件夹/文件时，只显示深度<=N
  --time 显示最后修改时间
  --exclude=PATTERN 排除符合PATTERN的路径
  -b 显示为字节数。
  -k 显示为K字节数。
  -m 显示为M字节数。
```

## 查看文件编码



