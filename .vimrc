syntax on
set bg=dark
set nu

set nowrap
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set pastetoggle=<F2>
"set spell

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
