Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #topページのurlを/にする
  get '/' => 'homes#top'
  #ルートトップにtopページを設定
  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'

  resources 'books', only: [:index, :show, :create, :edit, :update, :destroy] do
    #userがいいねしたのは、どの投稿なのかわかるようにするためbookにネストさせる
    #resourceのすることで、urlにいいねのidを含めないようにしている
    resource 'favorites', only: [:create, :destroy]
    #ネストしたURLを作成することでparams[:book_id]でBookのidが取得できるようになる
    resources 'book_comments', only:[:create, :destroy]
  end

  resources 'users', only: [:index, :show, :edit, :update]
end
