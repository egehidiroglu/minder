class BooksController < ApplicationController
  def index
    if params[:query].present?
      sql_query = <<~SQL
        books.name ILIKE :query
        OR books.description ILIKE :query
        OR creators.name ILIKE :query
      SQL
      @books = Book.joins(:creator).where(sql_query, query: "%#{params[:query]}%")
    else
      @books = Book.all
    end
    @pictures = Book.all.sample(3)
  end

  def show
    @book = Book.find(params[:id])
  end

  def favorite_book
    book = Book.find(params[:id])
    current_user.favorite(book)
  end
end
