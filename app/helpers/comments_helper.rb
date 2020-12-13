module CommentsHelper
  def commentable_comment_path(commentable, comment)
    send "#{commentable.class.name.downcase}_comment_path", commentable, comment
  end
end
