# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Articles', type: :system do
  let!(:account) { ::Spina::Account.create name: 'MySite', theme: 'default' }

  describe 'listing articles' do
    let!(:articles) { create_list(:spina_knowledgebase_article, 3, draft: false, published_at: Date.today - 1) }

    it 'shows all the articles' do
      visit '/knowledgebase'
      expect(page).to have_css 'li.article', count: 3
    end

    context 'using the atom format' do
      it 'shows the atom feed' do
        visit '/knowledgebase.atom'
        expect(page).to have_xpath '//entry', count: 3
      end
    end
  end

  describe 'listing archived articles' do
    let!(:last_year_articles) { create_list(:spina_knowledgebase_article, 3, draft: false, published_at: Date.today.beginning_of_year - 1) }

    context 'with a year' do
      it 'shows all the articles' do
        visit "/knowledgebase/archive/#{Date.today.year - 1}"
        expect(page).to have_content(Date.today.year - 1)
        expect(page).to have_css 'li.article', count: 3
      end
    end

    context 'with a year and month' do
      it 'shows all the articles' do
        visit "/knowledgebase/archive/#{Date.today.year - 1}/12"
        expect(page).to have_content "December #{Date.today.year - 1}"
        expect(page).to have_css 'li.article', count: 3
      end
    end
  end

  describe 'showing a article' do
    let!(:article) { create(:spina_knowledgebase_article) }

    it 'shows the article' do
      visit "/knowledgebase/articles/#{article.slug}"
      expect(page).to have_css 'h1', text: article.title
      expect(page).to have_content article.content
    end
  end
end
