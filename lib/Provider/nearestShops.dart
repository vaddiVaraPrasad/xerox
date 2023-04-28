import "package:flutter/material.dart";

import "../model/nearest_shops_model.dart";

class NearestShopProvider extends ChangeNotifier {
  List<nearestShop> allNearestShop = [];

  void setAllNearestShop(allshops) {
    allNearestShop = allshops;
    notifyListeners();
  }

  List<nearestShop> getAllNearestShops() {
    return allNearestShop;
  }

  void addShopToList(nearShop) {
    allNearestShop.add(nearShop);
    notifyListeners();
  }

  nearestShop getShopById(String Id) {
    return allNearestShop.firstWhere((element) => element.shopID == Id);
  }

  int getShopListSize() {
    return allNearestShop.length;
  }

  double getShopAtIndexLat(int index) {
    return allNearestShop[index].shopLatitude;
  }

  double getShopAtIndexLng(int index) {
    return allNearestShop[index].shopLongitude;
  }

  nearestShop getShopByIndex(int index) {
    return allNearestShop[index];
  }
}
