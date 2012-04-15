WebMusicPlayer::Application.routes.draw do

  resources :artists, :only => [:index, :create, :show, :update, :destroy] do
    member do
      get :albums
      get :songs
    end
  end

  resources :albums, :only => [:index, :create, :show, :update, :destroy] do
    member do
      get :songs
    end
  end

  resources :songs, :only => [:index, :create, :show, :update, :destroy]

  get 'local-song/:id' => 'local_song#download'
  get 'library' => 'library#index'

  root :to => 'home#index'
end
