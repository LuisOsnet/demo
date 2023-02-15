# frozen_string_literal: true

json.account do
  json.id @account&.id
  json.name @account&.name
  json.client_name @account&.client_name
  json.owner @account&.owner
  json.created_at @account&.created_at&.strftime('%d-%m-%Y %T')
  json.teams do
    json.array! @account&.teams do |team|
      json.id team&.id
      json.name team&.name
      json.created_at team&.created_at&.strftime('%d-%m-%Y %T')
    end
  end
end