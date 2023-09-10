Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/departments", to: "departments#index"
  get "/employees/:id", to: "employees#show"
  patch "/employees/:id", to: "employees#update"
end
