App.cable.subscriptions.create "AppearanceChannel",
# Subscriptionがサーバー側で利用可能になると呼び出される。
  connected: ->
    @install()
    @appear()

# WebSocket Connectionが閉じると呼び出される。
  disconnected: ->
    @uninstall()

# Subscriptionがサーバーに拒否されると呼び出される。
  rejected: ->
    @uninstall()

  appear: ->
    # サーバーの`AppearanceChannel#appear(data)`を呼び出す
    @perform("appear", appearing_on: $("main").data("appearing-on"))

  away: ->
    # サーバーの`AppearanceChannel#away`を呼び出す
    @perform("away")

  buttonSelector = "[data-behavior~=appear_away]"

  install: ->
    $(document).on "turbolinsk:load.appearnace", =>
      @appear()

    $(document).on "click.appearnace", buttonSelector, =>
      @away()
      false

    $(buttonSelector).show()

  uninstall: ->
    $(document).off(".appearance")
    $(buttonSelector).hide()