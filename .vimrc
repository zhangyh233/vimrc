"vim的很多操作是<operation> <motion>，比如删除当前光标右3个 d + 3作箭头
"d删除 y粘贴 p复制 c改变(删除以后进入insert) w是一个动作，表示一个词，配合c用很好，b表示上一个词, i表示词中操作，比如ciw ci"(改"中的内容),ci{
"f用来找一个词，比如fn，就找set number中的n，强大的地方比如df:一直删到: yf:一直拷贝到:
"<CR>的作用就相当于回车
"shift +
"v进入行可视模式,此时可以:+normal进入普通模式的指令，vim会对每一行做同样的操作
"ctrl+v进入可视块模式

set nocompatible 	"不兼容vi模式
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a		"允许使用鼠标
set encoding=utf-8	"编码
let &t_ut=''		"配色修正
set expandtab       "将新增的tab转换为空格，不会对已有的tab进行转换
set tabstop=4       "设置一个tab对应4个空格
set shiftwidth=4    "把连续的空格当成一个tab
set softtabstop=4	"按退格键时，如果前面有4个空格，则会统一清除
set backspace=indent,eol,start     " indent: 如果用了:set indent,:set ai 等自动缩进，想用退格键将字段缩进的删掉，必须设置这个选项。否则不响应。
                                    "eol:如果插入模式下在行开头，想通过退格键合并两行，需要设置eol。
                                    "start：要想删除此次插入前的输入，需设置这个
set smartindent     "启用只能缩进
set cindent         "启用严格的c风格缩进

set showmatch       "插入右括号会短暂的匹配左括号
set matchtime=1     "括号匹配时间

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o      "粘贴时不会自动缩进
                                                                                    "r:按回车不会添加注释 o:按o不会添加注释 c:c不会添加注释
set laststatus=2    "总是显示状态行
set autochdir       "自动切换当前目录为当前文件所在目录
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif    "保存光标位置

set list		"显示行尾空格
set listchars=tab:▸\ ,trail:▫    "设定显示tab和行尾空格的种类
set scrolloff=6     "光标移动到上下边缘保持6行的距离
set textwidth=0    "设置每次打字时候的行宽

let mapleader=" "
syntax on		"高亮
set number		"显示行号
set cursorline		"在当前行下显示一条线
set wrap		"自动换行，可以不超出窗口大小
set showcmd		"在下面显示出当前打印的指令
set wildmenu		"输入指令时候给予提示
set hlsearch		"搜索到结果后高亮
set incsearch		"搜索时高亮
set ignorecase		"搜索时忽略大小写
set smartcase		"搜索时有大写有小写，智能只识别到匹配的版本

"分屏部分
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set nosplitbelow<CR>:split<CR>
map sk :set splitbelow<CR>:split<CR>
map <leader>l <C-w>l
map <leader>k <C-w>k
map <leader>h <C-w>h
map <leader>j <C-w>j
"分屏时改变窗口大小
map <UP> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>
"tabe打开新的标签页
map tt :tabe<CR>
map tn :-tabnext<CR>
map ti :+tabnext<CR>
"改变分屏角度
map sv <C-w>t<C-w>H
map sh <C-w>t<C-w>K

map <leader>n :exec "nohlsearch"<CR>
map R :source ~/.vimrc<CR>

"设置头文件路径
set path='.,/usr/include/clang/8.0.0/include,/usr/local/include,/usr/include/x86_64-linux-gnu,/usr/include,/usr/lib/llvm-8/lib/clang/8.0.0/include/,,'


call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'      "就是下面的状态栏美化
Plug 'connorholyday/vim-snazzy'     "配色方案

" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'      "就是给nerdtree中加入git的标记

Plug 'Valloric/YouCompleteMe', {'for': ['c','cpp'] }


call plug#end()

color snazzy

"NerdTree
map <F2> :NERDTreeToggle<CR>

"NerdTree-git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

"YouComple
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" 其他可选配置
"输入2个字符,自动启动语义补全
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap g/ :YcmCompleter GetDoc<CR>
nnoremap gt :YcmCompleter GetType<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
"let g:ycm_show_diagnostics_ui=0 "禁用 ycm 诊断
"
" 禁用原型预览
"set completeopt=menu,menuone
"let g:ycm_add_preview_to_completeopt = 0
