autocmd FileType go set noexpandtab shiftwidth=8 tabstop=8 softtabstop=0
au FileType go nmap <leader>g <Plug>(go-def-split)
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType vue set expandtab shiftwidth=4 tabstop=8 softtabstop=0
