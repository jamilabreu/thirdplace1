class UsersController < ApplicationController
  def index
  	@users = User.all.page(params[:page])#.per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def signup
  end

  def login
  end
end
