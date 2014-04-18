When(/^I send get|GET request to "(.+)"$/) do |path|
  get path unless @user
  get(
      path,
      nil,
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token)
  ) if @user 
end


Then(/^I should receive a (\d+) status result$/) do |status|
  last_response.status.to_s.should == status
end


Given(/^I am signed in with email: "([^"]*)", password: "([^"]*)"$/) do |email, password|
  @user = User.find_by email: email
end


When(/^I send POST request to "(.+)" with the following data:$/) do |path, data|
  post path, JSON.parse(data) unless @user
  post(
      path,
      JSON.parse(data),
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token)
  ) if @user
end


And(/^I should receive the following response:$/) do |data|
  last_response.body.should == data
end
