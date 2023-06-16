
# iTunes Search App

Turkcell Geleceği Yazanlar Swift Bootcamp Puanlı Final Ödevi
## Features

- The project follows the VIPER (View-Interactor-Presenter-Entity-Router) design model, which makes the components of the application independent and increases testability.
- Unit Test and UI Test were written with the help of protocols by increasing testability with VIPER architecture.
- Every area that can overflow in the application is designed using AutoLayout to take dynamic size. It can run smoothly on devices with different screen sizes.
- The internet connection of the device is controlled with the NetworkManager package on the Splash screen. User redirections are made according to the situation.
- A loading indicator is displayed during data loading. This visually shows the user that the data is loading and improves the waiting experience.
- A customized ToastMenu plugin was written for error and warning messages for user experience.
- Created a CoreData class called FavoriteManager for adding and managing songs to favorites.
- A Custom View called PlayerView was created to be used on the MusicCell and detail page on the search page. This structure was supported with AudioManager.
- The AudioManager package has been updated and made more comprehensive. It can be used in MusicCell and detail page in PlayerView structure.
- Favorites page has been added to manage songs added to favorites. Favorite songs can be edited on this page.




  
## Used Packages

**Network Layer:** Alamofire v5.7.1 Library for retrieving data from the API service.

**Cache Layer:** SDWebImage v5.16.0 Library for saving album art for songs

**NetworkManager:** Local packet that instantly listens or optionally controls the device's internet connection

**AudioManager:** Native package that downloads and plays the audio file from the given URL



  
## Folder Structure

```
📦 MusicApp
├─ MusicApp
│  ├─ App
│  ├─ CustomView
│  │  ├─ EmptyView
│  │  ├─ LoadingView
│  │  └─ PlayerView
│  ├─ Module
│  │  ├─ Detail
│  │  ├─ Favorite
│  │  │  └─ View
│  │  │     └─ FavoriteCell
│  │  ├─ Search
│  │  │  ├─ View
│  │  │  │  └─ MusicCell
│  │  │  └─ Entity
│  │  └─ Spl
│  └─ Service
├─ MusicAppTests
│  └─ Mock
│     └─ MusicCellTest
└─ MusicAppUITests

```


  
## Application Preview

- Splash and Search Screen


| Splash Screen | Search Screen |
|---------|---------|
| ![splash](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/70d5bb3e-a8fd-41c6-9db8-4a931c6cf570) | ![search result](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/93fed8ef-efb0-4c09-9e82-729a0fab8666) |



- Empty Views

| Search Empty | Add Favorite | Search Not Found |
|---------|---------|---------|
| ![search empty](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/af3b6a21-353c-45ef-a971-4b70a4bd5ff4) | ![add favorite](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/94420f61-4869-4a32-b9b8-403c2b96f289) | ![search not found](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/746efc5f-a78a-4ba7-b4b4-2f506e43b798) |



- Search Screen


- Detail Screen

| Detail Favorite | Detail Unfavorite |
|---------|---------|
| ![detail favorite](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/e840925d-85eb-49ba-92ff-72bed74ed182) | ![detail unfavorite alert](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/35661985-ba22-4af0-9468-924aa431f600) |



- Favorites Screen

| Favorites | Remove Favorite Alert |
|---------|---------|
| ![favorites](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/0107738f-d387-4b0a-bdf4-f7eab1aa8992) | ![favorites remove alert](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/c5e0e992-7283-42ef-94ae-dd810c349436) |

- Toast Menu

![toast menu](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/27872dce-d62b-4c73-ab37-9ba6551018cc)


- App Review
  
https://www.youtube.com/watch?v=_q2Afzq61a8

- App UI Test
  
https://www.youtube.com/watch?v=_q2Afzq61a8

  

## Installation

- Clone the project or download it as a ZIP file.
- Open the Terminal and navigate to the root folder of the project.
- Run the following command to install the required dependencies:
```bash
  swift package resolve
```
- Open the App.xcodeproj file in Xcode
- You can run the application on a simulator or a device.

  
## Feedback

If you have any questions, suggestions, or feedback, please contact us at emre-cambolat@gmail.com.

  
