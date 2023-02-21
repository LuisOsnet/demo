require 'rails_helper'

RSpec.describe Team, type: :model do
  context "validations" do
    let (:account) { create(:account) }
    let (:team) { create(:team, account_id: account.id) }
    it 'Validate fields' do
      expect(team.name.present?).to eq(true)
      expect(team.account_id.present?).to eq(true)
    end
  end
end
