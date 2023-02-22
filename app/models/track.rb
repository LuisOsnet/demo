class Track < ApplicationRecord
  belongs_to :trackable, polymorphic: true

  def self.ransackable_attributes(auth_object = nil)
    %w(user_id user_name team_id team_name started_at ended_at)
  end

  ransacker :started_at, type: :date do
    Arel.sql('date(ended_at)')
  end

  ransacker :ended_at, type: :date do
    Arel.sql('date(ended_at)')
  end
end
