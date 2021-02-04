class FavoritesController < ApplicationController

  def create
    @favorite = current_user.favorites.create(book_id: params[:book_id])
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    @favorite.destroy
  end

end