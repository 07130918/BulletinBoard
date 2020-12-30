# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                    mypage GET    /mypage(.:format)                                                                        users#me
#                     login POST   /login(.:format)                                                                         sessions#create
#                    logout DELETE /logout(.:format)                                                                        sessions#destroy
#                      root GET    /                                                                                        home#index
#                     users POST   /users(.:format)                                                                         users#create
#                  new_user GET    /users/new(.:format)                                                                     users#new
#                    boards GET    /boards(.:format)                                                                        boards#index
#                           POST   /boards(.:format)                                                                        boards#create
#                 new_board GET    /boards/new(.:format)                                                                    boards#new
#                edit_board GET    /boards/:id/edit(.:format)                                                               boards#edit
#                     board GET    /boards/:id(.:format)                                                                    boards#show
#                           PATCH  /boards/:id(.:format)                                                                    boards#update
#                           PUT    /boards/:id(.:format)                                                                    boards#update
#                           DELETE /boards/:id(.:format)                                                                    boards#destroy
#                  comments POST   /comments(.:format)                                                                      comments#create
#                   comment DELETE /comments/:id(.:format)                                                                  comments#destroy
Rails.application.routes.draw do
  get 'mypage', to: 'users#me'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :users, only: [:new, :create]
  resources :boards
  resources :comments, only: [:create, :destroy]
end
