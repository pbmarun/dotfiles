set nocp                                                         " must be first line
let mapleader = ','


set backspace=indent,eol,start                                   " backspace 
set mouse=a                                                      " automatically enable mouse usage
set noautoindent
set clipboard+=unnamed                                           " Yanks go on clipboard instead.
set nobackup                                            
set incsearch                                                    " find as you type search
set shiftwidth=3                                                 " use indents of 3 spaces
set expandtab                                                    " tabs are spaces, not tabs
set tabstop=3                                                    " an indentation every 3 columns
set softtabstop=3                                                " let backspace delete indent
set showmatch                                                    " show matching brackets/parenthesis
set nu                                                           " Line numbers on
set showmode                                                     " display the current mode
set linespace=0                                                  " No extra spaces between rows
set winminheight=0                                               " windows can be 0 line high 
set ignorecase                                                   " case insensitive search
set smartcase                                                    " case sensitive when uc present
set cursorline                                                   " highlight current line
set pastetoggle=<F12>                                            " pastetoggle (sane indentation on paste)
set virtualedit=onemore                                          " allow for cursor beyond last character

syntax on                                                        " syntax highlighting
set hlsearch                                                     " highlight search terms
set nowrap                                                       " wrap long lines

"indentation
set autoindent
set cindent
set indentkeys-=0#            " do not break indent on #
set cinkeys-=0#
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do
set cinwords+=for,switch,case

"Obvious mode
set laststatus=2

"ruler for command line
if has('cmdline_info')
set ruler                                                        " show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)               " a ruler on steroids
set showcmd                                                      " show partial commands in status line and " selected characters/lines in visual mode
endif


"Easy tab movement
map <C-Right> <ESC>:tabnext<CR>
map <C-Left> <ESC>:tabprev<CR>
map <leader>t <Esc>:tabnew<CR>

"set the font and the shell for windows 
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monospace\ 9 
  elseif has("gui_win32")
    set guifont=Consolas:h10:cANSI
    set shell=C:/cygwin/bin/bash
    set shellcmdflag=--login\ -c
    set shellxquote=\"
  endif
endif

"setting the column 80, 90
if exists('+colorcolumn')
  nmap <C-l> :set colorcolumn=80,90<CR>
  nmap <C-r><C-l> :set colorcolumn=0<CR>
  hi ColorColumn guibg=#2d2d2d ctermbg=246
endif

"copy paste to the system clipboard
map <leader>sc "+y<CR>
map <leader>sp "+gP<CR>
map <leader>sx "+x<CR>

" Use CTRL-S for saving
noremap <C-S>      :update<CR>

"***********************************************************************************
"plugins 
"install ctags, cscope and astyle
"***********************************************************************************


"vundle settings
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'


"NerdTree 
Bundle 'scrooloose/nerdtree'
map <leader>nt :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr' , '\.o$']
let NERDTreeChDirMode=0
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=0
let NERDTreeKeepTreeInNewTab=1


"NERDCommenter
"<,><c><space>  
Bundle 'scrooloose/nerdcommenter'


"tagbar
Bundle 'majutsushi/tagbar'
nmap <leader>tl :TagbarToggle<CR>


"Syntastic
"Bundle 'scrooloose/syntastic'
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=1


"Ctrl-P
Bundle 'kien/ctrlp.vim'
set wildignore+=*.so,*.o,*.swp,*.zip

"snipmate
"Bundle 'gmarik/snipmate.vim'

"powerline
Bundle 'Lokaltog/vim-powerline'


"Fugitive
Bundle 'tpope/vim-fugitive'


"ack.vim
Bundle "mileszs/ack.vim"
"nnoremap <leader>a :Ack!<space>


"surround
Bundle 'tpope/vim-surround'

"youcompleteme
"Bundle 'Valloric/YouCompleteMe'

"clang_complete
"Bundle "Rip-Rip/clang_complete"

"let g:clang_use_library = 1

" SuperTab option for context aware completion
"let g:SuperTabDefaultCompletionType = "context"

" Disable auto popup, use <Tab> to autocomplete
"let g:clang_complete_auto = 0
" Show clang errors in the quickfix window
"let g:clang_complete_copen = 1


"colorscheme
Bundle 'nanotech/jellybeans.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tomasr/molokai'

"set the color scheme
set t_Co=256

if has('gui_running')
   set background=dark                                  
   "colorscheme molokai
   "colorscheme solarized
   colorscheme jellybeans
else
   set background=dark
   colorscheme jellybeans
endif




" cscope 
if has("cscope")
   set cscopetag
   set csto=0
   set nocscopeverbose

" add any cscope database in current directory
   if filereadable("cscope.out")
       cs add cscope.out
" else add the database pointed to by environment variable
   elseif $CSCOPE_DB != ""
       cs add $CSCOPE_DB
   endif


   "find all references"
   nmap <C-[>s :cs find s <C-R>=expand("<cword>")<CR><CR>
   "find global definitions"
   nmap <C-[>g :cs find g <C-R>=expand("<cword>")<CR><CR>
   "find functions calling this function"
   nmap <C-[>c :cs find c <C-R>=expand("<cword>")<CR><CR>
   "find assignments"
   nmap <C-[>t :cs find t <C-R>=expand("<cword>")<CR><CR>
   "egrep"
   nmap <C-[>e :cs find e <C-R>=expand("<cword>")<CR><CR>
   "open filename"
   nmap <C-[>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
   "find files that include the filename"
   nmap <C-[>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
   "find functions called by this function"
   nmap <C-[>d :cs find d <C-R>=expand("<cword>")<CR><CR>

endif

  nmap <leader>ccs :!(cd %:p:h;find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files;cscope -b -i cscope.files -f cscope.out)<CR>
  \:cs reset<CR>
  
    
"ctags
"map <leader>cct :!(cd %:p:h;ctags -R .)<CR>
map <leader>cct :!(cd %:p:h;ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .)<CR>

"Perforce work
nnoremap <leader>p4a :!p4 add %:p
nnoremap <leader>p4e :!p4 edit %:p
nnoremap <leader>p4r :!p4 revert %:p


"GVIM specific settings
set guioptions-=T guioptions-=m

"Asci style C formatting
map <leader>ft :%!astyle --mode=c --style=ansi -s2<CR>


filetype plugin indent on                                        " Automatically detect file types
