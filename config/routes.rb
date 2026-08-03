Rails.application.routes.draw do
  root "communities#index"
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  scope "/:slug" do
    get    "/",                to: "communities#show",  as: :community
    get    "/contents/:id",    to: "contents#show",     as: :community_content
    get    "/manage",          to: "manage#show",        as: :manage
    post   "/selections",      to: "selections#create",  as: :selections
    delete "/selections/:id",  to: "selections#destroy", as: :selection
  end
end
