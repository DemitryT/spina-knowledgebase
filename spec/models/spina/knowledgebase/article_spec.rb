# frozen_string_literal: true

require 'rails_helper'

module Spina::Knowledgebase
  RSpec.describe Article, type: :model do
    let(:article) { build(:spina_knowledgebase_article) }

    subject { article }

    it { is_expected.to be_valid }
    it { expect { article.save }.to change(Spina::Knowledgebase::Article, :count).by(1) }

    context 'with invalid attributes' do
      let(:article) { build(:invalid_spina_knowledgebase_article) }

      it { is_expected.to_not be_valid }
      it { expect { article.save }.to_not change(Spina::Knowledgebase::Article, :count) }
    end

    describe '.featured' do
      let!(:article) { create(:spina_knowledgebase_article, featured: true) }
      let!(:unfeatured) { create(:spina_knowledgebase_article) }

      it 'returns 1 result' do
        expect(Spina::Knowledgebase::Article.featured).to match_array [article]
      end
    end

    describe '.unfeatured' do
      let!(:article) { create(:spina_knowledgebase_article, featured: true) }
      let!(:unfeatured) { create(:spina_knowledgebase_article) }

      it 'returns 1 result' do
        expect(Spina::Knowledgebase::Article.unfeatured).to match_array [unfeatured]
      end
    end
  end
end
