import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/drink_log.dart';

// --- PROVIDER DRINK (CON SALVATAGGIO) ---
final drinksProvider = StateNotifierProvider<DrinksNotifier, List<DrinkLog>>((ref) {
  return DrinksNotifier();
});

class DrinksNotifier extends StateNotifier<List<DrinkLog>> {
  DrinksNotifier() : super([]) {
    _loadDrinks();
  }

  Future<void> _loadDrinks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? drinksData = prefs.getString('drinks_history');
    if (drinksData != null) {
      final List<dynamic> decoded = jsonDecode(drinksData);
      // Trasforma il JSON in una lista di oggetti DrinkLog
      state = decoded.map((item) => DrinkLog.fromMap(item)).toList();
    }
  }

  void addDrink(DrinkLog drink) {
    state = [...state, drink];
    _saveDrinks();
  }

  void removeDrink(String id) {
    state = state.where((d) => d.id != id).toList();
    _saveDrinks();
  }

  void updateDrink(DrinkLog drink) {
    state = [for (final d in state) if (d.id == drink.id) drink else d];
    _saveDrinks();
  }

  Future<void> _saveDrinks() async {
    final prefs = await SharedPreferences.getInstance();
    // Trasforma la lista di oggetti in una stringa JSON
    final String encoded = jsonEncode(state.map((d) => d.toMap()).toList());
    await prefs.setString('drinks_history', encoded);
  }
}

// --- PROVIDER UTENTE (CON SALVATAGGIO) ---
final userProvider = StateNotifierProvider<UserNotifier, UserProfile>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserProfile> {
  UserNotifier() : super(UserProfile(weight: 70, height: 170, age: 25, gender: 'M', isNewDriver: false, isOnboarded: false)) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('user_profile');
    if (userData != null) {
      final Map<String, dynamic> map = jsonDecode(userData);
      state = UserProfile(
        weight: map['weight'],
        height: map['height'],
        age: map['age'],
        gender: map['gender'],
        isNewDriver: map['isNewDriver'] ?? false,
        isOnboarded: map['isOnboarded'],
      );
    }
  }

  // Override del setter per salvare ogni volta che il profilo cambia
  set state(UserProfile newUser) {
    super.state = newUser;
    _saveUser(newUser);
  }

  Future<void> _saveUser(UserProfile user) async {
    final prefs = await SharedPreferences.getInstance();
    final String userData = jsonEncode({
      'weight': user.weight,
      'height': user.height,
      'age': user.age,
      'gender': user.gender,
      'isNewDriver': user.isNewDriver,
      'isOnboarded': user.isOnboarded,
    });
    await prefs.setString('user_profile', userData);
  }
}