# frozen_string_literal: true

json.movements do
  json.array! @records do |record|
    json.id record&.id
    json.user_id record&.user_id
    json.user_name record&.user_name
    json.team_id record&.team_id
    json.team_name record&.team_name
    json.started_at record&.started_at&.strftime('%d-%m-%Y')
    json.ended_at record&.ended_at&.strftime('%d-%m-%Y')
    json.created_at record&.created_at&.strftime('%d-%m-%Y')
    json.updated_at record&.updated_at&.strftime('%d-%m-%Y')
  end
end