class RelationshipsController < ApplicationController

  def create
    followed=User.find(params[:follow_id])
    @user=User.find(params[:follow_id])
    @user.follow_create_notification_by(current_user)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def destroy
    refo=current_user.relationships.find(params[:id])
    @user=User.find(rel.follow_id)
    refo.destroy
    @user.follow_delete_notification_by(current_user)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  private

  def set_user
    user = User.find(params[:relationship][:follow_id])
  end
end
