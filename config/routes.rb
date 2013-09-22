CsvApiGenerator::Application.routes.draw do
  devise_for(:users, path: '/', path_names: { sign_in: 'sign-in' , sign_up: 'sign-up' , sign_out: 'sign-out' })
  scope :records do
    get '/:slug' => 'resource_records#index', as: :resource_records
    get '/:slug/:id' => 'resource_records#show', as: :show_resource_record
  end
  root to: 'resources#new'
  post '/' => 'resources#create'
  resources :resource, only: :show
end
