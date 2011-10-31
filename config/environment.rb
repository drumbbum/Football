# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Football::Application.initialize!

$CURRENT_WEEK = 2
Time.zone = -4