Rails.application.routes.draw do
  namespace :admin do
    get 'orders/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
  end
  namespace :public do
    get 'shipping_addresses/index'
    get 'shipping_addresses/edit'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/unsubscribe'
    get 'customers/edit'
  end
  namespace :public do
    get 'orders/new'
    get 'orders/confirm'
    get 'orders/thanks'
    get 'orders/show'
    get 'orders/index'
  end
  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
 devise_for :admin, controllers: {
  sessions:      'admin/sessions',
  passwords:     'admin/passwords',
  registrations: 'admin/registrations'
}
devise_for :customers, controllers: {
  sessions:      'public/sessions',
  passwords:     'public/passwords',
  registrations: 'public/registrations'
}

end
