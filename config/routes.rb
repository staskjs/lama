Lama::Engine.routes.draw do
  devise_for :users, class_name: 'Lama::User', module: :devise

  scope :cart, as: :cart, controller: :cart do
    get 'add'
  end
end
