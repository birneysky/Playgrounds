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
"colorscheme hybrid
"防止乱码
 16  set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
 17  set termencoding=utf-8
 18  set encoding=utf-8

" i 表示 insert 模式, nore 表示 no recursive map 表示映射

" mapleader 表示 <leader> 映射为, 
let mapleader=','

"<cr> 表示回车键
inoremap <leader>w <Esc>:w<cr>

"jj 从 insert 模式切换到 normal 模式， 
inoremap jj <Esc>
vnoremap <leader>v <Esc> 
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
"nerdtree 相关映射
noremap <C-n> :NERDTreeToggle<CR>

"install vim-plug 插件管理工具 参考https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
"swift 相关 vim 插件
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-swift'
Plug 'keith/swift.vim'
"文件管理
Plug 'scrooloose/nerdtree'
"状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
call plug#end()

"swift相关
if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

autocmd FileType swift setlocal omnifunc=lsp#complete
