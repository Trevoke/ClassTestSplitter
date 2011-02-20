function! Capitalize(word)
  let s:new_word = substitute(a:word, "\\w\\+", "\\u\\0", "g")
  return s:new_word
endfunction

function! Lowercase(word)
  let s:new_word = substitute(a:word, "\\w\\+", "\\l\\0", "g")
  return s:new_word
endfunction

function! ClassTestSplitter(class_name)
  let s:lowercase_class = Lowercase(a:class_name)
  let s:upcase_class = Capitalize(a:class_name)
  let s:classfile_name = s:lowercase_class . ".rb"
  let s:testfile_name = s:lowercase_class . "_test.rb"

  execute "edit " . s:classfile_name

  execute "normal Iclass " . s:upcase_class . "\<CR>end\<Esc>"
  execute "write"
  execute "vsplit " . s:testfile_name
  execute "normal Irequire 'test/unit'\<CR>require '" . s:classfile_name . "'\<CR>\<CR>class " . s:upcase_class . "Test < Test::Unit::TestCase\<CR>  def assert_true\<CR>assert_nothing_raised { " . s:upcase_class . ".new }\<CR>end\<CR>end\<CR>\<Esc>"
  execute "write"
  execute "!ruby " . s:testfile_name
  unlet s:classfile_name s:testfile_name s:lowercase_class s:upcase_class
endfunction

command! -nargs=1 ClassTestSplitter call ClassTestSplitter(<f-args>)
