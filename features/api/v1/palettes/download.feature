Feature: In order to sync data between web and romibo controller
  As the palette owner
  I want to download all palettes into the controller
  
Background: 
  Given a user exists with email: "test@romibo.com"  
#  And 5 palettes exist with owner: user
  
  
Scenario: User cannot download palettes without signing in
  When I send GET request to "/api/v1/palettes"
  Then I should receive a 401 status result

Scenario: Signed in user receives HTTP status code
  Given I am signed in with email: "test@romibo.com", password: "password"
  When I send GET request to "/api/v1/palettes"
  Then I should receive a 200 status result
  
  
