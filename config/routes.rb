Rails.application.routes.draw do
  # Add your routes here
  root 'welcome#home'

  get '/auth/:provider/callback' => 'sessions#create'

end
