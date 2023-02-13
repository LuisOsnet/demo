# frozen_string_literal: true

json.user do
  json.id @user&.id
    json.name @user&.name
    json.level_english @user&.level_english
    json.technical_knowledge @user&.technical_knowledge
    json.email @user&.email
    json.created_at @user&.created_at&.strftime('%d-%m-%Y %T')
    json.roles do
      json.array! @user&.roles do |role|
        json.role role&.name
      end
    end
end