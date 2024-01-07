# Mobile Coding Challenge: Cuong-Notes

This SwiftUI note application provides a simple interface for users to create and manage notes. Leveraging the power of SwiftUI for a modern and responsive UI, the app connects to Firebase Realtime Database to enable real-time synchronization of notes across devices.

## Architecture
This application is applied the **Clean Architecture**: https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html 
### Layers
* **Domain Layer** = Entities + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + FirebaseDatabase (or API Network/Persistence DB) 
* **Presentation Layer (MVVM)** = ViewModels + Views (written in SwiftUI)

### Dependency Direction
![Alt text](CleanArchitectureDependencies.png?raw=true "Modules Dependencies")

**Note:** **Domain Layer** should not include anything from other layers(e.g Presentation — SwiftUI or Data Layer)

## Networking
The application utilizes Firebase Realtime Database to synchronize notes in real-time, ensuring that any updates or additions are reflected instantly across all devices. It does not require users to login. 
* **FirebaseDatabaseManager:** A Singleton is reponsible for Firebase configurations. It wraps **DatabaseReference** up and provides **CRUD Operations**
* **FirebaseDatabaseEndpoint** The endpoint provides information such as the path and the synced data flag for operations.

## Timeline ⌛️
I actually spent most of my time studying SwiftUI, because I had never used it in my projects before. It is therefore difficult to give an exact timeline for each aspect of the application, but I can give a timeline as below **(10 points in 5 working days)**:
* **(5 points)** Learning: About SwiftUI, Combine, Firebase (face new problems in those and find ways to resolve it).
* **(0.5 point)** Setup project
* **(4 points)** Doing tasks and write UnitTest: Excluding "As a user I can see all the notes from other users".
* **(0.5 point)**  Write Readme file

## Limitations

* User Identification: Because this application does not require users to login, so I used **UIDevice.current.identifierForVendor.uuidString** to identify users. The problem is that this value can be changed, according to the Apple documentation "The value changes when the user deletes all of that vendor’s apps from the device and subsequently reinstalls one or more of them. The value can also change when installing test builds using Xcode or when installing an app on a device using ad-hoc distribution"
* Firebase Database Security: As mentioned above, it doesn't require users login, so it's hard to set the right security rules for Firebase Database at this time. I don't take the time to dig into how to set a good rule right now.
* My DIContainer is an **@EnvironmentObject**, I can not find the way using my DIContainer in "View init()" to pass data into ViewModel. Therefore I have to use a sub ContentView for all main views.

## Install Dev Tools 🛠
-   Install [Homebrew](https://brew.sh)
Open Terminal, run the following command
```sh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
-   Install [Bundler](https://bundler.io)
```sh
$ gem install bundler
```
-   Install required gems

```sh
$ bundle install
```
-   Install Cocoapods
```sh
$ sudo gem install cocoapods
```
-   Clone the main iOS repo then install dependencies
```sh
$ cd Cuong-Notes
```
```sh
$ pod install --repo-update
```


## Enviroment
* Xcode Version 14.3.1  Swift 5.8.1

