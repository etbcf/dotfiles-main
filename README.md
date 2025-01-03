# My dotfiles

This repository contains my dotfiles. I use [GNU Stow](https://www.gnu.org/software/stow/) to manage them.

This video [here](https://www.youtube.com/watch?v=y6XCebnB9gs) explains the use of Stow.

## Requirements

Ensure you have the following installed:

### Git

```bash
$ sudo apt-get install git
```

### Stow

```bash
$ sudo apt-get install stow
```

## Setup guide

* Back up your files to another place in the computer and delete the originals.

* The dotfiles directory needs to be in the home directory.

* Clone the repository and change directory to it. 

```bash
$ git clone git@github.com:etbcf/dotfiles-main.git ~/dotfiles
$ cd ~/dotfiles
```

### Lastly issue the following command

```bash
$ stow .
```
