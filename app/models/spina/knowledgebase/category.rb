# frozen_string_literal: true

module Spina
  module Knowledgebase
    # Spina::Knowledgebase::Category
    class Category < ApplicationRecord
      extend FriendlyId

      friendly_id :name, use: :slugged

      has_many :articles, class_name: 'Spina::Knowledgebase::Article', inverse_of: :category
      validates :name, presence: true, uniqueness: { case_sensitive: false }

      def to_s
        name
      end
    end
  end
end
