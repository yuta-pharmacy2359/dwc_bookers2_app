class BookCommentsController < ApplicationController
  before_action :baria_user, {only: [:edit, :update, :destroy]}

  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      flash[:notice] = "Comment was successfully created."
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Comment can't be blank."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    flash[:notice] = "Comment was successfully destroyed."
    redirect_back(fallback_location: root_path)
  end

  private

  def baria_user
    unless BookComment.find(params[:id]).user.id.to_i == current_user.id
      redirect_to books_path
    end
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
