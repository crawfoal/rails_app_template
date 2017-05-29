inside 'app/views/layouts' do
  insert_into_file 'application.html.haml',
    snippet('views/app_layout/meta_tags.html.haml').chomp,
    after: '%head'

  gsub_file 'application.html.haml',
    /^.*yield.*$/,
    snippet('views/app_layout/tagged_main_element.html.haml').chomp

  insert_into_file 'application.html.haml',
    snippet('views/app_layout/nav_and_flash.html.haml').chomp,
    after: '%body'

  append_to_file 'application.html.haml',
    snippet('views/app_layout/screen_size_indicators.html.haml')
end
