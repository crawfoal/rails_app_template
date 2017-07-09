inside 'app/assets/stylesheets' do
  gsub_file 'base/_buttons.scss',
    /\#\{\$all-buttons\} \{.+\}/m,
    snippet('sass/base_buttons.scss').chomp

  append_to_file 'base/_layout.scss',
    snippet('sass/main_element_layout.scss').chomp

  prepend_to_file 'utils/_variables.scss',
    snippet('sass/screen_bp_sizes.scss')

  insert_into_file 'utils/_variables.scss',
    "// Font Sizes\n$button-font-size: 16px;\n\n",
    before: "// Other Sizes"
  insert_into_file 'utils/_variables.scss',
    "\n$appbar-background-color: $dark-gray;",
    after: "$secondary-background-color: tint($base-border-color, 75%);"
  insert_into_file 'utils/_variables.scss',
    "\n$appbar-font-color: palette(White);",
    after: "$action-color: $blue;"
  insert_into_file 'utils/_variables.scss',
    "\n$tiny-spacing: $small-spacing / 2;",
    after: "$small-spacing: $base-spacing / 2;"
  insert_into_file 'utils/_variables.scss',
    "\n$dark-border: $base-border-size solid $medium-gray;",
    after: "$base-border: 1px solid $base-border-color;"
  insert_into_file 'utils/_variables.scss',
    "\n$base-border-size: 1px;",
    after: "// Border"
  gsub_file 'utils/_variables.scss',
    "$base-border: 1px solid $base-border-color;",
    "$base-border: $base-border-size solid $base-border-color;"
end
