# My dotfiles

This directory contains my dotfiles. I use [GNU Stow](https://www.gnu.org/software/stow/) to manage them.

## Requirements

Ensure you have the following installed:


### Git

```bash
# apt install git
```

### Stow

```bash
# apt-get install stow
```

## Installation

```bash
$ git clone git@github.com:etbcf/dotfiles-main.git ~/dotfiles
cd ~/dotfiles
```

Then use GNU stow to create symlinks

```bash
$ stow .
```
