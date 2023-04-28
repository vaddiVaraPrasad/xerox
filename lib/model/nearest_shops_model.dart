class nearestShop {
  String email;
  String ownerProfilePicUrl;
  String shopCityName;
  String shopAddress;
  double shopLatitude;
  double shopLongitude;
  String shopName;
  String shopOwnerName;
  String shopPicUrl;
  String shopID;
  String distanceFromCurrentLocation;
  String durationFromCurrentLocation;

  final double costForA0PerSingleSide;
  final double costForA0PErDobuleSide;
  final double costForA1PerSingleSide;
  final double costForA1PErDobuleSide;
  final double costForA2PerSingleSide;
  final double costForA2PErDobuleSide;
  final double costForA3PerSingleSide;
  final double costForA3PErDobuleSide;
  final double costForA4PerSingleSide;
  final double costForA4PErDobuleSide;
  final double costForA5PerSingleSide;
  final double costForA5PErDobuleSide;
  final double costForLegalPerSingleSide;
  final double costForLegalPErDobuleSide;
  final double costForLetterPerSingleSide;
  final double costForLetterPErDobuleSide;
  final double costOfColorPerPageForA0;
  final double costOfColorPerPageForA1;
  final double costOfColorPerPageForA2;
  final double costOfColorPerPageForA3;
  final double costOfColorPerPageForA4;
  final double costOfColorPerPageForA5;
  final double costOfColorPerPageForLegal;
  final double costOfColorPerPageForLetter;
  final double costForSpiralBound;
  final double costForStickFile;
  final double costForHardBound;
  final double costForOneBondPaper;
  final double costForTransparentSheetPerSheet;

  nearestShop({
    required this.email,
    required this.ownerProfilePicUrl,
    required this.shopAddress,
    required this.shopLatitude,
    required this.shopLongitude,
    required this.shopName,
    required this.shopOwnerName,
    required this.shopPicUrl,
    required this.shopID,
    required this.shopCityName,
    required this.durationFromCurrentLocation,
    required this.distanceFromCurrentLocation,
    required this.costForA0PerSingleSide,
    required this.costForA0PErDobuleSide,
    required this.costForA1PErDobuleSide,
    required this.costForA1PerSingleSide,
    required this.costForA2PErDobuleSide,
    required this.costForA2PerSingleSide,
    required this.costForA3PErDobuleSide,
    required this.costForA3PerSingleSide,
    required this.costForA4PErDobuleSide,
    required this.costForA4PerSingleSide,
    required this.costForA5PErDobuleSide,
    required this.costForA5PerSingleSide,
    required this.costForLegalPErDobuleSide,
    required this.costForLegalPerSingleSide,
    required this.costForLetterPErDobuleSide,
    required this.costForLetterPerSingleSide,
    required this.costOfColorPerPageForA0,
    required this.costOfColorPerPageForA1,
    required this.costOfColorPerPageForA2,
    required this.costOfColorPerPageForA3,
    required this.costOfColorPerPageForA4,
    required this.costOfColorPerPageForA5,
    required this.costOfColorPerPageForLegal,
    required this.costOfColorPerPageForLetter,
    required this.costForHardBound,
    required this.costForSpiralBound,
    required this.costForStickFile,
    required this.costForOneBondPaper,
    required this.costForTransparentSheetPerSheet,
  });
}
