class ApplicationController < ActionController::Base
  # もしdeviseに関するコントローラーの処理であれば、そのときだけconfigure_permitted_parametersメソッドを実行する
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # メソッド名は慣習
  def configure_permitted_parameters
    # (:sign_in = ログイン/:sign_up = 新規登録, keys: [:各処理をする時に必要なキー])※※email,passwordはデフォルトで保存できるようになっている※※
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday])
  end
end
