" Maintainer:   OGURA_Daiki <8hachibee125@gmail.com>
" URL:          https://github.com/hachibeeDI

let g:colors_name = expand('<sfile>:t:r')
set background=dark
highlight clear


highlight Normal       guifg=#fafafa guibg=#210c14

" highlight groups
highlight Cursor       guibg=khaki guifg=slategrey
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
highlight VertSplit    guibg=#c2bfa5 guifg=grey50 gui=none
highlight Folded       guibg=grey30 guifg=gold
highlight FoldColumn   guibg=grey30 guifg=tan
highlight IncSearch    guifg=slategrey guibg=khaki
highlight LineNr       guifg=#e6e2e1 guibg=#15010c gui=NONE ctermfg=180 cterm=NONE
highlight MatchParen   guifg=cyan guibg=NONE gui=bold ctermfg=51 cterm=bold
highlight ModeMsg      guifg=goldenrod
highlight MoreMsg      guifg=SeaGreen
highlight Pmenu        guifg=white guibg=#445599 gui=NONE ctermfg=231 ctermbg=61 cterm=NONE
highlight PmenuSel     guifg=#445599 guibg=gray ctermfg=61 ctermbg=250
highlight NonText      guifg=LightBlue guibg=#210c14
highlight Question     guifg=springgreen
highlight Search       guibg=peru guifg=wheat
highlight SpecialKey   guifg=yellowgreen
highlight StatusLine   guibg=#c2bfa5 guifg=black gui=none
highlight StatusLineNC guibg=#c2bfa5 guifg=grey50 gui=none
highlight Title        guifg=indianred
highlight Visual       gui=none guifg=khaki guibg=olivedrab
highlight WarningMsg   guifg=salmon
highlight colorcolumn  guibg=gray30 ctermbg=240
highlight WildMenu     guifg=gray guibg=gray17 gui=NONE ctermfg=250 ctermbg=235 cterm=NONE
" e.g. line-break
highlight NonText      guibg=NONE guifg=DarkGreen
" e.g. Tab
highlight SpecialKey   guibg=NONE guifg=#363636
"hi Menu
"hi Scrollbar
"hi Tooltip

" syntax highlighting groups
highlight Comment      gui=none guifg=SkyBlue
highlight Constant     gui=none guifg=#ffa0a0
highlight Identifier   gui=none guifg=palegreen
highlight Function     gui=NONE guifg=skyblue ctermfg=117 cterm=NONE
highlight Statement    gui=none guifg=khaki
highlight PreProc      gui=none guifg=indianred
highlight Type         gui=none guifg=#20aab9
highlight Special      gui=none guifg=navajowhite
"hi Underlined
highlight Ignore       guifg=grey40
"hi Error
highlight Todo         guifg=orangered guibg=yellow2

" " color terminal definitions
" hi SpecialKey   ctermfg=darkgreen
" hi NonText      cterm=bold ctermfg=darkblue
" hi Directory    ctermfg=darkcyan
" hi ErrorMsg     cterm=bold ctermfg=7 ctermbg=1
" hi IncSearch    cterm=NONE ctermfg=yellow ctermbg=green
" hi Search       cterm=NONE ctermfg=grey ctermbg=blue
" hi MoreMsg      ctermfg=darkgreen
" hi ModeMsg      cterm=NONE ctermfg=brown
" hi LineNr       ctermfg=3
" hi Question     ctermfg=green
" hi StatusLine   cterm=bold,reverse
" hi StatusLineNC cterm=reverse
" hi VertSplit    cterm=reverse
" hi Title        ctermfg=5
" hi Visual       cterm=reverse
" hi WarningMsg   ctermfg=1
" hi WildMenu     ctermfg=0 ctermbg=3
" hi Folded       ctermfg=darkgrey ctermbg=NONE
" hi FoldColumn   ctermfg=darkgrey ctermbg=NONE
" hi DiffAdd      ctermbg=4
" hi DiffChange   ctermbg=5
" hi DiffDelete   cterm=bold ctermfg=4 ctermbg=6
" hi DiffText     cterm=bold ctermbg=1
" hi Comment      ctermfg=darkcyan
" hi Constant     ctermfg=brown
" hi Special      ctermfg=5
" hi Identifier   ctermfg=6
" hi Statement    ctermfg=3
" hi PreProc      ctermfg=5
" hi Type         ctermfg=2
" hi Underlined   cterm=underline ctermfg=5
" hi Ignore       cterm=bold ctermfg=7
" hi Ignore       ctermfg=darkgrey
" hi Error        cterm=bold ctermfg=7 ctermbg=1


"vim: sw=4
