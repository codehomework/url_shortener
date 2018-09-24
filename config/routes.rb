Rails.application.routes.draw do
  get '/:short_path', to: 'url#show'
  post '/urls', to: 'url#create'
end
