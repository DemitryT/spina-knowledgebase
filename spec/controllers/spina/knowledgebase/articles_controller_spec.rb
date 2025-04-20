# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spina::Knowledgebase::ArticlesController, type: :controller do
  let!(:account) { ::Spina::Account.create name: 'MySite', theme: 'default' }

  routes { Spina::Engine.routes }

  let(:draft_past_articles) do
    create_list :spina_knowledgebase_article, 3, draft: true,
                                     published_at: Time.zone.today - 10
  end
  let(:live_past_articles) do
    create_list :spina_knowledgebase_article, 3, draft: false,
                                     published_at: Time.zone.today - 10
  end
  let(:live_future_articles) do
    create_list :spina_knowledgebase_article, 3, draft: false,
                                     published_at: Time.zone.today + 10
  end

  describe 'GET #index' do
    subject { get :index }

    before do
      draft_past_articles
      live_past_articles
      live_future_articles
    end

    it do
      subject
      expect(assigns(:articles)).to match_array live_past_articles
    end
  end

  describe 'GET #show' do
    let(:knowledgebase_article) { create(:spina_knowledgebase_article) }

    subject { get :show, params: { id: knowledgebase_article.id } }

    it {
      subject
      expect(assigns(:article)).to eq knowledgebase_article
    }
    it { is_expected.to render_template :show }
    it { is_expected.to be_successful }
  end

  describe 'GET #archive' do
    context 'with a year' do
      let(:this_year_articles) do
        create_list :spina_knowledgebase_article, 3,
                    draft: false, published_at: Time.zone.today.beginning_of_year
      end
      let(:last_year_articles) do
        create_list :spina_knowledgebase_article, 3,
                    draft: false,
                    published_at: Time.zone.today.beginning_of_year - 1
      end
      before do
        this_year_articles
        last_year_articles
      end

      subject { get :archive, params: { year: Time.zone.today.year } }

      it {
        subject
        expect(assigns(:articles)).to match_array this_year_articles
      }
    end

    context 'with a year and a month' do
      let(:this_month_articles) { create_list(:spina_knowledgebase_article, 3, draft: false, published_at: Time.zone.today.beginning_of_month) }
      let(:last_month_articles) { create_list(:spina_knowledgebase_article, 3, draft: false, published_at: Time.zone.today.beginning_of_month - 1) }

      before do
        this_month_articles
        last_month_articles
      end

      subject { get :archive, params: { year: Time.zone.today.year, month: Time.zone.today.month } }

      it {
        subject
        expect(assigns(:articles)).to match_array this_month_articles
      }
    end
  end
end
