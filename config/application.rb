require "bundler/setup"
require "rage"
Bundler.require(*Rage.groups)

require "rage/all"

Rage.configure do
  config.public_file_server.enabled = true
end

require "rage/setup"

require 'dotenv'
Dotenv.load
