# frozen_string_literal: true

# Addition of SEO fields
class AddSeoFields < ActiveRecord::Migration[5.2]
  def change
    change_table :spina_knowledgebase_articles do |t|
      t.string :seo_title
      t.text :description
    end
  end
end
