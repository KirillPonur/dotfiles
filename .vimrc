"Author:    Kirill Ponur    
"GitHub:    https://github.com/KirillPonur/dotfiles
"Date:      %current_date%
"------------------------------------------------------------
" 1. Plugins
"------------------------------------------------------------

call plug#begin('~/.vim/plugged')


Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"for first running: pip install unidecode                        
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips",$HOME."/.vim/"]

Plug 'airblade/vim-gitgutter'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
"let g:session_directory = $VIM . '/vimfiles/sessions'

Plug 'scrooloose/nerdcommenter'
filetype plugin on

Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
let g:vimtex_complete_enabled=1
set conceallevel=2
let g:tex_conceal="abdgm"

let g:vimtex_view_method = 'mupdf'
let g:vimtex_view_general_viewer = 'mupdf'
let g:XkbSwitchLib=$HOME."/.vim/libxkbswitch.so"
Plug 'lyokha/vim-xkbswitch'
    "Plug 'DeXP/xkb-switch-win'


Plug 'thinca/vim-fontzoom'
Plug 'crusoexia/vim-monokai'


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree'
call plug#end()

"------------------------------------------------------------
" 2. Language and encoding
"------------------------------------------------------------
" Change menu language of Vim to English
set langmenu=en_US.UTF-8  
lan mes en_US.UTF-8 
let $LANG = 'en_US.UTF-8  '
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

"------------------------------------------------------------
" 3. Features
"------------------------------------------------------------
set noeb vb t_vb =
" Russian and English spellchecking
" set spell spelllang=ru,en_us

" Reload .vimrc when saving
"autocmd BufWritePost .vimrc source $MYVIMRC
" Enable syntax highlighting
syntax on
" Line numbering 
set number

"set showmatch 
"set hlsearch
"set incsearch
"set ignorecase


colorscheme monokai
set termguicolors
set t_Co=256
" Conceal for monokai
hi clear Conceal
hi Conceal guifg='#8EC9F2'
if has("gui_running")
  if has('win32')
    set guifont=Consolas:h13:cANSI
  endif
  if has('unix')
    "set guifont=Droid\ Sans\ Mono
    set guifont=Monospace\ 12
  endif
endif

" Tab size
set tabstop=4
" Converting tabs to spaces
set expandtab
set shiftwidth=4
" Newline tab size

" Line break instead word wrap 
set wrap linebreak nolist

"------------------------------
" 3.1. Statusbar settings
"------------------------------
let g:airline_extensions = ['vimtex','tabline','xkblayout']

let g:airline#extensions#vimtex#enabled = 1
let g:airline#extensions#tabline#enabled = 1
"if !exists('g:airline_symbols')
""    let g:airline_symbols = {}
"endif

let g:airline_theme='minimalist'
let g:airline_section_c = []
"let g:airline_symbols.maxlinenr = ' ln '
let g:airline#extensions#tabline#formatter = 'jsformatter'


let g:airline_detect_spell=0
let g:airline_detect_spelllang=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=0

"------------------------------
" 3.2. GUI settings           
"------------------------------

" Remove toolbar
set guioptions-=T
" Remove menu bar
set guioptions-=m 
" Remove right-hand scroll bar
set guioptions-=r  
set guioptions-=L
set guiheadroom=0
set guioptions-=e
"------------------------------
" 3.3. Session Settings       
"------------------------------

let g:session_default_to_last = 1
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
" Autosave period in minutes 
let g:session_autosave_periodic = 1
let g:session_autosave_silent = 1


"------------------------------------------------------------
"4. Map definitions (Key bindings)                                   
"------------------------------------------------------------

" Swap lines up and down
nnoremap <silent> <c-s-j> :call <SID>swap_up()<CR>
nnoremap <silent> <c-s-k> :call <SID>swap_down()<CR>

" Return to last mistake and fix it
" <C-l>==<Ctrl+L> 
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
nnoremap <C-l> i<c-g>u<Esc>[s1z=`]a<c-g>u<Esc>

"nnoremap <silent> <C-o> :browse confirm e <CR>
nnoremap <silent> <C-o> :NERDTreeToggle "expand('%:p:h')"<CR>
nnoremap <silent> <C-b> :call Compile() <CR>
nnoremap <localleader>env :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")') <CR>

"  map <F11> <Esc>:call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)<CR>:set guioptions-=m <CR>
"------------------------------------------------------------
"5.TeX Settings                                             
"------------------------------------------------------------
" Russian and English spellchecking
autocmd BufNewFile,BufRead *.tex setlocal spell spelllang=ru,en_us
augroup TeXautocmd
  autocmd!
  autocmd BufNewFile,BufRead *.tex EnableXkbSwitch
  autocmd CursorMovedI *.tex call ToggleLangMap()
  autocmd CursorHoldI  *.tex call ToggleLangMap()
  autocmd InsertEnter  *.tex call ToggleLangMap()
  "autocmd InsertLeave  *.tex call ToggleLangMap()
  "autocmd TextChangedI *.tex call ToggleLangMap()
augroup END

augroup VimRCautocmd
    autocmd!
    autocmd BufWritePost .vimrc source ~/.vimrc 
augroup END


"------------------------------
"5.1. Autochange keyboard layout
"------------------------------
"begin{ToggleLangMap}


"let g:airline_section_c = 'was_ru=%{g:was_ru}, iminsert=%{&iminsert}, layout=%{g:lay}'

function! ReturnToVim()
  call remote_foreground(v:servername)
endfunction


let g:was_ru = 2
let g:lay = libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
"0 -- If when entered math mode language was English
"1 -- If when entered math mode language was Russian
"2 -- Language not detected 

function! Layout(lang)
  call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', a:lang)
endfunction

function! RememberLayout()
  if g:was_ru == 2
    if g:lay != 'us'
      let g:was_ru = 1
    elseif g:lay == 'us'
      let g:was_ru = 0
    endif
  endif
endfunction

function! SwitchLayout()
  if g:was_ru==1
      call Layout('ru')
      let g:was_ru=2
  elseif g:was_ru==0
      call Layout('us')
      let g:was_ru=2
  endif

endfunction!

function! ToggleLangMap()
  let l:mathmode = vimtex#util#in_mathzone()
  let l:mathtext = vimtex#util#in_syntax('texMathText')
  let g:lay = libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')

  if mode()=='i'
    if l:mathmode == 1 
      call RememberLayout()
      if l:mathtext == 0
        call Layout('us')
      elseif l:mathtext == 1
        call SwitchLayout()
      endif
    else   
      call SwitchLayout()
    endif
  endif 


endfunction
"end{ToggleLangMap}
"------------------------------------------------------------

function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction



