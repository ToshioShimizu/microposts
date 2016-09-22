class UsersController < ApplicationController
  
  def show # 追加
   @user = User.find(params[:id])
  end
  
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    check_user(@user)
  end

  def update
    @user = User.find(params[:id])
    check_user(@user)
   
    if @user.update_attributes(user_profile)
      redirect_to :edit_user, notice: "更新しました"
      # 更新に成功したときの処理
    else
      render 'edit'
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def user_profile
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :region)
  end
  
  def check_user(user)
    if (current_user != user)
      redirect_to :root
    end
  end
  
end