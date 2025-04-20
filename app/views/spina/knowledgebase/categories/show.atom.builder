# frozen_string_literal: true

atom_feed language: 'en-GB', url: spina.knowledgebase_category_url(@category) do |feed|
  feed.title(@category.name)
  feed.updated(@articles[0].created_at) unless @articles.empty?

  render partial: 'knowledgebase/articles/article', collection: @articles, locals: { feed: feed }
end
