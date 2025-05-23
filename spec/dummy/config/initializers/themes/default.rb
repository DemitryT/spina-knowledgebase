# frozen_string_literal: true

::Spina::Theme.register do |theme|
  theme.name = 'default'
  theme.title = 'Default Theme'
  theme.plugins = ['knowledgebase']

  theme.page_parts = [{
    name: 'text',
    title: 'Text',
    partable_type: 'Spina::Text'
  }]

  theme.view_templates = [{
    name: 'homepage',
    title: 'Homepage',
    page_parts: ['text']
  }, {
    name: 'show',
    title: 'Default',
    description: 'A simple page',
    usage: 'Use for your content',
    page_parts: ['text']
  }]

  theme.custom_pages = [{
    name: 'homepage',
    title: 'Homepage',
    deletable: false,
    view_template: 'homepage'
  }]
end
