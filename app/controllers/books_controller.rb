class BooksController < ApplicationController
  before_action :baria_user, {only: [:edit, :update, :destroy]}

  def create
    @user = current_user
    @books = Book.page(params[:page]).reverse_order
    @book = Book.new(book_params)
    @book.user_id = @user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
    @favorite = Favorite.new
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @favorite = Favorite.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] ="Book was successfully destroyed."
    redirect_to books_path
  end

  private

  def baria_user
    unless Book.find(params[:id]).user.id.to_i == current_user.id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
