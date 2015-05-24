require_relative '../lib/camera_model'
require_relative '../lib/camera_image'
require_relative '../lib/to_slug'
require 'faker'
require 'rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end