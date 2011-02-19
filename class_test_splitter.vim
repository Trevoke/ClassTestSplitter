function! s:ClassTestSplitter(class_name)
  let s:class_name = a:class_name . ".rb"
  let s:test_name = a:class_name . "_test.rb"

  execute "edit " . s:class_name

  execute "normal Iclass " . a:class_name . "\<CR>end\<Esc>"
  execute "write"
  execute "vsplit " . s:test_name
  execute "normal Irequire \"test/unit\"\<CR>require \"" . s:class_name . "\"\<CR>\<CR>class " . a:class_name . "Test < Test::Unit::TestCase\<CR>  def assert_true\<CR>assert_nothing_raised { " . a:class_name . ".new }\<CR>end\<CR>end\<CR>\<Esc>"
  execute "write"
  execute "!ruby " . s:test_name
  unlet s:class_name s:test_name
endfunction

command! -nargs=1 ClassTestSplitter call s:ClassTestSplitter(<f-args>)
