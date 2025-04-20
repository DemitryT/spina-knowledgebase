# frozen_string_literal: true

# AddCategoryIdToSpinaKnowledgebaseArticles
class AddFeaturedToSpinaKnowledgebaseArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :spina_knowledgebase_articles, :featured, :boolean, index: true,
                                                       default: false
  end
end
