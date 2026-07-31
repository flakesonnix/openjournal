import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:openjournal/services/security_service.dart';
import 'package:openjournal/ui/security/security_utils.dart';
import 'package:openjournal/ui/security/widgets/pattern_lock_view.dart';

class UnlockScreen extends ConsumerStatefulWidget {
  final VoidCallback onUnlocked;

  const UnlockScreen({super.key, required this.onUnlocked});

  @override
  ConsumerState<UnlockScreen> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends ConsumerState<UnlockScreen> {
  final _pinController = TextEditingController();
  final _auth = LocalAuthentication();
  String? _errorMessage;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    final security = ref.read(securityServiceProvider);
    if (security.isBiometricEnabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _authenticateBiometric());
    }
  }

  Future<void> _authenticateBiometric() async {
    try {
      final didAuthenticate = await _auth.authenticate(
        localizedReason: 'Unlock OpenJournal',
        // Temporarily simplified for debugging build error
        // options: const AuthenticationOptions(stickyAuth: true),
      );
      if (didAuthenticate) {
        widget.onUnlocked();
      }
    } catch (e) {
      debugPrint("Biometric error: $e");
    }
  }

  Future<void> _verifyValue(String value) async {
    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });

    final security = ref.read(securityServiceProvider);
    final isValid = await SecurityUtils.verifyValue(
      value,
      security.lockSalt!,
      security.lockHash!,
    );

    if (isValid) {
      widget.onUnlocked();
    } else {
      setState(() {
        _isVerifying = false;
        _errorMessage = security.lockType == LockType.pin ? "Incorrect PIN" : "Incorrect Pattern";
        _pinController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final security = ref.watch(securityServiceProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'OpenJournal Locked',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Please enter your ${security.lockType.name} to continue',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 48),
              if (security.lockType == LockType.pin)
                TextField(
                  controller: _pinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, letterSpacing: 8),
                  decoration: InputDecoration(
                    hintText: 'PIN',
                    errorText: _errorMessage,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (v) {
                    if (v.length >= 4) {
                      _verifyValue(v);
                    }
                  },
                )
              else if (security.lockType == LockType.pattern)
                Column(
                  children: [
                    PatternLockView(onPatternComplete: _verifyValue),
                    if (_errorMessage != null)
                      Text(_errorMessage!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ],
                ),
              if (_isVerifying)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: CircularProgressIndicator(),
                ),
              if (security.isBiometricEnabled)
                IconButton(
                  onPressed: _authenticateBiometric,
                  iconSize: 48,
                  icon: Icon(Icons.fingerprint, color: Theme.of(context).colorScheme.secondary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
