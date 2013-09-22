CsvApiGenerator::Application.routes.draw do
  get '/:slug' => 'resource_records#index', as: :resource_records
  get '/:slug/:id' => 'resource_records#show', as: :show_resource_record
  root to: 'resources#new'
  post '/' => 'resources#create'
end
