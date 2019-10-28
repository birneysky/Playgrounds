"设置行号
set number
"语法高亮
syntax on

" i 表示 insert 模式, nore 表示 no recursive map 表示映射
" <leader> 表示 mapleader <cr> 表示回车键
let mapleader=','
inoremap <leader>w <Esc>:w<cr>

"jj 切换到 normal 模式， 
inoremap jj <Esc>


call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-swift'
Plug 'keith/swift.vim'
call plug#end()


if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

autocmd FileType swift setlocal omnifunc=lsp#complete

"reference:
"https://rderik.com/blog/setup-swift-lsp-and-vim/
"https://github.com/apple/sourcekit-lsp/tree/master/Editors
"https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Swift
"https://github.com/keith/swift.vim
