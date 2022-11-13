import consumer from "./consumer";

window.App = consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    document
      .querySelector('input[data-behavior="room_speaker"]')
      .addEventListener("keypress", (event) => {
        if (event.keyCode === 13) {
          this.speak(event.target.value);
          event.target.value = "";
          return event.preventDefault();
        }
      });
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const element = document.querySelector("#messages");
    console.log("received", data);
    element.insertAdjacentHTML("beforeend", data["messages"]);
  },

  speak: function (message) {
    return this.perform("speak", { message: message });
  },
});
