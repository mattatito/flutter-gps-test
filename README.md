# 🗺 gps_test

A flutter project to test localization

## 🤔 What I did?
Following principles of clean arch (but not enought), I tried to create clients and service to encapsulate the used library. When users not authorize, then it shows error message according the user action, like permission denied or denied forever.

I used [geolocator](https://pub.dev/packages/geolocator) package to get lat and long.

## ❌User denied permission

- Flutter web

![image](https://user-images.githubusercontent.com/50848469/142679215-ad14e7f5-81d0-4eb9-bf18-53d3c10bcab5.png)

- Android

_Haven't tested yet_

## 📖 Getting Started
If you want to run this test, just follow the instructions bellow.
**Stages to run:**

- Clone this repository
- run `flutter pub get` in command line
- run in device or web
