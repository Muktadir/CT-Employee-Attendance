json.array!(@allowed_ips) do |allowed_ip|
  json.extract! allowed_ip, :id, :name, :ip_address
  json.url allowed_ip_url(allowed_ip, format: :json)
end
