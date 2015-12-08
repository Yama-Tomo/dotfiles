set tabstop=4
set shiftwidth=4
set number
set noendofline
set binary
set lazyredraw
set ttyfast
set nocompatible
set backspace=indent,eol,start
set expandtab
set autoindent
set wildmenu
set ambiwidth=double

set grepprg=grep\ -nH
autocmd InsertLeave * set nopaste
autocmd QuickFixCmdPost *grep* cwindow

vnoremap > >gv
vnoremap < <gv

" 編集モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [ []<Left>

" tabページ
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap fn :<C-u>tabnew<CR>
nnoremap fw :<C-u>q<CR>

" window分割
nnoremap fs :<C-u>sp<CR>
nnoremap fv :<C-u>vs<CR>
nnoremap fj <C-w>j
nnoremap fk <C-w>k
nnoremap fl <C-w>l
nnoremap fh <C-w>h
nnoremap ( <C-w><
nnoremap ) <C-w>>
nnoremap + <C-w>+
nnoremap - <C-w>-

" ESC代用
inoremap <silent> jj <ESC>

hi DiffAdd    ctermfg=black ctermbg=2
hi DiffChange ctermfg=black ctermbg=3
hi DiffDelete ctermfg=black ctermbg=6
hi DiffText   ctermfg=black ctermbg=7

:source $VIMRUNTIME/macros/matchit.vim

if 1
  "############### NeoBundle ###############
  filetype plugin indent off
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle'))
  
  NeoBundleFetch 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'w0ng/vim-hybrid'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'itchyny/lightline.vim'
  NeoBundle 'tpope/vim-fugitive'

  if executable('ctags')
    NeoBundle 'vim-scripts/taglist.vim'
    NeoBundle 'szw/vim-tags'
  endif

  if version >= 704
    NeoBundle 'Shougo/unite.vim'
    NeoBundle "Shougo/vimproc"
    NeoBundle "thinca/vim-quickrun"
    NeoBundle "osyo-manga/shabadou.vim"
    NeoBundle "osyo-manga/vim-watchdogs"
    NeoBundle 'KazuakiM/vim-qfsigns'
    NeoBundle "jceb/vim-hier"
    NeoBundle 'easymotion/vim-easymotion'
    NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
  endif

  call neobundle#end()
  filetype plugin indent on
 
  "############### basic setting ###############
  syntax on
  set t_Co=256
  colorscheme hybrid
  set cursorline
  set cursorcolumn
  set laststatus=2
  if version >= 704
    " 行のハイライト
    hi CursorLineNr ctermbg=4 ctermfg=none
    hi CursorLine ctermbg=232 ctermfg=none
    hi Normal ctermbg=none ctermfg=255
    hi Comment ctermbg=none ctermfg=246
    hi LineNr ctermbg=none ctermfg=246
    hi Visual ctermbg=242 guibg=242
    hi Search ctermbg=167 ctermfg=white
  endif
 
  " for Smarty template file.
  au BufNewFile,BufRead *.tpl :source $VIMRUNTIME/ftplugin/html.vim
  au BufNewFile,BufRead *.tpl let b:match_words .= ',{\s*if\>:{\s*elseif\>:{\s*else\>:{\s*/if\>,{\s*foreach\>:{\s*foreachelse\>:{\s*/foreach\>'

  nnoremap <silent> <space>e :NERDTreeToggle<CR>
  nnoremap <silent> <space>n :NERDTreeFind<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  
  " load ctags
  if filereadable(expand('.git/tags'))
    set tags+=.git/tags
  endif
  
  " pasteした時にインデントさせない bracketed paste mode 対応のターミナルしか対応してない
  if &term =~ "xterm"
    let &t_SI .= "\eP\e[?2004h\e\\"
    let &t_EI .= "\eP\e[?2004l\e\\"
    let &pastetoggle = "\e[201~"

    function! _yamatomo_XTermPasteBegin(ret)
      set paste
      return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ _yamatomo_XTermPasteBegin("")
  endif

  if executable('ctags')
    let Tlist_Show_One_File = 1
    let Tlist_Use_Right_Window = 1
    let Tlist_Exit_OnlyWindow = 1
    map <silent> <Space>t :TlistToggle<CR>
    let g:tlist_php_settings = 'php;c:class;d:constant;f:function'
    nnoremap <space>] :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>
  endif

  let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename'
    \ },
  \ }
  
  function! LightLineModified()
    if &filetype == "help"
      return ""
    elseif &modified
      return "+"
    elseif &modifiable
      return ""
    else
      return ""
    endif
  endfunction
  
  function! LightLineReadonly()
    if &filetype == "help"
      return ""
    elseif &readonly
      return "(ro)"
    else
      return ""
    endif
  endfunction
  
  function! LightLineFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
  endfunction
  
  function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
         \ ('' != expand('%:p') ? expand('%:p') : '[No Name]') .
         \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
  endfunction


  "############### easyMotion ###############
  if version >= 704
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
    let g:EasyMotion_grouping=1
    let g:EasyMotion_smartcase = 1
    vmap t <Plug>(easymotion-s2)
    nmap t <Plug>(easymotion-s2)
    vmap T <Plug>(easymotion-t2)
    nmap T <Plug>(easymotion-t2)
    nmap g/ <Plug>(easymotion-sn)
    map m <Plug>(easymotion-bd-fl)
    map M <Plug>(easymotion-bd-tl)
    map <Space>j <Plug>(easymotion-j)
    map <Space>k <Plug>(easymotion-k)
