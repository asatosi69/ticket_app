json.user_id @user.id
json.user_name @user.name
json.ticket_summary do
   json.total_ticket_count @user.tickets.size
    @user.tickets.group(:type).sum(:count).each do |type, count|
      json.set! type.kind do
        json.sum_of_count count
      end
    end
end
