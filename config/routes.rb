Refinery::Application.routes.draw do
  resources :newsletters, :only => [:show] do
    get :unsubscribe, :on => :member
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :newsletters, :except => :show do
      collection do
        post :update_positions
      end
      member do
        get :send_newsletter, :path => 'send', :as => 'send'
        post :send_newsletter, :path => 'send', :as => 'send'
      end
    end
  end
end
