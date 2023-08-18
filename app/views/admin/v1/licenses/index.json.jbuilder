json.licenses do
  json.array! @licenses, :id, :key, :status, :game_id
end