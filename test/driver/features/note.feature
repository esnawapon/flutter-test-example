Feature: Note

  Scenario: As a user, I can write my note and I can save it
    Given I never saved any note
    And I restart the app
    And I wait until the "writing_button" is present
    When I tap the "writing_button" button
    Then I wait until the "new_note_page" is present

    When I fill the "new_note_title_field" field with "Shopping list"
    And I fill the "new_note_content_field" field with "1 pack of eggs"
    And I tap the "save_note_button" button

    Then I wait until the "new_note_page" is absent
    And I wait until the "note_item_index[0]" is present

    And I expect the text "Shopping list" to be present within the "note_item_index[0]"
    And I expect the text "1 pack of eggs" to be present within the "note_item_index[0]"

  Scenario: As a user, I can delete my note
    Given I have a saved note
    And I restart the app
    And I wait until the "note_item_index[0]" is present
    When I tap the "note_item_id[TEST_NOTE_01]_delete_button" button
    Then I wait until the "note_item_index[0]" is absent

