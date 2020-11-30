class UsersController < ApplicationController
  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @users = User.all
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
     @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def new
    @book = Book.new
  end

  def create
    @users = User.all
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
