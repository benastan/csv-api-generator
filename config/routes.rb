CsvApiGenerator::Application.routes.draw do
  resources :resources, except: [ :index, :show, :create, :update, :edit, :destroy ], path: '' do
    collection do
      get '/:slug' => :index, as: ''
      get '/:slug/:id' => :show
    end
    #post '/:resource_slug/:id' => :create
    #get '/:resource_slug/:id/:nested_action' => :create
  end
end
