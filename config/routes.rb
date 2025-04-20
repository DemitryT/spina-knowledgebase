# frozen_string_literal: true

Spina::Engine.routes.draw do
  namespace :knowledgebase do
    root to: 'articles#index'

    get ':id', to: 'articles#show', as: :article

    # Redirects for old sites that used the old knowledgebase path
    get 'articles/', to: redirect('/knowledgebase'), as: :old_index
    get 'articles/:id', to: redirect('/knowledgebase/%{id}'), as: :old_article

    get 'feed.atom', to: 'articles#index', as: :rss_feed, defaults: { format: :atom }
    get 'categories/:id', to: 'categories#show', as: :category
    get 'archive/:year(/:month)', to: 'articles#archive', as: :archive_articles
  end

  namespace :admin do
    namespace :knowledgebase do
      resources :categories
      resources :articles, except: :show do
        collection do
          get :live
          get :draft
          get :future
        end
      end
    end
  end
end
