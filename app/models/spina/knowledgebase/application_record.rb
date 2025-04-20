# frozen_string_literal: true

module Spina
  module Knowledgebase
    # Spina::ApplicationRecord
    class ApplicationRecord < ActiveRecord::Base
      extend Mobility

      self.abstract_class = true
    end
  end
end
