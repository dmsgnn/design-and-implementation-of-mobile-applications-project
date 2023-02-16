# __Design and Implementation of Mobile Applications project__

This project has been developed for the "Design and Implementation of Mobile Applications" course, attended during my Master of Science (A.Y. 2022/23) at the Polytechnic University of Milan. Final grade achieved: 27/30.

## Description

Aim of this project was to design, implement and test a mobile application in Swift called "karma", using the MVVM pattern. The application consists in a platform where it is possible to create an account to start a fundraising campaign to receive help through donations or to help someone else by donating to other campaigns. A non exhaustive list of the karma application features is the following:
- Registration and login on karma service, using email and password
- Creation of a new fundraising campaign, to receive donations from other users
- Bookmark campaigns to consult them in a second moment in the bookmark section
- Donation to an existing fundraising campaign

### Group
The project has been developed by me and one other student: Tommaso Bucaioni.

## Services

To implement karma, some external services and libraries have been used.

### Firebase

Firebase has been used as back-end service to build karma application. In particular, the services that have been utilised are: 
- authentication, to manage the creation and authentication of user accounts
- firestore, to save all the users, campaigns and payments data
- storage, to save all the profiles and campaigns images used within the application
- messaging, used in combination with Apple Push Notification service, to implement daily push notifications

### Apple Pay

Apple Pay service has been integrated into karma application to allow users to make donations to a campaign in a total secure way. Donations data such as amount, sender, receiver, ..., is saved in Firebase Firestore service.

### Libraries
|Library|Description|
|---------------|-----------|
|__SwiftUI__|modern framework to declare user interfaces for any Apple platform|
|__Firebase__|library to manage application's backend functionalities|
|__Kingfisher__|library for downloading and caching images from the web|
|__View Inspector__|library for unit testing SwiftUI views|

## Testing

Four types of tests have been performed to verify the correctness of the karma application: unit testing, integration testing, UItesting, acceptance testing. Unit and integration testing have lead to a coverage higher than 80%.

## Documentation
A more exhaustive list about karma functionalities and implementation can be found in the [design document](/deliverables/design_document.pdf).
