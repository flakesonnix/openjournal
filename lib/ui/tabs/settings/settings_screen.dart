import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openjournal/services/security_service.dart';
import 'package:openjournal/ui/security/security_utils.dart';
import 'package:openjournal/ui/security/widgets/pattern_lock_view.dart';
import 'package:openjournal/ui/tabs/openjournal/components/card_with_title.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final security = ref.watch(securityServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CardWithTitle(
            title: "Security",
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('App Lock'),
                  subtitle: Text(security.isAppLockEnabled
                      ? 'Enabled (${security.lockType.name})'
                      : 'Disabled'),
                  value: security.isAppLockEnabled,
                  onChanged: (value) {
                    if (!value) {
                      ref.read(securityServiceProvider).setLock(type: LockType.none);
                    } else {
                      _showSetupDialog(context, ref, LockType.pin);
                    }
                  },
                ),
                if (security.isAppLockEnabled) ...[
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.pin),
                    title: const Text('Change PIN'),
                    onTap: () => _showSetupDialog(context, ref, LockType.pin),
                  ),
                  ListTile(
                    leading: const Icon(Icons.pattern),
                    title: const Text('Change Pattern'),
                    onTap: () => _showSetupDialog(context, ref, LockType.pattern),
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Use Biometrics'),
                    secondary: const Icon(Icons.fingerprint),
                    value: security.isBiometricEnabled,
                    onChanged: (value) {
                      ref.read(securityServiceProvider).setBiometricEnabled(value);
                    },
                  ),
                ],
              ],
            ),
          ),
          // Other sections...
        ],
      ),
    );
  }

  void _showSetupDialog(BuildContext context, WidgetRef ref, LockType type) {
    showDialog(
      context: context,
      builder: (context) => _LockSetupDialog(type: type),
    );
  }
}

class _LockSetupDialog extends ConsumerStatefulWidget {
  final LockType type;
  const _LockSetupDialog({required this.type});

  @override
  ConsumerState<_LockSetupDialog> createState() => _LockSetupDialogState();
}

class _LockSetupDialogState extends ConsumerState<_LockSetupDialog> {
  int _step = 1; // 1: Enter, 2: Confirm
  String _firstEntry = "";
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_step == 1 ? "Set ${widget.type.name.toUpperCase()}" : "Confirm ${widget.type.name.toUpperCase()}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.type == LockType.pin)
            TextField(
              controller: _pinController,
              autofocus: true,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Enter 4-8 digits'),
            )
          else
            PatternLockView(
              onPatternComplete: (pattern) {
                _handleEntry(pattern);
              },
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        if (widget.type == LockType.pin)
          TextButton(
            onPressed: () => _handleEntry(_pinController.text),
            child: const Text('Next'),
          ),
      ],
    );
  }

  void _handleEntry(String value) async {
    if (_step == 1) {
      setState(() {
        _firstEntry = value;
        _step = 2;
        _pinController.clear();
      });
    } else {
      if (value == _firstEntry) {
        final salt = SecurityUtils.generateSalt();
        final hash = await SecurityUtils.hashValue(value, salt);
        await ref.read(securityServiceProvider).setLock(
              type: widget.type,
              hash: hash,
              salt: salt,
            );
        if (mounted) Navigator.pop(context);
      } else {
        setState(() {
          _step = 1;
          _firstEntry = "";
          _pinController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Entries do not match. Start over.')),
        );
      }
    }
  }
}
