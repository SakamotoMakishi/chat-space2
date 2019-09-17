class AppearanceChannel < ApplicationCable::Channel

  def subscribed
    # stream_from "some_channel"
    member = User.where(id: current_user.id).first
    return unless member
    member.update_columns(online: true, online_at: DateTime.now)
    stream_from "appearance_user"
    current_user.appear
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    member = User.where(id: current_user.id).first
    return unless member
    member.update_columns(online: false, online_at: DateTime.now)
    current_user.disappear
  end

  def appear(data)
    current_user.appear(on: data['appearing_on'])
  end

  def away
    current_user.away
  end
end
