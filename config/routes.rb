Rails.application.routes.draw do
  get "/" => redirect("/#{I18n.default_locale}")

  scope "/:locale", locale: /en|uk/ do
    devise_for :users
    root "pages#home"
    resources :cars
    resources :saved_searches, only: [ :index, :create, :destroy ]
    get "help", to: "pages#help", as: :help
    get "search", to: "cars#search_page", as: :search_page
  end

  # Health check for uptime monitors
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
