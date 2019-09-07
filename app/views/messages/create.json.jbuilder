json.name    @message.user.nickname
json.user_avatar avatar(@message.user)
json.content @message.content
json.date    @message.created_at.strftime("%Y/%m/%d %H:%M")
json.image   url_for(@message.image) if @message.image.attached?
json.id      @message.id
