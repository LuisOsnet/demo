# frozen_string_literal: true

json.user do
  json.id @user&.id
  json.name @user&.name
  json.level_english @user&.level_english
  json.technical_knowledge @user&.technical_knowledge
  json.resume_url @user&.resume_url
  json.email @user&.email
  json.created_at @user&.created_at&.strftime('%d-%m-%Y %T')
end
