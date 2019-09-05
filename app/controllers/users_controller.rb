class UsersController < ApplicationController

  def root
  end

  def index
    @user = User.all
    @users = User.all.where.not(id: current_user.id)
  end

end
