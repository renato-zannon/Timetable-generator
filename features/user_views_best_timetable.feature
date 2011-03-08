Feature: User views best timetable

  As an User
  I want to view the best possible timetable
  So that I can make my matriculation aware of it

  Scenario: View timetable with 3 disciplines
    Given a saved discipline "Bases Matemáticas", with code "BC0001" and TPI "4-0-6"
    And a saved discipline "Bases Computacionais", with code "BC0002" and TPI "4-0-6"
    And a saved discipline "Origens da Vida", with code "BC0003" and TPI "4-0-6"
    And a saved group named "A Diurno", bound to "BC0001", and with the following lessons: 
      | monday    | 08:00,08:30,09:00,09:30 |
      | tuesday   |                         |
      | wednesday | 10:00,10:30,11:00,11:30 |
      | thursday  |                         |
      | friday    |                         |
      | saturday  |                         |
    And a saved group named "B Diurno", bound to "BC0002", and with the following lessons: 
      | monday    | 10:00,10:30,11:00,11:30 |
      | tuesday   |                         |
      | wednesday | 08:00,08:30,09:00,09:30 |
      | thursday  |                         |
      | friday    |                         |
      | saturday  |                         |
    And a saved group named "C Diurno", bound to "BC0003", and with the following lessons: 
      | monday    |                         |
      | tuesday   | 08:00,08:30,09:00,09:30 |
      | wednesday |                         |
      | thursday  | 10:00,10:30,11:00,11:30 |
      | friday    |                         |
      | saturday  |                         |
    When I go to the /best_timetable page
    And I check "BC0001" from the list of disciplines
    And I check "BC0002" from the list of disciplines
    And I check "BC0003" from the list of disciplines
    And I press "Submit" 
    Then I should see a timetable containing the disciplines:
      | BC0001 |
      | BC0002 |
      | BC0003 |
