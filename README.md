# Mobile Coding Challenge: Cuong-Notes

This SwiftUI note application provides a simple interface for users to create and manage notes. Leveraging the power of SwiftUI for a modern and responsive UI, the app connects to Firebase Realtime Database to enable real-time synchronization of notes across devices.

## Architecture
This application is applied the **Clean Architecture**: https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html 
### Layers
* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
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
I actually spent most of my time studying SwiftUI, because I had never used it in my projects before. It is therefore difficult to give an exact timeline for each aspect of the application, but I can give a timeline as below **(10points in 5 working days)**:
* **(5 points)Learning:** About SwiftUI, Combine, Firebase (face new problems in those and find ways to resolve it).
* **(0.5 point)Setup project**
* **(4 points)Doing tasks and write UnitTest:** Excluding "As a user I can see all the notes from other users".
* **(0.5 point)Write Readme file** 
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

