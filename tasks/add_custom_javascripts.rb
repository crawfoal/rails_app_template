directory 'app/assets/javascripts'
insert_into_file 'app/assets/javascripts/application.js',
  "//= require init\n",
  before: "//= require_tree ."
insert_into_file 'app/assets/javascripts/application.js',
  "\n//= require jquery-ui/effect.all",
  after: "//= require jquery_ujs"
