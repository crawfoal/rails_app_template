inside 'app/assets/stylesheets' do
  directory 'components'
  directory 'utils'
  directory 'layout'
  directory 'pages'

  # Move includes from _base.scss to application.scss
  gsub_file 'base/_base.scss', /^((.*variables.*)|(\/\/.*))$\n/, ''
  gsub_file 'base/_base.scss', '@import "', '@import "base/'
  base_includes = File.read('base/_base.scss')
  gsub_file 'application.scss', /^.*base.*$/, base_includes
  gsub_file 'application.scss', /(^$\n){2,}/, "\n"
  remove_file 'base/_base.scss'

  FileUtils.move 'base/_variables.scss', 'utils/_variables.scss'
end
