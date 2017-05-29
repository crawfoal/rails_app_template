require 'open-uri'
create_file 'vendor/assets/stylesheets/normalize.css',
  open('https://necolas.github.io/normalize.css/latest/normalize.css').read

create_file 'vendor/assets/stylesheets/_palette.scss',
  open('http://danlevan.github.io/google-material-color/dist/palette.scss').read
