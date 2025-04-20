# frozen_string_literal: true

class CreateSpinaKnowledgebaseCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :spina_knowledgebase_categories do |t|
      t.string :name
      t.string :slug, unique: true, index: true

      t.timestamps
    end
  end
end
