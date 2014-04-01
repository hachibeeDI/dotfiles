" detect filetype before default filetype detectation.

if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  autocmd BufRead,BufNewFile *.vb setf vbnet
  " markdown
  autocmd BufRead,BufNewFile *.md setf markdown
  autocmd BufRead,BufNewFile *.mkd setf markdown
augroup END

" vim:sw=2
