.PHONY: all help init install install_real update vim vim_alias

VERSION := 1.5.0

NULL :=
TOPDIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

# all runs help
all : help

# help lists out targets
help :
	$(info $(NULL))
	$(info ** Available Targets **)
	$(info $(NULL))
	$(info $(NULL)	all	- runs help)
	$(info $(NULL)	help	- this message)
	$(info $(NULL)	init	- initializes the submodules)
	$(info $(NULL)	install	- installs dotfiles)
	$(info $(NULL)	update	- updates submodules)
	$(info $(NULL)	vim	- installs vim configuration files (default is neovim only))
	$(info $(NULL)	vim_alias	- aliases vim to nvim)
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
	$(info $(NULL))

	install -d -m 0700 "${HOME}/.bash_exports"
	install -m 0600 "$(TOPDIR)/dotfiles/bash_exports/alias_grep" "${HOME}/.bash_exports/alias_grep"
	install -m 0600 "$(TOPDIR)/dotfiles/bash_exports/alias_ls" "${HOME}/.bash_exports/alias_ls"
	install -m 0600 "$(TOPDIR)/dotfiles/bash_exports/export_editor" "${HOME}/.bash_exports/export_editor"
	install -m 0600 "$(TOPDIR)/dotfiles/bash_exports/export_ps1" "${HOME}/.bash_exports/export_ps1"
	install -m 0600 "$(TOPDIR)/dotfiles/bash_exports/export_visual" "${HOME}/.bash_exports/export_visual"

	install -d -m 0700 "${HOME}/Bin"
	install -m 0700 "$(TOPDIR)/Bin/convert-to-mp3" "${HOME}/Bin/convert-to-mp3"
	install -m 0700 "$(TOPDIR)/Bin/install-coc-extensions" "${HOME}/Bin/install-coc-extensions"
	install -m 0700 "$(TOPDIR)/Bin/install-git-options" "${HOME}/Bin/install-git-options"
	install -m 0700 "$(TOPDIR)/Bin/install-go-tools" "${HOME}/Bin/install-go-tools"
	install -m 0700 "$(TOPDIR)/Bin/read-md" "${HOME}/Bin/read-md"
	install -m 0700 "$(TOPDIR)/Bin/tmux-git-branch" "${HOME}/Bin/tmux-git-branch"
	install -m 0700 "$(TOPDIR)/Bin/yakuake-init-session" "${HOME}/Bin/yakuake-init-session"
	install -m 0700 "$(TOPDIR)/Bin/yakuake-send" "${HOME}/Bin/yakuake-send"
	install -m 0700 "$(TOPDIR)/Bin/yakuake-split-dev-2k" "${HOME}/Bin/yakuake-split-dev-2k"

	install -m 0600 "$(TOPDIR)/dotfiles/bash_profile" "${HOME}/.bash_profile"
	install -m 0600 "$(TOPDIR)/dotfiles/bashrc" "${HOME}/.bashrc"
	install -m 0600 "$(TOPDIR)/dotfiles/profile" "${HOME}/.profile"
	install -m 0600 "$(TOPDIR)/dotfiles/tmux.conf" "${HOME}/.tmux.conf"
	install -m 0600 "$(TOPDIR)/dotfiles/tmux.dev.conf" "${HOME}/.tmux.dev.conf"
	install -m 0600 "$(TOPDIR)/dotfiles/tmux.split.conf" "${HOME}/.tmux.split.conf"
	install -m 0600 "$(TOPDIR)/dotfiles/tmux.split.2k.conf" "${HOME}/.tmux.split.2k.conf"

	install -d -m 0700 "${HOME}/.fonts"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Caskaydia Cove Nerd Font Complete Mono.ttf" \
			"${HOME}/.fonts/Caskaydia Cove Nerd Font Complete Mono.ttf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Caskaydia Cove Nerd Font Complete.ttf" \
			"${HOME}/.fonts/Caskaydia Cove Nerd Font Complete.ttf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Fira Code Bold Nerd Font Complete Mono.otf" \
			"${HOME}/.fonts/Fira Code Bold Nerd Font Complete Mono.otf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Fira Code Bold Nerd Font Complete.otf" \
			"${HOME}/.fonts/Fira Code Bold Nerd Font Complete.otf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Fira Code Light Nerd Font Complete Mono.otf" \
			"${HOME}/.fonts/Fira Code Light Nerd Font Complete Mono.otf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Fira Code Light Nerd Font Complete.otf" \
			"${HOME}/.fonts/Fira Code Light Nerd Font Complete.otf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Fira Code Medium Nerd Font Complete Mono.otf" \
			"${HOME}/.fonts/Fira Code Medium Nerd Font Complete Mono.otf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Fira Code Medium Nerd Font Complete.otf" \
			"${HOME}/.fonts/Fira Code Medium Nerd Font Complete.otf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Fira Code Regular Nerd Font Complete Mono.otf" \
			"${HOME}/.fonts/Fira Code Regular Nerd Font Complete Mono.otf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Fira Code Regular Nerd Font Complete.otf" \
			"${HOME}/.fonts/Fira Code Regular Nerd Font Complete.otf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Fira Code Retina Nerd Font Complete Mono.otf" \
			"${HOME}/.fonts/Fira Code Retina Nerd Font Complete Mono.otf"
	install -m 0600 "$(TOPDIR)/dotfiles/fonts/Fira Code Retina Nerd Font Complete.otf" \
			"${HOME}/.fonts/Fira Code Retina Nerd Font Complete.otf"

	fc-cache ~/.fonts

	install -d -m 0700 "${HOME}/.local/share/konsole"
	install -m 0600 "$(TOPDIR)/dotfiles/local/share/konsole/dracula.colorscheme" \
			"${HOME}/.local/share/konsole/dracula.colorscheme"
	install -m 0600 "$(TOPDIR)/dotfiles/local/share/konsole/Main.Profile" \
			"${HOME}/.local/share/konsole/Main.profile"

	install -d -m 0700 "${HOME}/.local/share/yakuake/kns_skins"
	cp -R "$(TOPDIR)/dotfiles/local/share/yakuake/kns_skins/pixelnine" \
			"${HOME}/.local/share/yakuake/kns_skins/"

	install -d -m 0700 "${HOME}/.config/nvim"
	install -m 0600 "$(TOPDIR)/dotfiles/config/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
	install -m 0600 "$(TOPDIR)/dotfiles/coc-settings.json" "${HOME}/.config/nvim/coc-settings.json"
	@if [ -d "${HOME}/.config/nvim/colors" ]; then \
			echo "rm -rf ${HOME}/.config/nvim/colors"; \
			rm -rf "${HOME}/.config/nvim/colors"; \
			fi
	@if [ -d "${HOME}/.config/nvim/pack" ]; then \
			echo "rm -rf ${HOME}/.config/nvim/pack"; \
			rm -rf "${HOME}/.config/nvim/pack"; \
			fi
	cp -R "$(TOPDIR)/dotfiles/vim/colors" "${HOME}/.config/nvim"
	cp -R "$(TOPDIR)/dotfiles/vim/pack" "${HOME}/.config/nvim"

	@echo

