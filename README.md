# Amanda's Rails Application Template
The script `gen_rails_app` will create a new Rails project and corresponding gemset, install and configure various gems, and copy in some files (e.g. shared templates for things like error and flash messages, corresponding Sass files, RSpec matchers and helper methods, and more). It can be used like this:

```shell
  gen_rails_app app_name path_to_parent_dir
```

The script `rm_rails_app` will delete the project's source code, gemset, and databases.

The meat of the work is done in `app_template.rb`, the script files mainly just deal with the gemsets. Any files that are copied into the new project can be found in the `templates` directory.

## Gems

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
