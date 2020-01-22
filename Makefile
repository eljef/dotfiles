.PHONY: all help init install install_real

VERSION := 0.0.1

NULL :=
TOPDIR := $(abspath $(lastword $(MAKEFILE_LIST)))

# all runs help
all : help

# help lists out targets
help :
	$(info $(NULL))
	$(info ** Available Targets **)
	$(info $(NULL))
	$(info $(NULL)	all		- runs help)
	$(info $(NULL)	help	- this message)
	$(info $(NULL)	init	- initializes the submodules)
	$(info $(NULL)	install	- installs dotfiles)
	$(info $(NULL))
	@:

# init initializes git submodules
init :
	$(info $(NULL))
	git submodule update --init --recursive
	@echo

# install spits out a warning message
install :
	$(info $(NULL))
	@echo "Installing will overwrite any current dotfiles."
	@echo "Backup anything important and then run 'make install_real'"
	@echo

# install_real installs the dotfiles
install_real :
	cd ~
	rm -f .vimrc
	ln -sf "$(TOPDIR)/dotfiles/vimrc" .vimrc
	rm -rf .vim
	ln -sf "$(TOPDIR)/dotfiles/vim" .vim

