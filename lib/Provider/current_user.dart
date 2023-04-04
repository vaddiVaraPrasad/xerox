import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xerox/helpers/sqlLite.dart';
import "../model/user.dart";

class CurrentUser with ChangeNotifier {
  late Users current_user = Users(
      userId: "chumma",
      userName: "chumma chumma",
      userEmail: "chumma",
      userPlaceName: "chumma",
      latitude: 4353.54,
      longitude: 34545.34,
      userProfileUrl:
          "https://kalasalingam.ac.in/wp-content/uploads/2021/11/Faculty-dummy-profile.png");

  void initCurrentUser(String id) async {
    Map<String, dynamic> user_map = await SQLHelpers.getUserById(id);
    Users tempuser = Users(
        userId: user_map["userId"],
        userName: user_map["userName"],
        userEmail: user_map["userEmail"],
        userPlaceName: user_map["userPlaceName"],
        latitude: user_map["latitude"],
        longitude: user_map["longitude"],
        userProfileUrl: user_map["userProfileUrl"]);
    current_user = tempuser;
    print("init current user is called");
    print("user is updated");
    print(getCurrentUserMap);
    notifyListeners();
  }

  void setCurrentUser(Users curUser) {
    current_user = curUser;
    SQLHelpers.insertUser(current_user);
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

  Map<String, dynamic> get getCurrentUserMap {
    return current_user.toMap;
  }
}
