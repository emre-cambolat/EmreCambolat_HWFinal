
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
 │  │  └─ Splash
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
|  ![splash](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/00b28cba-63c5-447b-99a7-8d1282a4e350) | ![search result](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/e723c1ed-1ed6-496f-8915-2b71d4f44b4b) |




- Empty Views

| Search Empty | Add Favorite | Search Not Found |
|---------|---------|---------|
|  ![search empty](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/327ad2b1-b8a1-41bb-a34a-2aa16e309f95) | ![add favorite](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/6d341c79-aefc-44b4-b936-09a0e0e92431) | ![search not found](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/f2d3677a-fe05-4fc6-8d0b-40f2a1c85878) |



- Detail Screen

| Detail Favorite | Detail Unfavorite |
|---------|---------|
|  ![detail favorite](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/ef8de947-2d73-4e95-ad3c-999200b68f15) | ![detail unfavorite alert](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/02be6b9c-9d41-43c2-8453-7c508d723822) |



- Favorites Screen

| Favorites | Remove Favorite Alert |
|---------|---------|
|  ![favorites](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/f1c8a2e4-7d8f-4ff1-8979-9fb3aa02b346) | ![favorites remove alert](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/80cf5fd9-4fdd-4c95-9bc5-18cf31aa47df) |

- Toast Menu

![toast menu](https://github.com/emre-cambolat/EmreCambolat_HWFinal/assets/83469064/60671c37-b611-4f45-89a4-48b0329f620b)



- App Review
  
https://www.youtube.com/watch?v=_q2Afzq61a8

- App UI Test
  
https://www.youtube.com/watch?v=mrBIFfzSrEA

  

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

  
