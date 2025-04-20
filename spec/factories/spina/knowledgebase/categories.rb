# frozen_string_literal: true

FactoryBot.define do
  factory :spina_knowledgebase_category, class: Spina::Knowledgebase::Category do
    sequence(:name) { |n| "Category #{n}" }

    factory :invalid_spina_knowledgebase_category do
      name { nil }
    end
  end
end
