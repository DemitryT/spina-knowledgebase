# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spina::Knowledgebase::CategoriesController, type: :controller do
  routes { Spina::Engine.routes }

  let!(:account) { ::Spina::Account.create name: 'MySite', theme: 'default' }
  let(:category) { create(:spina_knowledgebase_category) }
  let(:other_category_articles) do
    create_list :spina_knowledgebase_article, 3, draft: false,
                                     published_at: Time.zone.today - 10
  end
  let(:draft_past_articles) do
    create_list :spina_knowledgebase_article, 3, draft: true,
                                     published_at: Time.zone.today - 10,
                                     category: category
  end
  let(:live_past_articles) do
    create_list :spina_knowledgebase_article, 3, draft: false,
                                     published_at: Time.zone.today - 10,
                                     category: category
  end
  let(:live_future_articles) do
    create_list :spina_knowledgebase_article, 3, draft: false,
                                     published_at: Time.zone.today + 10,
                                     category: category
  end

  describe 'GET #show' do
    subject { get :show, params: { id: category.id } }

    before do
      other_category_articles
      draft_past_articles
      live_past_articles
      live_future_articles
    end

    it {
      subject
      expect(assigns(:articles)).to match_array live_past_articles
    }
    it { is_expected.to render_template :show }
    it { is_expected.to be_successful }
  end
end
