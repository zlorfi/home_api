Rage.routes.draw do
  TEMPLATE = <<~HTML
    <!DOCTYPE html>
    <html>
      <head>
        <title>Home API documentation</title>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <meta charset='utf-8'>
        <style>body {margin: 0;padding: 0;}</style>
      </head>
      <body>
        <redoc spec-url='/api/home-api.yaml'></redoc>
        <script src='/redoc.standalone.js'> </script>
      </body>
    </html>"
  HTML

  put "wled/light", to: "wled#light"
  get "wled/status", to: "wled#status"
  put "wled/toggle", to: "wled#toggle"
  put "elgato/light", to: "elgato#light"
  get "elgato/status", to: "elgato#status"
  put "elgato/toggle", to: "elgato#toggle"
  put "pihole/disable", to: "pihole#disable"
  root to: ->(env) { [200, {}, TEMPLATE] }
end
