class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def favorite_book
    book = Book.find(params[:id])
    current_user.favorite(book)
    redirect_to books_path
  end
end
