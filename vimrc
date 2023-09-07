" Vundle {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
if has("win32") || has("win64")
  if has("nvim")
    set rtp+=~/AppData/Local/nvim/bundle/Vundle.vim
  else
    set rtp+=~/.vim/bundle/Vundle.vim
  endif
else
  set rtp+=~/.vim/bundle/Vundle.vim
endif

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'easymotion/vim-easymotion'
Plugin 'will133/vim-dirdiff'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'yegappan/taglist'
Plugin 'romainl/Vim-cool'
Plugin 'junegunn/fzf.vim'
call vundle#end()
filetype plugin indent on
source /usr/share/doc/fzf/examples/fzf.vim
" }}}

" General {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocp
set nobk
set ffs=unix,dos,mac
set history=500
set iskeyword+=-

let mapleader = ","
let g:mapleader = ","
" }}}

" UI {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set lsp=0
set wildmenu
set wildmode=list:longest
set ru
let halfcols = &columns / 2
exe 'set ruf=%'. halfcols .'(%f\ %m%=%l,%c%V\ %P%)'
set backspace=2
"set so=5
set magic


set noerrorbells
set novisualbell
set t_vb=
set t_ti= t_te=
" }}}

" Theme, Colors, Formatting, Layout {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set bg=dark
try
  let g:lucius_no_term_bg=1
  let g:lucius_contrast='low'
  colorscheme lucius
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

set t_Co=256

set hls
set is
set wrap
set ai
set si
set cin
set tw=80
set smarttab
set fo=tcroqnl
set cinoptions=:0,l1,t0,g0
set listchars+=tab:^-

set ts=8
set sw=8
set sts=0
set noexpandtab

fu! TabToggle()
  if &expandtab
    set sw=8
    set sts=0
    set noexpandtab
  else
    set sw=4
    set sts=4
    set expandtab
  endif
endfu
" }}}

" Files, Backups {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile
set hid
set dict=/usr/share/dict/words
" }}}

" Mappings, Abbreviations {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Up> gk
map k gk
imap <Up> <C-o>gk
map <Down> gj
map j gj
imap <Down> <C-o>gj

imap kj <Esc>
nmap <leader>h :let &hlsearch = !&hlsearch<CR>
nmap <leader>bb :e#<CR>
nmap <leader>f :FZF<CR>
"nmap <leader>n :echo "strlen(".expand("<cword>").")=".strlen(expand("<cword>"))<CR>
nmap <leader>s :ConqueTerm bash<cr>
"nmap <leader>t :call <SID>ToggleCsto()<CR>
nmap <leader>t :FufTag<CR>
nmap <leader>q :call <SID>ToggleQf()<CR>
nmap <leader>u :call <SID>ToggleHex()<CR>
nmap <leader>w <Plug>(easymotion-bd-W)
nmap <leader>x :call NERDComment(0, "toggle")<CR>
nmap <leader>y :YRShow<CR>
nmap <F8> :TlistToggle<CR>
nmap <F9> :let &cul = !&cul<CR>
set pt=<F10>
nmap <F11> :let &list = !&list<CR>
nmap <F12> mz:execute TabToggle()<CR>'z
" }}}

" Plugin Settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:VCSCommandMapPrefix = ",v"
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSplitOutPathName=0
let g:DirDiffExcludes="CVS,.svn,.git,.*cmd,*.o"
let g:DirDiffIgnore = "Id:,Revision:,Date:"
let g:DirDiffAddArgs = "-w"
let g:cool_total_matches = 1
" }}}

" Ctags, Cscope {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let tagfiles = glob("`find ~/.vim/bundle/ -name tags -print`")
let &tags = substitute(tagfiles, "\n", ",", "g")

set tags+=./tags,./TAGS,tags;~,TAGS:~

if glob("~/.vim/doc/*") != ""
  helptags ~/.vim/doc
  set tags+=~/.vim/doc/tags
en

fu! s:MyCsAdd(file)
  let path = findfile(a:file, ".;")
  if path != ''
    exe 'cs add' path
  else
"    echo a:file "not found"
  endif
endf

"fu! s:ToggleCsto()
  "if &csto == '0'
    "set csto=1
    "echo "set csto=1 (tags first)"
  "else
    "set csto=0
    "echo "set csto=0 (cscope first)"
  "endif
"endf

if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set nocsverb
  if filereadable("cscope.out")
    cs add cscope.out
  else
    call <SID>MyCsAdd("cscope.out")
  endif
  set csverb

  nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
endif
" }}}

" Functions {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fu! s:ToggleQf()
  for i in range(1, winnr('$'))
    let bnum = winbufnr(i)
    if getbufvar(bnum, '&buftype') == 'quickfix'
      ccl
      return
    endif
  endfor
  cope
endf

fu! s:ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfu
" }}}

" Auto commands {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead *.[chxsS] nmap <C-]> :exe "tj ".expand("<cword>")<CR>
au Syntax asm runtime! ~/.vim/syntax/gas.vim
" }}}

" vim: set fdm=marker:
