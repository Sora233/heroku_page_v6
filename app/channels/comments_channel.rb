class CommentsChannel < ApplicationCable::Channel
  def subscribed_on_post(data)
    post = Post.find(data["post_id"])
    stream_for post
  end

  def unsubscribe_all_post
    stop_all_streams
  end

  def test(data)
    post = Post.find(data["post_id"])
    comment = Comment.first
    renderer = ApplicationController.renderer_with_signed_in_user(current)
    CommentsChannel.broadcast_to post, comment: renderer.render(partial: "comments/comment", locals: { comment: comment })
  end
end
