class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    @books = Book.all
    @book = Book.new
  end
  
  def show
    @newbook = Book.new
    @book = Book.page(params[:page])
    @user = @book.user
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
     if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path
     else
       @books = Book.all
       render 'index'
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