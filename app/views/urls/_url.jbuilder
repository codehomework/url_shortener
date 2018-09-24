json.(@url, :long_url, :short_path)
json.short_url "http://#{request.env['HTTP_HOST']}/#{@url.short_path}"
