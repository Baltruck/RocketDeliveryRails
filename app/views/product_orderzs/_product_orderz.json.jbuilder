json.extract! product_orderz, :id, :product_quantity, :product_unit_cost, :created_at, :updated_at
json.url product_orderz_url(product_orderz, format: :json)
