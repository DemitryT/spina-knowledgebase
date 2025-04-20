# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spina::Admin::Knowledgebase::ArticlesController, type: :controller do
  let(:articles) { create_list(:spina_knowledgebase_article, 3) }
  let(:knowledgebase_article) { create(:spina_knowledgebase_article) }
  let(:draft_articles) { create_list(:spina_knowledgebase_article, 3, draft: true) }
  let(:live_articles) { create_list(:spina_knowledgebase_article, 3, draft: false) }
  let(:article_attributes) { attributes_for(:spina_knowledgebase_article) }

  routes { Spina::Engine.routes }

  context 'signed in as an admin' do
    before { sign_in }

    describe 'GET #index' do
      subject { get :index }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
      it {
        subject
        expect(assigns(:articles)).to match_array articles
      }
    end

    describe 'GET #live' do
      subject { get :live }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
      it {
        subject
        expect(assigns(:articles)).to match_array live_articles
      }
      it {
        subject
        expect(assigns(:articles)).to_not match_array draft_articles
      }
    end

    describe 'GET #draft' do
      subject { get :draft }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
      it {
        subject
        expect(assigns(:articles)).to match_array draft_articles
      }
      it {
        subject
        expect(assigns(:articles)).to_not match_array live_articles
      }
    end

    describe 'GET #future' do
      let(:past_articles) do
        create_list(:spina_knowledgebase_article, 3, published_at: Time.zone.today - 10)
      end
      let(:future_articles) do
        create_list(:spina_knowledgebase_article, 3, published_at: Time.zone.today + 10)
      end

      subject { get :future }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
      it {
        subject
        expect(assigns(:articles)).to match_array future_articles
      }
      it {
        subject
        expect(assigns(:articles)).to_not match_array past_articles
      }
    end

    describe 'GET #new' do
      subject { get :new }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :new }
    end

    describe 'POST #create' do
      subject { article :create, params: { article: article_attributes } }

      it { is_expected.to have_http_status :redirect }
      it {
        subject
        expect(flash[:notice]).to eq 'Article saved'
      }
      it { expect { subject }.to change(Spina::Knowledgebase::Article, :count).by(1) }

      context 'with invalid attributes' do
        subject { article :create, params: { article: { content: 'foo' } } }

        it { is_expected.to_not have_http_status :redirect }
        it { expect { subject }.to_not change(Spina::Knowledgebase::Article, :count) }
        it { is_expected.to render_template :new }
      end
    end

    describe 'GET #edit' do
      subject { get :edit, params: { id: knowledgebase_article.id } }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :edit }
    end

    describe 'PATCH #update' do
      subject do
        patch :update, params: { id: knowledgebase_article.id, article: article_attributes }
      end

      it { is_expected.to have_http_status :redirect }
      it do
        subject
        expect(flash[:notice]).to eq 'Article saved'
      end
      it { expect { subject }.to(change { knowledgebase_article.reload.title }) }

      context 'with invalid attributes' do
        subject do
          patch :update, params: { id: knowledgebase_article.id, article: { title: '' } }
        end

        it { is_expected.to_not have_http_status :redirect }
        it { is_expected.to render_template :edit }
        it { expect { subject }.not_to(change { knowledgebase_article.reload.title }) }
      end
    end

    describe 'DELETE #destroy' do
      let!(:knowledgebase_article) { FactoryBot.create :spina_knowledgebase_article }

      subject { delete :destroy, params: { id: knowledgebase_article.id } }

      it { expect { subject }.to change(Spina::Knowledgebase::Article, :count).by(-1) }
    end
  end

  context 'signed out' do
    before { Spina::Account.create name: 'My Website', theme: 'default' }
    describe 'GET #index' do
      subject { get :index }
      it { is_expected.to have_http_status :redirect }
      it { is_expected.to_not render_template :index }
    end
  end
end
