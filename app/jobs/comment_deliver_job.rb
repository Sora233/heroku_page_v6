class CommentDeliverJob < ApplicationJob
  queue_as :default

  def perform(comment, user)
    renderer = ApplicationController.renderer_with_signed_in_user(user)
    CommentsChannel.broadcast_to comment.commentable, comment: renderer.render(partial: "comments/comment", locals: { current_user: user, comment: comment, skip_op_button: true })
  end
end
