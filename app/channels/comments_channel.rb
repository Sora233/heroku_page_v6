class CommentsChannel < ApplicationCable::Channel
  def subscribed_on_post(data)
    post = Post.find(data["post_id"])
    stream_for post
  end

  def receive(data)
    byebug
  end

  def test(data)
    post = Post.find(data["post_id"])
    c = post.comments.new
    c.user = post.user
    c.content = "{}"
    CommentsChannel.broadcast_to post, { comment: CommentsController.render(partial: "comments/comment", locals: { comment: c }), comment_id: 1 }
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
