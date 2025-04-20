# frozen_string_literal: true

class AddCategoryIdToSpinaKnowledgebaseArticles < ActiveRecord::Migration[5.0]
  def change
    add_reference :spina_knowledgebase_articles, :category, to_table: :spina_knowledgebase_categories
  end
end
