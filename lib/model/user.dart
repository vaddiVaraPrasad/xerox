class Users {
  String userName;
  String userId;
  String userEmail;
  String userProfileUrl;
  String userLocaation;

  Users(
      {required this.userId,
      required this.userName,
      required this.userEmail,
      required this.userLocaation,
      required this.userProfileUrl});

  Map<String, dynamic> get toMap {
    return {
      "userName": userName,
      "userId": userId,
      "userEmail": userEmail,
      "userProfileUrl": userProfileUrl,
      "userLocaation": userLocaation,
    };
  }
}
