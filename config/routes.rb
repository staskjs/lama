Lama::Engine.routes.draw do
  devise_for :users, class_name: 'Lama::User', module: :devise
end
