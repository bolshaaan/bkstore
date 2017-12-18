class BooksController < ApplicationController

  before_action :require_admin, :only => [:create, :update, :new, :delete]

  def index
    @books = Book.page(params[:page])
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_path
    else
      render 'new'
    end
  end

  def buy
    @book = Book.find(params[:id])

    puts "AA"
    if @book.count > 0
      @book.count -= 1
      @book.save
    else
      # nothing to buy
      flash.now[:error] = "Sorry, book is out of stock"
    end
  end

  def destroy
    @book = Book.find(params[:id])

    @book.destroy

    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update

    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end

  end

  private
    def book_params
      params.require(:book).permit(:title, :price, :count)
    end

    def require_admin
      unless current_user && current_user.is_admin
        flash.now[:error] = "ERROR: You must be logined as admin!!!"
        redirect_to sign_in_path
      end
    end

end
