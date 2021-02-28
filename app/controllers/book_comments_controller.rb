class BookCommentsController < ApplicationController
  before_action :baria_user, { only: [:edit, :update, :destroy] }

  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      flash.now[:notice] = "Comment was successfully created."
    else
      flash.now[:alert] = "Comment can't be blank."
    end
  end

  def destroy
    @book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @book_comment.destroy
    @book = @book_comment.book
    flash.now[:notice] = "Comment was successfully destroyed."
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
