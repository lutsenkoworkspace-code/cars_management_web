Rails.application.routes.draw do
  # Main application routes
  root "pages#home"
  get "help", to: "pages#help"

  # Health check for uptime monitors
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
