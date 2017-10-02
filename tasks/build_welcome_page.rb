generate :controller, 'Welcome', 'index'
route "root to: 'welcome#index'"
copy_file 'app/views/welcome/index.html.erb', force: true
directory 'app/views/devise'
