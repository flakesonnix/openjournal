import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/security_service.dart';
import 'package:openjournal/ui/security/unlock_screen.dart';

class AppLockGuard extends ConsumerStatefulWidget {
  final Widget child;

  const AppLockGuard({super.key, required this.child});

  @override
  ConsumerState<AppLockGuard> createState() => _AppLockGuardState();
}

class _AppLockGuardState extends ConsumerState<AppLockGuard> with WidgetsBindingObserver {
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final security = ref.read(securityServiceProvider);
    _isLocked = security.isAppLockEnabled;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      final security = ref.read(securityServiceProvider);
      if (security.isAppLockEnabled) {
        setState(() {
          _isLocked = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLocked) {
      return UnlockScreen(
        onUnlocked: () {
          setState(() {
            _isLocked = false;
          });
        },
      );
    }
    return widget.child;
  }
}
