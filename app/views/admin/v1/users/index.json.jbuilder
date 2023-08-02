json.users do
    json.array! @users, :id, :name
end