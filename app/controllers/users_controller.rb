class UsersController < ApplicationController

  def root
    @group = Group.new
    @group.users << current_user
  end

  def index
    @user = User.all
    @users = User.all.where.not(id: current_user.id)
    @group = Group.new
    @group.users << current_user
  end

end
