Rails.application.routes.draw do

  namespace :api, defaults: { format: JSON } do
    namespace :v1 do 
      resources :users, only: %i[show index create update destroy]
      resources :tokens, only: [:create]
    end
  end
end
