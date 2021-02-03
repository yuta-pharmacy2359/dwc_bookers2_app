class RelationshipsController < ApplicationController
  before_action :logged_in_user, {only: [:create, :destroy]}

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_back(fallback_location: root_path)
  end

  private

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

end
