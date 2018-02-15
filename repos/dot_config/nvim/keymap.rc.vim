vnoremap > >gv
vnoremap < <gv

" 編集モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [ []<Left>
inoremap <C-w> <C-o>w
inoremap <C-b> <C-o>b

" tabページ
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap fn :<C-u>tabnew<CR>
nnoremap fw :<C-u>q<CR>
nnoremap fo :<C-u>tabo<CR>:<C-u>q<CR>

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

nnoremap <Space>q :set number!<CR>
