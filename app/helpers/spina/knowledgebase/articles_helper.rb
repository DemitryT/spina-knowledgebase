# frozen_string_literal: true

module Spina
  module Knowledgebase
    # Spina::Knowledgebase::ArticlesHelper
    module ArticlesHelper
      def formatted_date(year, month)
        if month
          date = Date.new year.to_i, month.to_i
          date.strftime('%B %Y')
        else
          date = Date.new year.to_i
          date.strftime('%Y')
        end
      end
    end
  end
end
