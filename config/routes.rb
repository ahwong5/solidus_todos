Spree::Core::Engine.routes.draw do

  namespace :admin do
    resources :todos do
    end
  end

end
