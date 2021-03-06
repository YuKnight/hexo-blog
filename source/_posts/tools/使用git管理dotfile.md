---
title: 使用git管理dotfile
date: 2016-01-24 11:06:25
tags: [tools]
---

打算使用github管理家目录底下的各种dotfile。果然，github甚至为这个都弄了个[专题页面][github_dotfile]。

## 如何管理dotfile

这里参考了文章[Getting Started With Dotfiles][get_start_with_dotfile]。

管理的最高境界就是自动化。自动化安装需要的软件。自动化声明alias，function等。

```
.
├── git
│ ├── .gitconfig
│ └── .gitignore_global
├── install.sh
├── osxdefaults.sh
├── runcom
│ ├── .bash_profile
│ └── .inputrc
└── system
 ├── .alias
 ├── .env
 ├── .function
 ├── .path
 └── .prompt
```

博主的dotfile仓库是这个样子的。把相关的配置写在相关的文件里。clone项目后，使用`install.sh`脚本进行安装。

```
#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXTRA_DIR="$HOME/.extra"

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks

ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.gemrc" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~

# Package managers & packages

. "$DOTFILES_DIR/install/brew.sh"
. "$DOTFILES_DIR/install/bash.sh"
. "$DOTFILES_DIR/install/npm.sh"
. "$DOTFILES_DIR/install/pip.sh"

if [ "$(uname)" == "Darwin" ]; then
    . "$DOTFILES_DIR/install/brew-cask.sh"
    . "$DOTFILES_DIR/install/gem.sh"
    ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
fi

# Run tests

bats test/*.bats

# Install extra stuff

if [ -d "$EXTRA_DIR" -a -f "$EXTRA_DIR/install.sh" ]; then
    . "$EXTRA_DIR/install.sh"
fi
```

每次安装前，dotfile仓库先更新自身。然后建立基础配置文件的软连接到用户家目录下。接着运行安装过程，安装一些必要程序。接着如果是`Darwin`系统，再额外安装写东西。接着是测试和extra install。

这里我有几个问题：
0. 核心是ln，但是参数是-sfv，也就是为强制吧现有的文件删除，这样不好。
1. 这里一上来就是安装brew，然后都是用brew安装东西，确定如readme所说可以在`*nix`下执行？
2. 既然都是用brew安装，为何还需要判断"Darwin"？




[github_dotfile]: https://dotfiles.github.io/ "GitHub does dotfiles - dotfiles.github.io"
[get_start_with_dotfile]: https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vxz4mv5sx "Getting Started With Dotfiles"


