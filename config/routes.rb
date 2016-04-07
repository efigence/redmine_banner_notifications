resources :banners, except: :show
post '/banners/close', to: 'banners#close'
get '/banners/show_all', to: 'banners#show_all'
