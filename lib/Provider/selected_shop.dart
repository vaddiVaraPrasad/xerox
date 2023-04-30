import 'package:flutter/material.dart';
import "../model/nearest_shops_model.dart";

class SelectedShop extends ChangeNotifier {
  late nearestShop selectedShop;

  void setSeletedShop(nearestShop shop) {
    selectedShop = shop;
    notifyListeners();
  }

  nearestShop getSeletedShop() {
    return selectedShop;
  }
}
