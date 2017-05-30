require 'mkmf'
unless find_executable('phantomjs')
    if find_executable('brew')
      run 'brew install phantomjs'
      run 'rm mkmf.log'
    else
      say snippet('missing_phantom_js_message.txt')
    end
end
