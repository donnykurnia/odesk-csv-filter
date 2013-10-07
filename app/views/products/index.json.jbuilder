json.array!(@products) do |product|
  json.extract! product, :kind, :height, :is_emergency_exit, :is_openable
  json.url product_url(product, format: :json)
end
