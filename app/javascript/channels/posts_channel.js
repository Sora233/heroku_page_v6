import consumer from "./consumer"

let postChannel = consumer.subscriptions.create({channel: "PostsChannel"}, {
    received: function (data) {
        console.log(data);
    }
})

$(document).on('turbolinks:load', function () {
    setTimeout(function () {
        postChannel.send({"message": "???"})
    }, 3000);
})