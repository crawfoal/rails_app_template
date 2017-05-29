inside 'app/assets/stylesheets' do
  gsub_file 'base/_buttons.scss',
    /\#\{\$all-buttons\} \{.+\}/m,
    snippet('sass/base_buttons.scss').chomp

  append_to_file 'base/_layout.scss',
    snippet('sass/main_element_layout.scss').chomp

  insert_into_file 'utils/_variables.scss',
    "// Font Sizes\n$button-font-size: 16px;\n\n",
    before: "// Other Sizes"
  insert_into_file 'utils/_variables.scss',
    "\n$appbar-background-color: $dark-gray;",
    after: "$secondary-background-color: tint($base-border-color, 75%);"
  insert_into_file 'utils/_variables.scss',
    "\n$appbar-font-color: palette(White);",
    after: "$action-color: $blue;"
end
