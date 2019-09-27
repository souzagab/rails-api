Rails.application.routes.draw do
  namespace :api, defaults: { format: JSON } do
    namespace :v1 do 
      resources :user, only: %i[show create update destroy]
    end
  end
end
