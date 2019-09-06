class GroupsController < ApplicationController
  
  def create
    @group = Group.new(group_params)
    if @group.save!(validate: false)
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [] )
  end

end
