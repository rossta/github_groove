get '/session', to: 'session#failure'
get "/auth/:provider/callback", to: "session#new"
get "/tickets", to: "tickets#index"
get "/", to: "home#index"
# See: http://www.rubydoc.info/gems/hanami-router/#Usage
