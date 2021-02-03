class UsersController < ApplicationController
  before_action :baria_user, {only: [:edit, :update]}
  before_action :logged_in_user, {only: [:create, :destroy]}

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.page(params[:page]).reverse_order
  end

  def index
    @user = current_user
    @book = Book.new
    @users = User.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def following
    @title = "Follows"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).reverse_order
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).reverse_order
    render 'show_follow'
  end

  private

  def baria_user
    unless User.find(params[:id]).id.to_i == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
