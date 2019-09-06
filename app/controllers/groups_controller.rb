class GroupsController < ApplicationController
  
  def show
    @group = Group.find(params[:id])
    @member = Group.find(params[:id]).members
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user
    if @group.save!(validate: false)
      redirect_to group_path(@group)
    else
      render :show
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, {user_ids: []} )
  end

end
