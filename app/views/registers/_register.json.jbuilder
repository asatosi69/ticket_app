json.extract! register, :id, :user_id, :count, :b_name, :b_email, :stage_id, :type_id, :comment, :state, :ticket_id, :created_at, :updated_at
json.url register_url(register, format: :json)
