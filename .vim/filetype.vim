" detect filetype before default filetype detectation.

if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.vb setfiletype vbnet
  au BufRead,BufNewFile *.scss set filetype=scss
  au BufRead,BufNewFile *.go set filetype=go
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
  au BufRead,BufNewFile Gruntfile set filetype=javascript
augroup END

" vim:sw=2
