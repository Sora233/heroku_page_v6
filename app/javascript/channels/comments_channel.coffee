import consumer from "./consumer"

$(document).on 'turbolinks:load', ->
  if $("[data-channel='comments']").length > 0
    commentsChannel = consumer.subscriptions.create "CommentsChannel",
      collection: -> $("[data-channel='comments']")

      connected: ->
        @followCurrentPost()
        @pageChangeCallback()

      received: (data) ->
        $(".empty-comment").remove()
        @collection().prepend(data.comment)

      followCurrentPost: ->
        postId = @collection().data('post-id')
        if postId
          @perform 'subscribed_on_post', post_id: postId
        else
          @perform 'unsubscribe_all_post'

      pageChangeCallback: ->
        unless @pageChangeCallbackInstalled
          @pageChangeCallbackInstalled = true
          $(document).on 'turbolinks:load', -> commentsChannel.followCurrentPost()

