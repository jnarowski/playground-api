Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :growth_score_reports, only: [] do
    get :page_speed_report, on: :collection
    get :find_or_generate, on: :collection
    get :find_by_url, on: :collection
  end
end