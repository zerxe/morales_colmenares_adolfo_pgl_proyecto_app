import 'package:flutter/material.dart';
import '../model/character.dart';

class TabIndexProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  Character? _currentCharacter;

  int get selectedIndex => _selectedIndex;
  Character? get currentCharacter => _currentCharacter;

  set currentCharacter(Character? character) {
    _currentCharacter = character;
    notifyListeners();
  }

  void setTabIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
