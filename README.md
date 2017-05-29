# Amanda's Rails Application Template
The script `gen_rails_app` will create a new Rails project and corresponding gemset, install and configure various gems, and copy in some files (e.g. shared templates for things like error and flash messages, corresponding Sass files, RSpec matchers and helper methods, and more). It can be used like this:

```shell
  gen_rails_app app_name path_to_parent_dir
```

The script `rm_rails_app` will delete the project's source code, gemset, and databases.

The meat of the work is done in `app_template.rb`, the script files mainly just deal with the RVM gemset. A few conventions in this file:
- Any files that are copied into the new project can be found in the `templates` directory.
- The `snippets` directory contains longer code blocks that are to be inserted into files that Rails and other gems generate.
- Some stuff is broken out into separate files so that `app_template.rb` doesn't get too long. `method_missing` is implemented to check and see if there is a file in the `tasks` folder with the same name as the method, if so, it runs the code in that file.

## Gems this Template Installs

| Dev | Test | All |
| --- | ---- | --- |
| [spring-commands-rspec](https://github.com/jonleighton/spring-commands-rspec) | [rspec-rails](https://github.com/rspec/rspec-rails) | [devise](https://github.com/plataformatec/devise) |
| [faker](https://github.com/stympy/faker) | [capybara](https://github.com/teamcapybara/capybara) | [decent_exposure](https://github.com/hashrocket/decent_exposure) |
| [pry](https://github.com/pry/pry) | [poltergeist](https://github.com/teampoltergeist/poltergeist) | [haml-rails](https://github.com/indirect/haml-rails) |
|  | [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails) | [font-awesome-rails](https://github.com/bokmann/font-awesome-rails) |
|  | [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner) | [bourbon](https://github.com/thoughtbot/bourbon) |
|  | [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) | [bitters](https://github.com/thoughtbot/bitters) |
|  | [webmock](https://github.com/bblimke/webmock) | [jquery-ui-rails](https://github.com/jquery-ui-rails/jquery-ui-rails) |
|  |  | [record_tag_helper](https://github.com/rails/record_tag_helper) |

## Customizations You'll Find in this Template

### Setting up the Test Environment

- Install RSpec
- Turn off transactional fixtures
- Use Webmock to disable outside HTTP requests
- Copy in all spec support files, including
  - Database Cleaner configuration
  - Helpers for Devise
  - Custom page object infrastructure
  - Custom RSpec matchers

### Modified Application Layout

- Add meta tag to fix scale on mobile devices
- Tag the page's `main` element with the controller and action name
- Render my custom appbar and flash message partials

### Custom Sass Stuff

I use Bourbon and Bitters, and then build custom components on top of that. Everything is organized using a modified [7-1 Architecture](https://sass-guidelin.es/#the-7-1-pattern). I prefer to use mixins and to avoid adding presentational classes in my HTML. More details can be found in [the wiki](https://github.com/crawfoal/rails_app_template/wiki/HTML-&-Stylesheets).

### I18n Configuration

I18n is all set up and ready to be used in both the application and test suite.

I like to use [lazy lookup](http://guides.rubyonrails.org/i18n.html#lazy-lookup), so I add all ruby and YAML files within the locales folder to the I18n load path.

### Rails Default Generators

The stylesheet and javascript generators are turned off because I don't write those on a per controller basis. The view specs and helper generators are turned off because I create those as needed (which is rare).

## Other Things You'll Find in this Template

### Specs for Stuff this Template Installed

Specs are included for the appbar and the welcome page.

I also include specs that run through some Devise stuff, partly because I want to double check that that all is working, and partly to remind myself what functionality is there and how it works.

All of the specs run after the template is finished so that we can see if our app is still working with the gem versions installed (many of them don't have versions specified).

### Git Setup

A git repo is created and the initial commit is made.
