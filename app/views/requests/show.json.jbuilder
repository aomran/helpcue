json.request_id @request.id
json.(@request, :classroom_id, :owner_id, :question, :answer, :state, :created_at, :updated_at)
json.waiting_time @request.time_waiting
json.metoo_count @request.users.count
json.metoo_people @request.users.full_names
json.requestAction @request_action

json.owner do
  json.avatar @request.owner.avatar
  json.full_name @request.owner.full_name
end