"  " easy-motionのトレーニング
"  function! StartEMTraining ()
"    noremap h <Nop>
"    noremap j <Nop>
"    noremap k <Nop>
"    noremap l <Nop>
"  endfunction
"  
"  " easy-motionのトレーニング解除
"  " ＿人人人人人人人＿
"  " ＞　非推奨！！　＜
"  " ￣Y^Y^Y^Y^Y^Y￣
"  function! StopEMTraining ()
"    nnoremap h <Left>
"    nnoremap j gj
"    nnoremap k gk
"    nnoremap l <Right>
"  endfunction
"  
"  command! StartEMTraining call StartEMTraining()
"  command! StopEMTraining call StopEMTraining()
"  
"  " デフォルトはトレーニングモード"
"  call StartEMTraining()
  endif

  "############### Unite ###############
  if version >= 704
    let g:unite_source_history_yank_enable =1
    let g:unite_source_file_mru_limit = 200
    nmap <Space> [unite]
    nnoremap <silent> [unite]h :<C-u>Unite file_mru<CR>
    nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
    nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
    nnoremap <silent> [unite]l :<C-u>Unite tab<CR>
"    nnoremap <silent> [unite]uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"    nnoremap <silent> [unite]ur :<C-u>Unite -buffer-name=register register<CR>
"    nnoremap <silent> [unite]uu :<C-u>Unite buffer file_mru file<CR>
  endif

  "############### syntax check ###############
  if version >= 704
    let g:quickrun_config = {
    \    '_' : {
    \        'hook/close_buffer/enable_failure':    1,
    \        'hook/close_buffer/enable_empty_data': 1,
    \        'runner':                              'vimproc',
    \        'runner/vimproc/updatetime':           40,
    \        'outputter':                           'multi:buffer:quickfix',
    \        'outputter/buffer/close_on_empty':     1,},
    \    'watchdogs_checker/_' : {
    \        'hook/close_quickfix/enable_exit':           1,
    \        'hook/back_window/enable_exit':              0,
    \        'hook/back_window/priority_exit':            1,
    \        'hook/quickfix_status_enable/enable_exit':   1,
    \        'hook/quickfix_status_enable/priority_exit': 2,
    \        'hook/qfsigns_update/enable_exit':           1,
    \        'hook/qfsigns_update/priority_exit':         3,
    \        'hook/qfstatusline_update/enable_exit':      1,
    \        'hook/qfstatusline_update/priority_exit':    4,},
    \} 
 
    let g:qfsigns#AutoJump = 1
    let g:watchdogs_check_BufWritePost_enable = 0
    let g:watchdogs_check_BufWritePost_enables = {
    \   'php' : 1,}
    let g:watchdogs_check_CursorHold_enable = 0
    let g:watchdogs_check_CursorHold_enables = {
    \   'php' : 1,}
  endif

  "############### neocomplcache ###############
  if version >= 704
    if neobundle#is_installed('neocomplete')
      let g:acp_enableAtStartup = 0
      let g:neocomplete#enable_at_startup = 1
      let g:neocomplete#enable_smart_case = 1
      let g:neocomplete#sources#syntax#min_keyword_length = 3
      let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

      " Define dictionary.
      let g:neocomplete#sources#dictionary#dictionaries = {
          \ 'default' : ''
      \ }

      imap <expr><up> neocomplete#cancel_popup() . "\<up>"
      imap <expr><down> neocomplete#cancel_popup() . "\<down>"
      imap <expr><left> neocomplete#cancel_popup() . "\<left>"
      imap <expr><right> neocomplete#cancel_popup() . "\<right>"
      imap <expr><C-l> neocomplete#cancel_popup() . "\<right>"

      inoremap <expr><C-g>  neocomplete#cancel_popup()
      inoremap <expr><nul>  pumvisible() ? "\<C-n>" : neocomplete#start_manual_complete()
      inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
      inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>" 

      " <CR>: close popup and save indent.
      inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
      function! s:my_cr_function()
        return neocomplete#smart_close_popup() . "\<CR>"
      endfunction
    elseif neobundle#is_installed('neocomplcache')
      let g:acp_enableAtStartup = 0
      let g:neocomplcache_enable_at_startup = 1
      let g:neocomplcache_enable_smart_case = 1
      let g:neocomplcache_min_syntax_length = 3
      let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

      " Define dictionary.
      let g:neocomplcache_dictionary_filetype_lists = {
          \ 'default' : ''
      \ }

      inoremap <expr><C-g>     neocomplcache#undo_completion()

      " <CR>: close popup and save indent.
      inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
      function! s:my_cr_function()
        return neocomplcache#smart_close_popup() . "\<CR>"
      endfunction

      inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
      inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>" 
      inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
      inoremap <expr><C-y>  neocomplcache#close_popup()
    endif
  endif
  
endif
