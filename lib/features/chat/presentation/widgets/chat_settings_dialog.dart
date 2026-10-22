import 'package:flutter/material.dart';

typedef ChatSettingsInput = ({String username, String serverUrl});

Future<ChatSettingsInput?> showChatSettingsDialog(
  BuildContext context, {
  required String username,
  required String serverUrl,
}) {
  return showDialog<ChatSettingsInput>(
    context: context,
    builder: (_) => _ChatSettingsDialog(username: username, serverUrl: serverUrl),
  );
}

class _ChatSettingsDialog extends StatefulWidget {
  const _ChatSettingsDialog({required this.username, required this.serverUrl});

  final String username;
  final String serverUrl;

  @override
  State<_ChatSettingsDialog> createState() => _ChatSettingsDialogState();
}

class _ChatSettingsDialogState extends State<_ChatSettingsDialog> {
  late final TextEditingController _username =
      TextEditingController(text: widget.username);
  late final TextEditingController _serverUrl =
      TextEditingController(text: widget.serverUrl);

  @override
  void dispose() {
    _username.dispose();
    _serverUrl.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.of(context).pop((
      username: _username.text,
      serverUrl: _serverUrl.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chat settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _username,
            maxLength: 32,
            decoration: const InputDecoration(
              labelText: 'Display name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _serverUrl,
            keyboardType: TextInputType.url,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Server URL',
              helperText: 'Emulator: ws://10.0.2.2:8080\nPhone: ws://<your-PC-IP>:8080',
              helperMaxLines: 2,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}
