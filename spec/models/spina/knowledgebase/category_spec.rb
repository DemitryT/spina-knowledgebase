# frozen_string_literal: true

require 'rails_helper'

module Spina::Knowledgebase
  RSpec.describe Category, type: :model do
    let(:category) { build(:spina_knowledgebase_category) }

    subject { category }

    it { is_expected.to be_valid }
    it { expect { category.save }.to change(Spina::Knowledgebase::Category, :count).by(1) }

    context 'with invalid attributes' do
      let(:category) { build(:invalid_spina_knowledgebase_category) }

      it { is_expected.to_not be_valid }
      it { expect { category.save }.to_not change(Spina::Knowledgebase::Category, :count) }
    end
  end
end
