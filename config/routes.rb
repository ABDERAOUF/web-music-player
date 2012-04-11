WebMusicPlayer::Application.routes.draw do

  resources :library

  root :to => 'home#index'
end
