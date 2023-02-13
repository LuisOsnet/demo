# frozen_string_literal: true

json.account do
	json.id @account&.id
	json.name @account&.name
	json.client_name @account&.client_name
	json.owner @account&.owner
	json.created_at @account&.created_at&.strftime('%d-%m-%Y %T')
end