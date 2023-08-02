json.coupons do
    json.array! @coupons, :id, :name
end