set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Snippet Engine
Plugin 'SirVer/ultisnips'

" Snippets package
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` toauto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>


ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>


set tabstop=2
set shiftwidth=2
set expandtab

set nu
syntax on

nmap <F6> :w<CR>:!./%<CR>
nmap <F7> :w<CR>:!perl %<CR>
nmap <F8> :w<CR>:!python %<CR>
set pastetoggle=<F10>

set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\
\ [%l/%L\ (%p%%)
filetype plugin indent on
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=79 " PEP-8 Friendly


" Trigger Configs
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

map <C-n> :NERDTreeToggle<CR>
set ttymouse=xterm2
set mouse=a 


