class GroupsController < ApplicationController

  def create
    @group = Group.new(group_params)
    @group.users << current_user
    if @group.save!(validate: false)
      redirect_to group_messages_path(@group)
    else
      render :show
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, {user_ids: []} )
  end

end
