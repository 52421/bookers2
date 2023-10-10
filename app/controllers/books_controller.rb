class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  
  def show
    @book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def create
    @book = Book.new(book_params)
    @book.user = @current_user_id
     if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path
     else
       flash.now[:alert] = "errors prohibited this book from being saved."
       render :index
     end
  end  
  
  def edit
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
  end

  def update
    @book.user = current_user
    if @book.update(book_params)
        redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end
  
  def destroy
    @book.destroy
    redirect_to book_path, notice: "successfully delete book!"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
      @book = Book.find(params[:id])
   unless @book.user == current_user
      redirect_to books_path
   end
  end

end