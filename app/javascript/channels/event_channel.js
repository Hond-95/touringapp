import consumer from "./consumer"

$(function() {
  const chatChannel = consumer.subscriptions.create({channel: 'EventChannel',event: $('#messages').data('event_id')}, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      // Called when there's incoming data on the websocket for this channel
      $('#messages').append(data['message']);
      return scrollToBottom();
    },

    speak: function(message) {
      return this.perform('speak', {message: message});
    }
  });

  //画面スクロール
  window.scrollToBottom = () => {
      console.log('スクロール')
      window.messageContent = document.getElementById('chat-scroll')
      messageContent.scrollTop = messageContent.scrollHeight;
  }
  scrollToBottom()

  $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
    if (event.keyCode === 13) {
      chatChannel.speak(event.target.value);
      event.target.value = '';
      return event.preventDefault();
    }
  });
});

