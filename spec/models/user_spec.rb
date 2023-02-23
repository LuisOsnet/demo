# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'valid Factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  context 'validations' do
    let(:super_user) { create(:user, :super_user) }
    it 'Validate fields' do
      expect(super_user.email.present?).to eq(true)
      expect(super_user.password.present?).to eq(true)
    end

    it 'ensures email presence' do
      user = described_class.new(
        email: 'email@example.com',
        password: 'sJcwP0WmTH?'
      ).save

      expect(user).to eq(false)
    end

    it 'ensures password presence' do
      user = described_class.new(
        email: 'email@example.com'
      ).save

      expect(user).to eq(false)
    end
  end
end
