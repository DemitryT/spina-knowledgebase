# frozen_string_literal: true

FactoryBot.define do
  factory :spina_knowledgebase_article, class: Spina::Knowledgebase::Article do
    sequence(:title) { |n| "Knowledgebase Article #{n}" }
    content { 'Some content for my article' }
    association :category, factory: :spina_knowledgebase_category

    seo_title { 'Some title for SEO' }
    description { 'Some description for SEO' }

    factory :invalid_spina_knowledgebase_article do
      title { nil }
    end
  end
end
