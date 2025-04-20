# frozen_string_literal: true

# desc "Explaining what the task does"
# task :spina_knowledgebase do
#   # Task goes here
# end

namespace :spina_knowledgebase do
  task photo_to_image: :environment do
    Knowledgebase::Article.find_each do |article|
      article.update_column :image_id, article.photo.image_id
    end
  end
end
