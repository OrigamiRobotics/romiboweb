When /^I send GET request to "([^\"]*)"$/ do |path|
  get path
end

Then(/^I should receive a (\d+) status result$/) do |status|
  last_response.status.to_s.should == status
end


Given(/^I am signed in with #{capture_fields}$/) do |fields|
  post 
end

And(/^I have received auth_token: 'secret'$/) do
  pending
end
