import 'package:flutter/material.dart';
import "../model/user.dart";

class CurrentUser with ChangeNotifier {
  late Users current_user = Users(
      userId: "chumma",
      userName: "chumma chumma",
      userEmail: "chumma",
      userLocaation: "chumma",
      userProfileUrl: "https://kalasalingam.ac.in/wp-content/uploads/2021/11/Faculty-dummy-profile.png");

  void setCurrentUser(Users curUser) {
    current_user = curUser;
    notifyListeners();
  }

  Users get gerUser {
    return current_user;
  }

  void setUserName(String userName) {
    current_user.userName = userName;
    notifyListeners();
  }

  String get getUserName {
    return current_user.userName;
  }

  void setUserEmail(String userEmail) {
    current_user.userEmail = userEmail;
    notifyListeners();
  }

  String get getUserEmail {
    return current_user.userEmail;
  }

  void setUserLocation(String userLocation) {
    current_user.userLocaation = userLocation;
    notifyListeners();
  }

  String get getUserLocation {
    return current_user.userLocaation;
  }

  void setUserProfileUrl(String userProfileUrl) {
    current_user.userProfileUrl = userProfileUrl;
    notifyListeners();
  }

  String get getUserProfileUrl {
    return current_user.userProfileUrl;
  }

  Map<String, dynamic> get getCurrentUserMap {
    return current_user.toMap;
  }
}
