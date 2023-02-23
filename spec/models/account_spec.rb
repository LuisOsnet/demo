# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'validations' do
    let(:account) { create(:account) }
    it 'Validate fields' do
      expect(account.name.present?).to eq(true)
      expect(account.client_name.present?).to eq(true)
      expect(account.owner.present?).to eq(true)
    end
  end
end
