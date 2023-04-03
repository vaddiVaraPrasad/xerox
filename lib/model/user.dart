class User {
  final String userName;
  final String userId;
  final String profileUrl;
  final String userEmail;

  User(
      {required this.userId,
      required this.userEmail,
      required this.userName,
      required this.profileUrl});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "userEmail": userEmail,
      "userName": userName,
      "userProfileUrl": profileUrl,
    };
  }
}
