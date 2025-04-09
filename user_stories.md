# Health tracker user stories

This file tracks all the user stories for the app. All the user stories need to be added in the template defined below.

## User story template
**Representative title**

_As a [user role], I want [feature/goal], so that [reason]._

**Acceptance criteria:**
1. [Criteria 1]
2. [Criteria 2]
3. [Criteria 3]

**Priority:** [High/Medium/Low]
**Notes:**
  - [Additional information or edge cases] 


## Registration and login page
1.  **Account registration**

    As a user, I want to register with my name, email id and password so that I can create a new account and access the health tracking features.
    
    **Acceptance criteria:**
    1. Screen with appropriate elements for new user registration

    **Priority:** High

    **Notes:**
    - User credentials to be stored appropriately.

2.  **Account login**

    As a user, I want to login using my email id and password so that I can access my account

    **Acceptance criteria:**
    1. Screen with appropriate elements for user login

    **Priority:** High

    **Notes:**
    - Validate user credentials

3.  **Error feedback on login**

    As a user, I want to receive a message if I enter wrong credentials so that I know my login attempt was unsuccessful.

    **Acceptance criteria:**
    1. Display of the error message on the login screen when wrong credentials are entered

    **Priority:** High

    **Notes:**
    - Raise alert message with the error.

4. **Store user data**
   As a user, I want my account details to be saved in local storage so that the date persists between app sessions.

   **Acceptance criteria:**
   1. Demonstrate the storage of user details
  
   **Priority:** High

   **Notes:**
   - Store the user details in local storage

## Home Screen

1. **Medicine reminders**

   As a user, I want to be able to add reminders for medicines on the home screen so that I can make to sure to take my medications on time.

   **Acceptance criteria:**
   1. A medicine reminder tab in the homescreen

   **Priority:** High

   **Notes:**
   - Add a tab to the homescreen
3. **Parameter monitoring**

   As a user, I want to be able to see various health parameters such as BP, blood glucose, etc., on the home screen so that I can track my health.

   **Acceptance criteria:**
   1. A health parameter monitoring tab in the homescreen.
  
   **Priority:*** High

   **Notes:**
   - Add a tab to the home screen

## Menu

1. **Access menu options**

   As a user, I want to access a menu with options to edit my profile and sign out, so that I can manage my profile and sign out of the application.

   **Acceptance criteria:**
   1. A menu with two options is to be developed

   **Priority:** High

   **Notes:**
   - Have the menu as a simple list of options.
   
3. **Edit profile**

   As a user, I want to be able to edit profile from the menu, so that I can make sure my profile is correct and upto date.

   **Acceptance criteria:**
   1. Profile edit page to be developed

   **Priority:** High

   **Notes:**
   - Make in place editable profile page.
   
4. **Sign out from menu**

   As a user, I want to sign out of my account using an option in the menu, so that I can securely log out when I'm finished using the app.

   **Acceptance criteria:**
   1. Signout functionality in menu

   **Priority:** High

   **Notes:**
   - Implement sign out functionality
  
## Profile page

1. **View personal information**

   As a user, I want view my saved name, email id and age on my profile page, so that I see the details provided during registration.

   **Acceptance criteria:**
   1. Screen to view personal details

   **Priority:** High

   **Notes:**
   - The details need to be clearly displayed with appropriate margins

2. **Edit personal information**

   As a user, I want edit my saved name, email id and age on my profile page, so that I keep my details upto date.

   **Acceptance criteria:**
   1. Screen to edit personal details

   **Priority:** High

   **Notes:**
   - Implement a form to modify details.
  
3. **Save updated personal information**

   As a user, I want the changes I make to my profile to be saved, so that my updated details are stored and reflected throughout the app.

   **Acceptance criteria:**
   1. Screen to save the updated personal details

   **Priority:** High

   **Notes:**
   - Implement save functionality in the same details edit form
  
## Medicine reminder page

1. **Add new meidicine reminder**

   As a user, I want to add new medicine reminder on the medicine reminder page, so that I can track new medicines on the app.

   **Acceptance criteria:**
   1. Screen to add new medicine reminders

   **Priority:** High

   **Notes:**
   - Can implement this through a floating action button.

2. **Delete meidicine reminder**

   As a user, I want to delete medicine reminder on the medicine reminder page, so that I can remove reminders which are no longer required.

   **Acceptance criteria:**
   1. Option to delete for each reminder.

   **Priority:** High

   **Notes:**
   - An option can be provided for each reminder in its card.

## Parameters tracking page

1. **Add new parameter to tracker**

   As a user, I want to add new parameter to the tracking page, so that I can track multiple parameters

   **Acceptance criteria:**
   1. Screen to add new parameter to track

   **Priority:** High

   **Notes:**
   - Can implement this through a floating action button.

2. **Add value to a parameter in tracker**

   As a user, I want to add new value to a parameter to the tracking page, so that I can maintain the update and maintain parameter history

   **Acceptance criteria:**
   1. Screen to add new value to the parameter

   **Priority:** High

   **Notes:**
   - Can implement this through an option to add new value in the parameter card.

3. **Delete parameter from tracker**

   As a user, I want to delete a parameter from the tracking page, so that I can remove parameters which are no longer required.

   **Acceptance criteria:**
   1. Option to delete for each parameter.

   **Priority:** High

   **Notes:**
   - An option can be provided for each tracker in its card.
