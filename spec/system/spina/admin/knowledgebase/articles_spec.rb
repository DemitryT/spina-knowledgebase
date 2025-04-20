# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Admin Articles', type: :system do
  before { sign_in }

  describe 'listing articles' do
    let!(:articles) { create_list(:spina_knowledgebase_article, 3, published_at: Date.today + 1) }

    it 'shows all the articles' do
      visit '/admin/knowledgebase/articles'
      expect(page).to have_content "Knowledgebase Article"
    end
  end

  describe 'creating a article' do
    it 'creates a article', js: true do
      visit '/admin/knowledgebase/articles'
      find(:css, 'a[href="/admin/knowledgebase/articles/new"]').click
      fill_in 'Article title', with: 'Title of Knowledgebase article'
      find(
        :css, 'trix-editor[input*="content_input"]'
      ).set('Foobar')
      click_on 'Save article'
      within 'nav[data-controller="navigation"]' do
        click_on 'Articles'
      end
      expect(page).to have_content 'Title of Knowledgebase article'
    end
  end
end
