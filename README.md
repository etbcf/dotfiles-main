# My dotfiles

This repository contains my dotfiles. I use [GNU Stow](https://www.gnu.org/software/stow/) to manage them.

This video [here](https://www.youtube.com/watch?v=y6XCebnB9gs) explains the use of Stow.

## Requirements

Ensure you have the following installed:

### Git

```bash
# apt-get install git
```

### Stow

```bash
# apt-get install stow
```

## Setup guide

Clone the repository and change directory to it. The dotfiles directory needs to be in the home directory.

```bash
$ git clone git@github.com:etbcf/dotfiles-main.git ~/dotfiles
$ cd ~/dotfiles
```

### Use this command to move all the files into the Stow directory

```
$ stow --adopt .
```

### If you prefer, move the files into the dotfiles directory and issue the following command

```bash
$ stow .
```
