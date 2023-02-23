# frozen_string_literal: true

json.team do
  json.id @team&.id
  json.name @team&.name
  json.created_at @team&.created_at&.strftime('%d-%m-%Y %T')

  json.account do
    json.name @team&.account&.name
    json.client_name @team&.account&.client_name
    json.owner @team&.account&.owner
  end

  json.users do
    json.array! @team&.users do |user|
      json.id user&.id
      json.user user&.name
    end
  end
end
