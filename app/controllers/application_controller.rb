class ApplicationController < ActionController::Base
  # top,aboutアクション?を除く他アクションはログインしていないと開けないという意味
  # 全てのコントローラの操作ができるapplicationコントローラに記述
  before_action :authenticate_user!, except:[:top, :about]
  #devise利用の機能（sign_up,log_in）の前にconfigure_permitted_parametersメソッドが実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  #deviseが用意しているメソッド
  #log_in.log_out後の画面の遷移先を指定
  def after_sign_in_path_for(resource)
    user_path(current_user)
    # 同じ　user_path(resource)
  end

  def after_sign_out_path_fo(resource)
    '/'
  end

  #呼び出された他のコントローラからも参照できる.privateは記述をしたコントローラからのみ参照
  #なくてもよさそう
  protected

  #sign_upの際に、ユーザー名(name)のデータ操作を許可。ストロングパラメータと同様の機能
  #メールアドレスの操作も許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :email])
  end
end
