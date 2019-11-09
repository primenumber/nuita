class CensoringsController < ApplicationController
  before_action :authenticate_user!

  def update
    begin
      Category.pluck(:name).each do |category_name|
        if current_user.censoring?(category_name)
          current_user.uncensor(category_name) if params[category_name] == '0'
        else
          current_user.censor(category_name) if params[category_name] == '1'
        end
      end
      flash[:success] = '検閲カテゴリの設定に成功しました'
    rescue => e
      flash[:danger] = "検閲カテゴリの設定に失敗しました: #{e}"
    ensure
      redirect_to edit_user_registration_path(current_user)
    end
  end
end
