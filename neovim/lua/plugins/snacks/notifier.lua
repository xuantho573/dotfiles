return {
  keys = {},
  ---@class snacks.notifier.Config
  ---@field enabled? boolean
  ---@field keep? fun(notif: snacks.notifier.Notif): boolean # global keep function
  ---@field filter? fun(notif: snacks.notifier.Notif): boolean # filter our unwanted notifications (return false to hide)
  opts = {
    style = "fancy",
  },
}
