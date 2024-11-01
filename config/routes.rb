Rage.routes.draw do
  put "wled/light", to: "wled#light"
  get "wled/status", to: "wled#status"
  put "elgato/light", to: "elgato#light"
  get "elgato/status", to: "elgato#status"
  root to: ->(env) { [200, {}, "It works!"] }
end
