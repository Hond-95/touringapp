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
      const current_user_id=$("#current_user_id").val();
      var sentence = "";

      if (current_user_id == data["message"]["user_id"]) {
        sentence = `<div class="row message-body"><div class="col-sm-12 mb-3"><div class="message-sender-position">
        <span class="message-info">${data["name"]}<br>${data["time"]}</span>
        <div class="message-sender"><p class="message-font">${data["message"]["message"]}</p>
        </div></div></div></div>`;
      } else {
        sentence =`<div class="row message-body"><div class="message-receiver mb-3"><p class="message-font">${data["message"]["message"]}
        </p></div><span class="message-info">${data["name"]}<br>${data["time"]}</span></div>`
      }

      $('#messages').append(sentence);
      return scrollToBottom();
    },

    speak: function(message) {
      return this.perform('speak', {message: message});
    }
  });

  //画面スクロール
  window.scrollToBottom = () => {
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

