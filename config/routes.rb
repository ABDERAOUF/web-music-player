WebMusicPlayer::Application.routes.draw do

  root :to => 'home#index'

  resources :library
end
