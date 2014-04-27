Feature: In order to integrate data between Romiboweb and Romibo Controller
  As a User
  I should be able to sync new palettes to Romiboweb
  
  Background:
    Given a user exists with email: "test@romibo.com"
  
  Scenario: User cannot sync data without signing in
    When I send POST request to "/api/v1/palettes" with the following data:
    """
    {"palette":{"title": "Who am I?"}}
    """
    Then I should receive a 401 status result

  Scenario: When is signed in and palette data is invalid then new palette is not created
    Given I am signed in with email: "test@romibo.com", password: "password"
    When I send POST request to "/api/v1/palettes" with the following data:
    """
    {"palette":{"title": ""}}
    """
    Then I should receive a 422 status result
    And I should receive the following response:
    """
    {"title":["can't be blank"]}
    """
    And user should have 4 palettes

  Scenario: When user is signed in and palette data is valid then new palette is created
    Given I am signed in with email: "test@romibo.com", password: "password"
    When I send POST request to "/api/v1/palettes" with the following data:
    """
    {"palette":
      {"title": "My Palette", 
      "buttons": [
        {
          "title":"Button 1",
          "speech_phrase":"Hello",
          "speech_speed_rate":"0.2",
          "color":"#13c8b0",
          "size":"large"
        },
        {
          "title":"Button 2",
          "speech_phrase":"Hello",
          "speech_speed_rate":"0.2",
          "color":"#13c8b0",
          "size":"large"
         }]
      }
    }
    """
    Then I should receive a 201 status result
    And palette should exist with title: "My Palette"
    And palette should be amongst user's palettes
    And button should exist with title: "Button 1"
    And button should be amongst palette's buttons
    And palette should have 2 buttons
    # user should now contain 5 palettes including 4 default ones
    And user should have 5 palettes
  
  
