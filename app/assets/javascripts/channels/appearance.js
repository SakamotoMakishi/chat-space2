App.appearance = App.cable.subscriptions.create({
  channel:'AppearanceChannel'
}, {
  received: function(data) {
    var user = JSON.parse(data)

    if (user.online === true){
      var element = document.getElementById("users-list");
        element.insertAdjacentHTML("afterbegin", "<li class='user-login'>" + user.display_name + "</li>");
    };
    if (user.online === false){
      var element = document.getElementById("users-list");
        element.insertAdjacentHTML("afterbegin", "<li class='user-logout'>" + user.display_name + "</li>");
    };
  }
});
