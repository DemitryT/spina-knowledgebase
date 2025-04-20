# frozen_string_literal: true

module Spina
  module Knowledgebase
    # Spina::Knowledgebase::CategoriesController
    class CategoriesController < ::Spina::ApplicationController
      include ::Spina::Frontend

      before_action :page
      before_action :category
      before_action :articles
      before_action :set_theme
      before_action :add_view_path

      decorates_assigned :articles

      def show
        respond_to do |format|
          format.atom { render 'knowledgebase/categories/show' }
          format.html { render 'knowledgebase/categories/show', layout: theme_layout }
        end
      end

      private

      def category
        @category = Spina::Knowledgebase::Category.friendly.find params[:id]
      end

      def articles
        @articles = @category.articles.available.live.order(published_at: :desc)
                          .page(params[:page])
      end

      def page
        @page = Spina::Page.find_or_create_by name: 'knowledgebase' do |page|
          page.link_url = '/knowledgebase'
          page.deletable = false
        end
      end

      def set_theme
        @theme = current_theme.name.parameterize.underscore
      end

      def theme_layout
        "#{@theme}/#{@page.layout_template || 'application'}"
      end

      def add_view_path
        ActiveSupport::Deprecation.warn 'Knowledgebase views should be moved from "app/views/spina/knowledgebase" to "app/views/(your_theme)/knowledgebase".'
        prepend_view_path ["app/views/#{@theme}", "app/views/spina", Spina::Knowledgebase::Engine.root.join('app', 'views', 'spina')]
      end
    end
  end
end
