set nocp
set showmatch
set ts=4
set shiftwidth=4
set expandtab

" " pathogen
" execute pathogen#infect()

set background=dark

set autoindent
" set smartindent
filetype on
filetype plugin indent on
syntax on
" set cindent
set mouse=a
"set ttymouse=xterm2
let loaded_matchparen = 1
set encoding=utf8
set fileencoding=utf8

" set foldmethod=syntax
let php_folding=1
let javaScript_folding=1

"tip 14
set nohlsearch
" tip 15
set laststatus=2
" tip 22
command! Q  quit
command! W  write
command! Wq wq
" tip 34
se splitbelow
se splitright
" tip 598
set keywordprg=~/bin/php_doc

if has("unix")
    map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif

" tip 91
set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words

" " tip 102
" function InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<tab>"
"     else
"         return "\<c-p>"
"     endif
" endfunction
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>


"function! CleverTab()
"    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"        return "\<Tab>"
"    else
"        return "\<C-N>"
"endfunction
"inoremap <Tab> <C-R>=CleverTab()<CR>

" tip 64
map ,cd :cd %:p:h<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Fix <alt-> mappings when not in xterm
"" http://stackoverflow.com/a/10216459/677022
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set ttimeout ttimeoutlen=50

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" http://www.reddit.com/r/vim/comments/kz84u/what_are_some_simple_yet_mindblowing_tweaks_to/
"" move a line of text using ALT+[jk], indent with ALT+[hl]
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
nnoremap <A-h> <<
nnoremap <A-l> >>
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
inoremap <A-h> <Esc><<`]a
inoremap <A-l> <Esc>>>`]a
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv
vnoremap <A-h> <gv
vnoremap <A-l> >gv
nnoremap <A-S-l> viwxp`[v`]
nnoremap <A-S-h> viwxhhp`[v`]
inoremap <A-S-l> <Esc>viwxp`[v`]
inoremap <A-S-h> <Esc>viwxhhp`[v`]
vnoremap <A-S-l> xp`[v`]
vnoremap <A-S-h> xhhp`[v`]

" start scrolling when within 5 lines near the top/bottom
set scrolloff=5

" allow freeform selection (i.e. ignoring line endings) in visual block mode
set virtualedit+=block

map <F6> :b#<CR>
set pastetoggle=<F9>
map <F10> :!make<CR>
map <F11> :!make complete<CR>

" " maps for xpdf
" map <S-F10> :!make<CR><CR><ESC> :!xpdf -remote fromvim -reload <CR><CR>
" map <F8> :!xpdf -remote fromvim informe.pdf >& /dev/null &<CR><CR>
" map <F5> :!xpdf -remote fromvim -reload <CR><CR>
" map <C-Left> :!xpdf -remote fromvim -exec pageUp <CR><CR>
" map <C-Right> :!xpdf -remote fromvim -exec pageDown <CR><CR>
" map <C-Up> :!xpdf -remote fromvim -exec "gotoPage(1)" <CR><CR>
" map <C-Down> :!xpdf -remote fromvim -exec gotoLastPage <CR><CR>

" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

if has('gui_running')
    set guioptions-=T
    colorscheme desert
    if has("gui_gtk2")
        " set guifont=DejaVu\ Sans\ Mono\ 8
        set guifont=Fixed\ Medium\ Semi-Condensed\ 10
    elseif has("gui_win32")
        set guifont=Consolas:h8:cANSI
    endif
endif

let g:vim_json_syntax_conceal = 0
com! FormatJSON %!python -m json.tool

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Supress italics and bold in LaTeX display.
hi clear texItalStyle
hi clear texBoldStyle
hi def link markdownItalic              NONE
hi def link markdownItalicDelimiter     NONE
hi def link markdownBold                NONE
hi def link markdownBoldDelimiter       NONE
hi def link markdownBoldItalic          NONE
hi def link markdownBoldItalicDelimiter NONE

let g:netrw_banner       = 0
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 3        " make netrw display a tree view
let g:netrw_sort_options = 'i'

let mapleader=','

set number
set cursorline
highlight LineNr ctermfg=white ctermbg=DarkGrey guifg=white guibg=DarkGrey
highlight GitGutterAdd          ctermbg=DarkGrey ctermfg=green  guifg=green  cterm=bold gui=bold
highlight GitGutterChange       ctermbg=DarkGrey ctermfg=yellow guifg=yellow cterm=bold gui=bold
highlight GitGutterDelete       ctermbg=DarkGrey ctermfg=red    guifg=red    cterm=bold gui=bold
highlight GitGutterChangeDelete ctermbg=DarkGrey ctermfg=yellow guifg=yellow cterm=bold gui=bold

highlight clear CursorLine
highlight CursorLineNR cterm=bold ctermbg=yellow ctermfg=DarkGrey

source ~/.vimrc-plug

colorscheme solarized8

au BufNewFile,BufRead *.hql set filetype=hive expandtab
au BufNewFile,BufRead *.q set filetype=hive expandtab
