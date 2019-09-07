json.array! @messages do |message| #自動更新用のjbuilder
  json.content      message.content
  json.image        url_for(message.image) if message.image.attached?
  json.date         message.created_at.strftime("%Y/%m/%d %H:%M")
  json.name         message.user.nickname
  json.user_avatar  avatar(message.user)
  json.id           message.id
end
