#!/bin/sh

if [ "$1" = "d" ];then
	hexo g && hexo d
	git add .
	git commit -m "Site updated: `date +%Y-%m-%d\ %H:%M:%S`"
	git push origin master
fi
