inside 'app/views/layouts' do
  insert_into_file 'application.html.erb',
    snippet('views/app_layout/meta_tags.html.erb').chomp,
    after: '<%= csrf_meta_tags %>'

  gsub_file 'application.html.erb',
    /^.*yield.*$/,
    snippet('views/app_layout/tagged_main_element.html.erb').chomp

  insert_into_file 'application.html.erb',
    snippet('views/app_layout/nav_and_flash.html.erb').chomp,
    after: '<body>'

  insert_into_file 'application.html.erb',
    snippet('views/app_layout/screen_size_indicators.html.erb'),
    before: '</html>'
end