# Update submodules
update :
	$(info $(NULL))
	git submodule update --recursive --remote
	@echo

# Install configurations for vim
vim :
	$(info $(NULL))

	install -m 0600 "$(TOPDIR)/dotfiles/vimrc" "${HOME}/.vimrc"

	install -d -m 0700 "${HOME}/.vim"
	install -m 0600 "$(TOPDIR)/dotfiles/coc-settings.json" "${HOME}/.vim/coc-settings.json"
	@if [ -d "${HOME}/.vim/colors" ]; then \
			echo "rm -rf ${HOME}/.vim/colors"; \
			rm -rf "${HOME}/.vim/colors"; \
			fi
	@if [ -d "${HOME}/.vim/pack" ]; then \
			echo "rm -rf ${HOME}/.vim/pack"; \
			rm -rf "${HOME}/.vim/pack"; \
			fi
	cp -R "$(TOPDIR)/dotfiles/vim/colors" "${HOME}/.vim"
	cp -R "$(TOPDIR)/dotfiles/vim/pack" "${HOME}/.vim"

	@echo

# Installs vim alias
vim_alias : install_real
	$(info $(NULL))
	install -m 0600 "$(TOPDIR)/dotfiles/bash_exports/alias_vim" "${HOME}/.bash_exports/alias_vim"
	@echo
