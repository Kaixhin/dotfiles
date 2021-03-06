" Use Vim settings, rather than Vi settings
" This must be first because it changes other options as a side effect
set nocompatible

" On Windows, also use '.vim' instead of 'vimfiles'
" This makes synchronization across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Use Pathogen to load all plugins in ~/.vim/bundle
call pathogen#infect()
call pathogen#helptags()

" --- General configuration ---
" Show file title
set title
" Show line numbers
set number
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Show incomplete commands at the bottom
set showcmd
" Show current mode at the bottom
set showmode
" Disable cursor blink
set gcr=a:blinkon0
" Reload files changed outside of Vim
set autoread
" Allow buffers to exist in the background (without being in a window)
set hidden
" Turn on syntax highlighting
syntax on
" Turn off swap files
set noswapfile
" Disable viminfo
set viminfo=

" --- Search settings ---
" Find the next match as search is typed out
set incsearch
" Highlight search matches
set hlsearch
" Use case-sensitive searching only if there is uppercase in the search term
set ignorecase
set smartcase

" --- Indentation ---
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Load filetype plugins and indentation
filetype plugin indent on
" Rewrite Python indentation
autocmd FileType python setlocal shiftwidth=2 softtabstop=2 tabstop=2
" Associate .conf files with the DOS/Windows ini filetype
au BufRead,BufNewFile *.conf setfiletype dosini

" Wrap lines
set wrap
" Wrap lines at convenient points
set linebreak
" Show a break at 120 characters
set colorcolumn=120

" --- Completion ---
" Show list of command completion options
set wildmenu
set wildmode=list:longest

" --- Scrolling ---
" Start scrolling when 8 lines away from the margin
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" --- Plugins ---
" Use Solarized
syntax enable
set background=dark
colorscheme solarized

let g:python_highlight_all = 1
" Use Syntastic
let g:syntastic_mode_map = {'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html']}
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']
" Use jshint (uses ~/.jshintrc)
let g:syntastic_javascript_checkers = ['jshint']

" --- GUI + Scripts —-—
if has('gui_running')
  if has('win32') || has('win64')
    " Windows
    set guifont=Source_Code_Pro:h12
  else
    if has("unix")
      let s:uname = system("uname")
      if s:uname == "Darwin\n"
        " OS X
        set guifont=Source\ Code\ Pro:h14
        
        " Run ./build.sh with F5
        nnoremap <F5> <esc>:!cd $(cd "$(dirname "%")" && pwd -P); ./build.sh<enter><enter>
        inoremap <F5> <esc>:!cd $(cd "$(dirname "%")" && pwd -P); ./build.sh<enter><enter>
      else
        " Linux
        set guifont=Source\ Code\ Pro\ Medium\ 14

        nnoremap <F5> <esc>:!cd $(dirname $(readlink -m %)); ./build.sh<enter><enter>
        inoremap <F5> <esc>:!cd $(dirname $(readlink -m %)); ./build.sh<enter><enter>
      endif
    endif
  endif
endif

" --- Unicode Support ---
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
