# frozen_string_literal: true

json.teams do
  json.array! @teams do |team|
    json.id team&.id
    json.name team&.name
    json.created_at team&.created_at&.strftime('%d-%m-%Y %T')
    
    json.account do
      json.id team&.account&.id
      json.name team&.account&.name
      json.client_name team&.account&.client_name
      json.owner team&.account&.owner
      json.created_at team&.account&.created_at&.strftime('%d-%m-%Y %T')
    end
  end
end