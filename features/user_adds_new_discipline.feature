Feature: User adds new discipline

    As an User
    I want to add new disciplines to the system
    So that I can search for them later
    
    Scenario: Add new discipline
        Given a discipline named "Bases Matemáticas", with code "BC0001" and TPI "4-0-6"
        When I add the discipline to the system
        Then the discipline should be saved in the DB
