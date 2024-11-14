
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends StateNotifier<bool> {
  final Ref ref;

  ThemeProvider(this.ref) : super(false);

  void toggleTheme() async {
    final SharedPreferencesAsync preferences = SharedPreferencesAsync();
    state = !state;
    await preferences.setBool('theme', state);
  }

  Future addTheme() async {
    final SharedPreferencesAsync preferences = SharedPreferencesAsync();
    final savedTheme = await preferences.getBool('theme');
    state = savedTheme ?? false;
  }
}

final themeProvider =
    StateNotifierProvider<ThemeProvider, bool>((ref) => ThemeProvider(ref));
