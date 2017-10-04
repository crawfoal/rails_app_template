Rake::Task[:default].clear if Rake::Task.task_defined?(:default)

task default: [
  'lint:rubocop:autocorrect',
  :spec,
  'lint:codeclimate'
]
