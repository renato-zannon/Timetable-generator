Feature: User adds new group

  As an User
  I want to add new groups to disciplines
  So that the system can process them for me
  
  Scenario: Add new valid group
    Given a saved discipline "Bases Matemáticas", with code "BC0001" and TPI "4-0-6"
    And a group named "A Diurno" with the following lessons:
    | monday    | 08:00,08:30,09:00,09:30 |
    | tuesday   |                         |
    | wednesday | 10:00,10:30,11:00,11:30 |
    | thursday  |                         |
    | friday    |                         |
    | saturday  |                         |
    When I add the group to the system
    Then the group should be listed in the discipline's groups
    
    
