"设置行号
set number
"语法高亮
syntax on
"自动缩进
set ai    
"tab键宽度 4 个空格
set tabstop=4 
"自动缩进
set ai    
"搜索高亮
set hlsearch
"颜色主题
colorscheme hybrid

" i 表示 insert 模式, nore 表示 no recursive map 表示映射
" <leader> 表示 mapleader <cr> 表示回车键
let mapleader=','
inoremap <leader>w <Esc>:w<cr>

"jj 从 insert 模式切换到 normal 模式， 
inoremap jj <Esc>
vnoremap <leader>v <Esc> 

"install vim-plug 插件管理工具 参考https://github.com/junegunn/vim-plug
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
