class PostsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "posts"
  end

  def receive(data)
    ActionCable.server.broadcast("posts", data)
  end
end
