class RelationshipsController < ApplicationController

  def create
    followed=User.find(params[:follow_id])
    @rel=current_user.follow(followed)
    @user=User.find(params[:follow_id])
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def destroy
    rel=current_user.relationships.find(params[:id])
    @user=User.find(rel.follow_id)
    rel.destroy
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
