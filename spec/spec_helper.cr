require "../src/*"

require "spectator"
require "webmock"

Spectator.configure do |config|
  config.randomize # Randomize test order.
end
