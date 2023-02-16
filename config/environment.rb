# Load the Rails application.
require_relative "application"

authorization = File.join(Rails.root, "config", "authorization.rb")
load(authorization) if File.exist?(authorization)

# Initialize the Rails application.
Rails.application.initialize!
