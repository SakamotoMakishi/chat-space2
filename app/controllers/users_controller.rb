class UsersController < ApplicationController

  def root
    @members = current_user.groups
  end

  def index
    @user = User.all
    @users = User.all.where.not(id: current_user.id)
    @group = Group.new
    @group.users << current_user
  end

  def show
    @group = Group.new
    @user = User.find(params[:id])
    @posts = @user.posts
  end

end
