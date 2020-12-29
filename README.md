**** PROGRAMMER'S EXPLANATION ****

-Project is developed in Xcode Version 12.3 (12C33) with Swift 5.3.2 and iOS 14.3, In this configuration, there was no layout issue or any compile-time error or warning.

-Project is made with MVVM architecture.

-Project is fully programmatically - No storyboard. To make it really easy we have used a native anchor class.

-To cache the music details, I have taken CoreDB. All songs will be first loaded from API and it will be cached forever in DB. To cache the song Data(Preview Music), the User must have to click on each song. 

-Once the user clicks and downloads completed, Song-Preview will be cached forever.

-I have tried to cache songs preview at a time of loading API but Apple has some restriction (I am not sure). I have executed the project multiple times and Apple has blocked my IP. 

-Once the user clicks on the downloaded preview, the details view will open and the song will start to play. Once the song ends - The view will disappear automatically.

-To hide the presented view - Please drag down the view from the navigation bar. (I have not put a close button).

-There is localization enabled for English and French. To test it; goto the Utilities/Helper file and change currentSelectedLanguage property. e.g 'fr' or 'en'.

-There is a color theme feature where we can set a different theme for the app. To test goto Theme Managers/AppColors and change the theme. This will help us to enable dark mode. Along with this, we have dynamic fonts for iPad and iPhone.

-For each UIViewController (here we have only one but if multiple comes) ParentViewController is the parent. This will allow us to write reusable code.

-For tableview, there are a generic delegate and datasource classes. This will help us to reduce code redundancy. It makes code modular.

-To call APIs, we have all native classes which make implementation really easy. We have no third party classes or PODs to accomplish this exercise.

-To make this project fully adaptive for CI/CD, We have taken the config.json file for all essential URLs. DevOps guy can easily change it dynamically according to the environment. 

-App was tested in iPhone 11,8 and iPad 12.9 (Simulators).
