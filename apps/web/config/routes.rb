get '/project', to: 'project#index'
post '/project', to: 'project#create'

get '/auth/signout', to: 'session#destroy'
get '/auth/failure', to: 'session#failure'
get "/auth/:provider/callback", to: "session#new"

get "/tickets", to: "tickets#index"
get "/", to: "home#index"

# See: http://www.rubydoc.info/gems/hanami-router/#Usage
