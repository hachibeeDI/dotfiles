if exists('b:did_ftplugin_markdown')
  finish
endif
let b:did_ftplugin_markdown = 1

let g:markdown_fenced_languages = [
\  'css',
\  'erb=eruby',
\  'javascript',
\  'js=javascript',
\  'json=javascript',
\  'ruby',
\  'python',
\  'sass',
\  'xml',
\]
