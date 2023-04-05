# spacex

(built and tested on android emulator Pixel 3a API 33x86 64)

what has been completed:

1. the game has start page on click of which the game will begin
2. the game is played in full screen landscape mode
3. In the game screen page time is shown on the top right corner of the page
4. in the top left corner user can see the number of lives left (also tried )
5. the player can be dragged up and down 
6. the number of obstacles rendered on the screen will be based on the time 
7. on collision with the obstacles a collision sound is produced and also the sound can be heard when the player is dragged up and down
8. a pause game button is rendered on the bottom left corner of the screen using overlay
9. on exhaustion of all the three lives the game will end with a game over screen
10. the letters are rendered on the screen
11. whenever the player collides with correct letters that letter changes it's color to amber from white
12. on success when the player clicks on the screen the words will change randomly


what is not completed:

1. the collision animation (half done and )
2. not tested for iOS(due to unavailability of mac)
3. not tested the dynamic sizing working on other devices.

deployment steps:

1. entry point of the project is in main.dart dart file where in the GamePlay widget the GameWidget and the overlays are initiated
2. the project in total contains 6 subfolders in the lib folder
3. the SpaceGame class extends the FlameGame which holds all the game variables to be used in the whole game. Also routes are initiated in this class with the initial route StartScreen from where the game begins
4. after the start page the main screen is displayed through the GamePlayScreen where all the game components are added to the screen
5. the game play screen is where all the action happens
6. all the game components used in the game are under the actors folder
7. there are three types of obstacles 
    i.   letter obstacles : which are not the letters of the particulalar word shown
    ii.  word letters : whcih are the letters of the particular word shown
    iii. obstacle : general obstacles which are not letters
7. the collision of the player and the obstacles are found through the collisionCallbacks  
8. after collision the particular obstacle will be removed from the parent 
9. after three collisions with non word letters the game over screen will be displayed and the tracking of lives is done through the lives variable which is instantiated in the SpaceGame class 
10. after successfully collecting all the letters of the word success screen will be shown on click of which the game will restart with a new word

known bugs:

1.the changing of colors of the letters of the word overlaps sometimes
2. the obstacles are grouped sometimes and may go out of the screen 
3. on first running the app shows black screen on click of which the game will start
