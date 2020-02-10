# FallingWords

## Description

I have chosen option one of the suggested challenges, Falling Words.

The app starts with asking the user 5 questions one after another. The user is shown two buttons, "Correct" and "Wrong", 
allowing user to answer if the shown translation is right or wrong. Every time the user selects either of the buttons or does
not perform any action till the translation label animates to bottom of the screen, next word is shown. The user is not scored
if he/she does not give any answer. The translations shown have equal probability of being correct or wrong.

After showing 5 words, the results screen is shown with the correct translations and with green or red color indicating which
questions were correctly answered.

Below is the high level architecture of the app.

<img width="766" alt="Babbel_Dependency_Diagram" src="https://user-images.githubusercontent.com/6704803/68544121-18a08a80-03c0-11ea-9cbf-2cd39c47faaf.png">


As shown in the diagram above, the Game Engine is a separate entity encapsulated in a platform agnostic framework with masOS
target. 
A separate game engine framework helps in plugging it to different Apple platforms like WatchOS, tvOS or macOS. Also, creating
a macOS target helps running tests much faster as it does not initialize a simulator.

Below are the screenshots of the app:

<img width="336" alt="Babbel_Screenshot_One" src="https://user-images.githubusercontent.com/6704803/68544325-44bd0b00-03c2-11ea-8089-1cce85ec8de5.png">  <img width="335" alt="Babbel_Screenshot_Two" src="https://user-images.githubusercontent.com/6704803/68544328-50a8cd00-03c2-11ea-9b64-b2aee567e72f.png">

I have followed TDD approach of implementing so that it ensures all scenarios are tested and each commit is tested successfully.

### How much time was invested

I spent around 5 hours to complete the app.

### How was the time distributed (concept, model layer, view(s), game mechanics)

The time was distributed as follows:

| Decription | Time taken |
| --- | --- |
| conceptualisation | 20 minutes |
| game engine | 1 hour 30 minutes |
| service layer that fetches words remotely or locally | 45 minutes |
| integrating app with game engine | 30 minutes |
| Question View | about 1 hour |
| Result View | about 1 hour |

### Decisions made to solve certain aspects of the game

- Create router protocol in framework so it can be implemented on any platform. e.g. NavigationViewController in iOS
- Having only one view controller to show all the words and store the answers along the way and then pass it to result
- Show if the user answered a question correclty or not, by coloring the translation green(right answer) or red(wrong answer)
- Pass completion handler with selected answers to flow in order for the game engine to calculate score and pass it on to
  results view
- While fetching words' translations, it has equal probability of fetching a correct or wrong one 
  
### Decisions made because of restricted time

- Once results are shown, user has to start app again to play next set of questions. Given time, user should be able to start
  new game
- Currently, there may be duplicate words shown as they are picked randomly
- The game does not have any levels
- The UX is very simple. Given time, it can be enhanced

### What would be the first thing to improve or add if there had been more time

To enable user to start a new game once results are shown.



Thank you once again for reviewing my code. Any valuable suggestions will help me become a better developer. 












