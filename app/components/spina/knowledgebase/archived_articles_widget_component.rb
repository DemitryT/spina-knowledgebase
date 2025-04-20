module Spina
  module Knowledgebase
    class ArchivedArticlesWidgetComponent < Spina::ApplicationComponent

      ArticlesYear = Struct.new(
        :year,
        :count,
        keyword_init: true
      ) do
        include Spina::Engine.routes.url_helpers

        def path
          knowledgebase_archive_articles_path(year)
        end

      end

      def initialize
        @articles_years =
          ActiveRecord::Base.connection.execute(query).map do |result|
            ArticlesYear.new(year: result['published_at_year'], count: result['count'])
          end
      end

      def query
        <<~SQL
        select cast(extract('Year' from published_at) as text) as published_at_year, count(extract('Year' from published_at))
        from spina_knowledgebase_articles
        where draft=false
        group by published_at_year
        SQL
      end

    end
  end
end
