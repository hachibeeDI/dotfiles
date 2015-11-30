" detect filetype before default filetype detectation.

if exists("g:did_load_filetypes")
  finish
endif

augroup filetypedetect
  autocmd BufRead,BufNewFile *.vb setf vbnet
  " markdown
  autocmd BufRead,BufNewFile *.md setf markdown
  autocmd BufRead,BufNewFile *.mkd setf markdown
  " Objective-C
  autocmd BufRead,BufNewFile *.m setf objc

  autocmd BufRead,BufNewFile .eslintrc setf json
augroup END

" vim:sw=2
