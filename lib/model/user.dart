class Users {
  String userName;
  String userId;
  String userEmail;
  String userProfileUrl;
  String userPlaceName;
  double latitude;
  double longitude;
  String userPostalCode;
  String userContryName;

  Users({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPlaceName,
    required this.latitude,
    required this.longitude,
    required this.userProfileUrl,
    required this.userContryName,
    required this.userPostalCode,
  });

  Map<String, dynamic> get toMap {
    return {
      "userId": userId,
      "userName": userName,
      "userEmail": userEmail,
      "userPlaceName": userPlaceName,
      "latitude": latitude,
      "longitude": longitude,
      "userProfileUrl": userProfileUrl,
      "userPostalCode":userPostalCode,
      "userContryName":userContryName,
    };
  }
}
