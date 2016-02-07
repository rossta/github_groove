get "/auth/signout", to: 'session#destroy'
get "/auth/failure", to: 'session#failure'
get "/auth/:provider/callback", to: "session#new"

get "/project", to: 'project#index'
post "/project", to: 'project#create'

post "/ticket/:ticket_id/issues", to: "issues#create", as: :ticket_issues

get "/sync/tickets", to: "tickets#sync"

resources :tickets, only: [:index, :show]

get "/", to: "home#index"

# See: http://www.rubydoc.info/gems/hanami-router/#Usage
