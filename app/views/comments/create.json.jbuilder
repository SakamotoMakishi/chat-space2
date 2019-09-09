json.comment  @comment.comment
json.comment_id  @comment.id
json.user_id  @comment.user.id
json.user_name  @comment.user.nickname
json.user_avatar  avatar(current_user)
json.time     time_ago_in_words(@comment.created_at)