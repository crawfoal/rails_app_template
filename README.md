# Amanda's Rails Application Template
The script `gen_rails_app` will create a new Rails project and corresponding gemset, install and configure various gems, and copy in some files (e.g. shared templates for things like error and flash messages, corresponding Sass files, RSpec matchers and helper methods, and more). It can be used like this:

```shell
  gen_rails_app app_name path_to_parent_dir
```

The script `rm_rails_app` will delete the project's source code, gemset, and databases.

The meat of the work is done in `app_template.rb`, the script files mainly just deal with the gemsets. Any files that are copied into the new project can be found in the `templates` directory.

## Gems this Template Installs

| Dev | Test | All |
| --- | ---- | --- |
| spring-commands-rspec | rspec-rails | devise |
| faker | capybara | decent_exposure |
| pry | poltergeist | haml-rails |
|  | factory_girl_rails | font-awesome-rails |
|  | database_cleaner | bourbon |
|  | shoulda-matchers | bitters |
|  | webmock | jquery-ui-rails |
|  |  | record_tag_helper |

## Customizations You'll Find in this Template

(listed in order of relevance / impact)

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

I use Bitters, which installs some basics into `app/assets/stylesheets/base`. These files define the style for all of the basic HTML elements, and sometimes I customize them.

On top of Bourbon and Bitters, I use Sass mixins to build custom components (see `app/assets/stylesheets/components`). The mixins defined in this folder are reusable little chunks of Sass that I use throughout the project, and across all of my projects. In the files in `app/assets/stylesheets`, these styles are actually applied to specific elements on specific pages.

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
