class CommentsChannel < ApplicationCable::Channel
  def subscribed_on_post(data)
    post = Post.find(data["post_id"])
    stream_for post
  end

  def unsubscribe_all_post
    stop_all_streams
  end
end
