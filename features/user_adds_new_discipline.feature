Feature: User adds new discipline

    As an User
    I want to add new disciplines to the system
    So that I can search for them later
    
    Scenario: Add new valid discipline
      Given a new discipline named "Bases Matemáticas", with code "BC0001" and TPI "4-0-6"
      When I add the discipline to the system
      Then the discipline should be saved in the DB
    
    Scenario Outline: Try to add invalid discipline
      Given a new discipline named <name>, with code <code> and TPI <tpi>
      When I add the discipline to the system
      Then the Discipline inclusion form should be shown again
      And I should receive an error
    
    Scenarios: invalid name
      |  name  |  code    |   tpi   |
      |   ""   | "BC1234" | "4-0-6" |
      
    Scenarios: invalid code
      |        name         |   code   |   tpi   |
      | "Bases Matemáticas" | "001234" | "4-0-6" |
      | "Bases Matemáticas" |    ""    | "4-0-6" |
      | "Bases Matemáticas" | "XD1234" | "4-0-6" |
      | "Bases Matemáticas" | "BCABCD" | "4-0-6" |
      
    Scenarios: invalid tpi
      |        name         |   code   |   tpi   |
      | "Bases Matemáticas" | "BC0001" |    ""   |
      | "Bases Matemáticas" | "BC0001" |  "406"  |
      | "Bases Matemáticas" | "BC0001" | "a-b-c" |
