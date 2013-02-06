" detect filetype before default filetype detectation.

if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.vb setfiletype vbnet
augroup END

" vim:sw=2
