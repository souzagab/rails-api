Rails.application.routes.draw do
  # Healthcheck
  get "healthz" => "rails/health#show"

  match "*path", to: "application#route_not_found", via: :all
end
