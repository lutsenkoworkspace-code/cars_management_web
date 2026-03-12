Rails.application.routes.draw do
  get "/" => redirect("/#{I18n.default_locale}")

  scope "/:locale", locale: /en|uk/ do
    root "pages#home", as: :root
    resources :cars
    get "help", to: "pages#help", as: :help
  end

  # Health check for uptime monitors
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
