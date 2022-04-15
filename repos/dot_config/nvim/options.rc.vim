syntax on
set shiftwidth=4
set t_Co=256
set background=dark
set cursorline
set cursorcolumn
set laststatus=2
set hls
set expandtab
set number
set ignorecase
set smartcase
set smartindent

colorscheme hybrid

hi Normal ctermbg=none
hi CursorLineNr ctermbg=4 ctermfg=none
hi CursorLine ctermbg=0 ctermfg=none
hi Normal ctermbg=none ctermfg=255
hi Comment ctermbg=none ctermfg=246
hi LineNr ctermbg=none ctermfg=246
hi Visual ctermbg=242 guibg=242
hi Search ctermbg=31 ctermfg=white
hi MatchParen cterm=bold ctermbg=none ctermfg=blue

let &t_SI = "\e]50;CursorShape=1\x7"
let &t_EI = "\e]50;CursorShape=0\x7"

autocmd MyAutoCmd FileType vue set sw=2
autocmd MyAutoCmd FileType typescript set sw=2
autocmd MyAutoCmd FileType ruby set sw=2
autocmd BufRead,BufNewFile *.jbuilder set ft=ruby
