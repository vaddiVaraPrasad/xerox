import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xerox/helpers/sqlLite.dart';
import "../model/user.dart";

class CurrentUser with ChangeNotifier {
  late Users current_user = Users(
    userId: "Loading...",
    userName: "Loading...",
    userEmail: "Loading...",
    userPlaceName: "Loading...",
    latitude: 0,
    longitude: 0,
    userProfileUrl:
        "https://kalasalingam.ac.in/wp-content/uploads/2021/11/Faculty-dummy-profile.png",
    userContryName: "India",
  );

  void initCurrentUser(String id) async {
    Map<String, dynamic> user_map = await SQLHelpers.getUserById(id);
    Users tempuser = Users(
      userId: user_map["userId"],
      userName: user_map["userName"],
      userEmail: user_map["userEmail"],
      userPlaceName: user_map["userPlaceName"],
      latitude: user_map["latitude"],
      longitude: user_map["longitude"],
      userProfileUrl: user_map["userProfileUrl"],
      userContryName: user_map["userContryName"],
    );
    current_user = tempuser;
    print("init current user is called");
    print("user is updated");
    print(getCurrentUserMap);
    notifyListeners();
  }

  String get getUserId {
    return current_user.userId;
  }

  void setCurrentUser(Users curUser) {
    current_user = curUser;
    SQLHelpers.insertUser(current_user);
    notifyListeners();
  }

  void loadLatestUser() async {
    Map<String, dynamic> latestUser = await SQLHelpers.getLatestUser("users");
    if (latestUser != {}) {
      Users latCurUser = Users(
          userId: latestUser["userId"],
          userName: latestUser["userName"],
          userEmail: latestUser["userEmail"],
          userPlaceName: latestUser["userPlaceName"],
          latitude: latestUser["latitude"],
          longitude: latestUser["longitude"],
          userProfileUrl: latestUser["userProfileUrl"],
          userContryName: latestUser["userContryName"]);
      current_user = latCurUser;
      print("old user is loaded");
      notifyListeners();
    }
  }

  void loadUserByID(String id) async {
    Map<String, dynamic> idUserMap = await SQLHelpers.getUserById(id);
    Users id_user = Users(
        userId: idUserMap["userId"],
        userName: idUserMap["userName"],
        userEmail: idUserMap["userEmail"],
        userPlaceName: idUserMap["userPlaceName"],
        latitude: idUserMap["latitude"],
        longitude: idUserMap["longitude"],
        userProfileUrl: idUserMap["userProfileUrl"],
        userContryName: idUserMap["userContryName"]);
    current_user = id_user;
    print("old user is loaded");
    notifyListeners();
  }

  Users get gerUser {
    return current_user;
  }

  void setUserName(String userName) {
    current_user.userName = userName;
    SQLHelpers.insertUser(current_user);
    notifyListeners();
  }

  String get getUserName {
    return current_user.userName;
  }

  void setUserEmail(String userEmail) {
    current_user.userEmail = userEmail;
    SQLHelpers.insertUser(current_user);
    notifyListeners();
  }

  String get getUserEmail {
    return current_user.userEmail;
  }

  void setUserPlaceName(String userPlaceName) {
    current_user.userPlaceName = userPlaceName;
    SQLHelpers.insertUser(current_user);
    notifyListeners();
  }

  String get getPlaceName {
    return current_user.userPlaceName;
  }

  void setUserLatitudeLogitude(double latitude, double logitude) {
    current_user.latitude = latitude;
    current_user.longitude = logitude;
    notifyListeners();
  }

  double get getUsetLatitude {
    return current_user.latitude;
  }

  double get getUserLongitude {
    return current_user.longitude;
  }

  void setUserProfileUrl(String userProfileUrl) {
    current_user.userProfileUrl = userProfileUrl;
    SQLHelpers.insertUser(current_user);
    notifyListeners();
  }

  String get getUserProfileUrl {
    return current_user.userProfileUrl;
  }

  void setUserContryName(String countryName) {
    current_user.userContryName = countryName;
    SQLHelpers.insertUser(current_user);
    notifyListeners();
  }

  String get getUserContryName {
    return current_user.userContryName;
  }



  Map<String, dynamic> get getCurrentUserMap {
    return current_user.toMap;
  }
}
