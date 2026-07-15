import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  ProgressService._();

  static final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  static const String _intisKey = 'user_intis';
  static const String _wisdomKey = 'user_wisdom';
  static const String _xpKey = 'user_xp';
  static const String _energyKey = 'user_energy';

  static const String _icaProgressKey = 'ica_progress';
  static const String _gastronomyLessonsKey = 'gastronomy_lessons_completed';

  static const String _tejaIquenaCompletedKey = 'teja_iquena_completed';

  static const String _tejaIquenaCollectibleKey =
      'teja_iquena_collectible_unlocked';

  // Valores iniciales mostrados actualmente en la aplicación.
  static const int initialIntis = 1250;
  static const int initialWisdom = 320;
  static const int initialEnergy = 18;
  static const int initialXp = 0;
  static const int initialIcaProgress = 40;

  static Future<int> getIntis() async {
    return await _preferences.getInt(_intisKey) ?? initialIntis;
  }

  static Future<int> getWisdom() async {
    return await _preferences.getInt(_wisdomKey) ?? initialWisdom;
  }

  static Future<int> getXp() async {
    return await _preferences.getInt(_xpKey) ?? initialXp;
  }

  static Future<int> getEnergy() async {
    return await _preferences.getInt(_energyKey) ?? initialEnergy;
  }

  static Future<int> getIcaProgress() async {
    return await _preferences.getInt(_icaProgressKey) ?? initialIcaProgress;
  }

  static Future<int> getGastronomyLessonsCompleted() async {
    return await _preferences.getInt(_gastronomyLessonsKey) ?? 1;
  }

  static Future<bool> isTejaIquenaCompleted() async {
    return await _preferences.getBool(_tejaIquenaCompletedKey) ?? false;
  }

  static Future<bool> isTejaCollectibleUnlocked() async {
    return await _preferences.getBool(_tejaIquenaCollectibleKey) ?? false;
  }

  static Future<void> completeTejaIquena() async {
    final bool alreadyCompleted = await isTejaIquenaCompleted();

    // Evita entregar la misma recompensa repetidamente.
    if (alreadyCompleted) {
      return;
    }

    final int currentIntis = await getIntis();
    final int currentWisdom = await getWisdom();
    final int currentXp = await getXp();
    final int currentEnergy = await getEnergy();

    await Future.wait<void>([
      _preferences.setInt(_intisKey, currentIntis + 150),
      _preferences.setInt(_wisdomKey, currentWisdom + 20),
      _preferences.setInt(_xpKey, currentXp + 100),
      _preferences.setInt(_energyKey, currentEnergy + 1),
      _preferences.setInt(_icaProgressKey, 60),
      _preferences.setInt(_gastronomyLessonsKey, 2),
      _preferences.setBool(_tejaIquenaCompletedKey, true),
      _preferences.setBool(_tejaIquenaCollectibleKey, true),
    ]);
  }

  // Útil para repetir las pruebas antes de la presentación.
  static Future<void> resetDemoProgress() async {
    await Future.wait<void>([
      _preferences.remove(_intisKey),
      _preferences.remove(_wisdomKey),
      _preferences.remove(_xpKey),
      _preferences.remove(_energyKey),
      _preferences.remove(_icaProgressKey),
      _preferences.remove(_gastronomyLessonsKey),
      _preferences.remove(_tejaIquenaCompletedKey),
      _preferences.remove(_tejaIquenaCollectibleKey),
    ]);
  }
}
