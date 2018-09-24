class UrlController < ApplicationController

  # Redirect a short URL, unless it's not valid, in which case
  # show an error message
  def show
    begin
      @url = Url.find_by!(short_path: params['short_path'])
      redirect_to @url.long_url_with_explicit_protocol, status: 302
    rescue ActiveRecord::RecordNotFound
      render html: "That URL could not be found :(", status: 404
    end    
  end

  # Create a new shortened URL, if the URL is "valid"
  # (a loosely defined term)
  def create
    @url = Url.create(params.permit(:long_url))
    if @url.save
      render @url, status: 201
    else
      head 400, content_type: "application/json"
    end
  end
end
