module ApplicationHelper
  def avatar(user)
    if user.avatar.attached?
      url_for(user.avatar)
    else
      '//static.mercdn.net/images/member_photo_noimage_thumb.png'
    end
  end
end
