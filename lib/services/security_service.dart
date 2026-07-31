import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LockType { none, pin, pattern }

class SecurityService {
  static const _keyIsLocked = "security_is_locked";
  static const _keyLockType = "security_lock_type";
  static const _keyLockHash = "security_lock_hash";
  static const _keyLockSalt = "security_lock_salt";
  static const _keyBiometricsEnabled = "security_biometrics_enabled";

  final SharedPreferences _prefs;

  SecurityService(this._prefs);

  bool get isAppLockEnabled => _prefs.getBool(_keyIsLocked) ?? false;

  LockType get lockType {
    final name = _prefs.getString(_keyLockType);
    return LockType.values.firstWhere((e) => e.name == name, orElse: () => LockType.none);
  }

  String? get lockHash => _prefs.getString(_keyLockHash);
  String? get lockSalt => _prefs.getString(_keyLockSalt);
  bool get isBiometricEnabled => _prefs.getBool(_keyBiometricsEnabled) ?? false;

  Future<void> setLock({required LockType type, String? hash, String? salt}) async {
    await _prefs.setBool(_keyIsLocked, type != LockType.none);
    await _prefs.setString(_keyLockType, type.name);
    if (hash != null) await _prefs.setString(_keyLockHash, hash);
    if (salt != null) await _prefs.setString(_keyLockSalt, salt);
    if (type == LockType.none) {
      await _prefs.remove(_keyLockHash);
      await _prefs.remove(_keyLockSalt);
      await _prefs.setBool(_keyBiometricsEnabled, false);
    }
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await _prefs.setBool(_keyBiometricsEnabled, enabled);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // Must be overridden in main
});

final securityServiceProvider = Provider<SecurityService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SecurityService(prefs);
});
