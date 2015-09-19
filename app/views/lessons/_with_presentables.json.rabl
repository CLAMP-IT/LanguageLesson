extends "lessons/_base"

child :presentables, root: 'lesson_elements' do
  node do |presentable|
    partial "#{presentable.class.name.underscore.pluralize}/_base", object: presentable
  end
end
