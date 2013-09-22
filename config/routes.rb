CsvApiGenerator::Application.routes.draw do
  root to: 'resources#new'
  post '/' => 'resources#create'
  devise_for(:users, path_names: { sign_in: 'sign-in' , sign_up: 'sign-up' , sign_out: 'sign-out' })
  scope :records do
    get '/:slug' => 'resource_records#index', as: :resource_records
    get '/:slug/:id' => 'resource_records#show', as: :show_resource_record
  end
  resources :resources, only: :show
end
