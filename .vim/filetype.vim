" detect filetype before default filetype detectation.

if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.vb setfiletype vbnet
  au BufRead,BufNewFile *.scss set filetype=scss
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END

" vim:sw=2
