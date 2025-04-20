# frozen_string_literal: true

module Spina
  module Admin
    module Knowledgebase
      # Spina::Admin::Knowledgebase::ArticlesController
      class ArticlesController < AdminController
        before_action :article, except: %i[index live draft future new create]
        before_action :set_breadcrumb
        before_action :set_tabs, only: %i[new create edit update]
        before_action :set_locale
        
        admin_section :knowledgebase

        decorates_assigned :article

        def index
          @articles = Spina::Knowledgebase::Article.order(created_at: :desc)
        end

        def live
          @articles = Spina::Knowledgebase::Article.live.order(created_at: :desc)
          render :index
        end

        def draft
          @articles = Spina::Knowledgebase::Article.draft.order(created_at: :desc)
          render :index
        end

        def future
          @articles = Spina::Knowledgebase::Article.future.order(created_at: :desc)
          render :index
        end

        def new
          @article = Spina::Knowledgebase::Article.new
          add_breadcrumb I18n.t('spina.knowledgebase.articles.new')
          render layout: 'spina/admin/admin'
        end

        def create
          @article = Spina::Knowledgebase::Article.new article_params
          if @article.save
            redirect_to spina.edit_admin_knowledgebase_article_url(@article.id),
                        notice: t('spina.knowledgebase.articles.saved')
          else
            add_breadcrumb I18n.t('spina.knowledgebase.articles.new')
            render :new, status: :unprocessable_entity
          end
        end

        def edit
          add_breadcrumb @article.title
          render layout: 'spina/admin/admin'
        end

        def update
          if @article.update(article_params)
            add_breadcrumb @article.title
            redirect_to spina.edit_admin_knowledgebase_article_url(
              @article.id, params: { locale: @locale }
            ), notice: t('spina.knowledgebase.articles.saved')
          else
            render :edit, status: :unprocessable_entity
          end
        end

        def destroy
          @article.destroy
          redirect_to spina.admin_knowledgebase_articles_path
        end

        private

        def article
          @article = Spina::Knowledgebase::Article.find(params[:id])
        end

        def set_breadcrumb
          add_breadcrumb I18n.t('spina.knowledgebase.articles.title'),
                         spina.admin_knowledgebase_articles_path
        end

        def set_tabs
          @tabs = %w[article_content article_configuration article_seo]
        end

        def set_locale
          @locale = params[:locale] || I18n.default_locale
          I18n.locale = @locale
        end

        def article_params
          params.require(:article).permit(
            :title, :slug, :excerpt, :content, :image_id, :draft, :published_at,
            :user_id, :category_id, :featured, :seo_title, :description
          )
        end
      end
    end
  end
end
