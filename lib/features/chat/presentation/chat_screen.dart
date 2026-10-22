import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/presentation/theme_mode_button.dart';
import '../application/chat_providers.dart';
import '../domain/chat_state.dart';
import 'widgets/chat_settings_dialog.dart';
import 'widgets/message_bubble.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    if (ref.read(chatProvider.notifier).send(_controller.text)) {
      _controller.clear();
    }
  }

  Future<void> _openSettings() async {
    final settings = ref.read(chatProvider).settings;
    final result = await showChatSettingsDialog(
      context,
      username: settings.username,
      serverUrl: settings.serverUrl,
    );
    if (result != null) {
      await ref.read(chatProvider.notifier).updateSettings(
            username: result.username,
            serverUrl: result.serverUrl,
          );
    }
  }

  Future<void> _confirmClear() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear chat history?'),
        content: const Text('This only removes messages stored on this device.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (ok == true) await ref.read(chatProvider.notifier).clearHistory();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider.select((s) => s.messages));
    final status = ref.watch(chatProvider.select((s) => s.status));
    final online = ref.watch(chatProvider.select((s) => s.online));
    final userId = ref.watch(chatProvider.select((s) => s.settings.userId));
    final serverUrl = ref.watch(chatProvider.select((s) => s.settings.serverUrl));
    final connected = status == ChatStatus.connected;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Live Chat'),
            _StatusLine(status: status, online: online),
          ],
        ),
        actions: [
          const ThemeModeButton(),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') _openSettings();
              if (value == 'clear') _confirmClear();
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'settings', child: Text('Settings')),
              PopupMenuItem(value: 'clear', child: Text('Clear history')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (status == ChatStatus.connecting)
            const LinearProgressIndicator(minHeight: 2),
          if (status == ChatStatus.disconnected)
            _OfflineBanner(
              serverUrl: serverUrl,
              onRetry: () => ref.read(chatProvider.notifier).reconnect(),
            ),
          Expanded(
            child: messages.isEmpty
                ? const _EmptyChat()
                : ListView.builder(
                    reverse: true, // newest message at the bottom, stays pinned
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: messages.length,
                    itemBuilder: (context, i) {
                      final message = messages[messages.length - 1 - i];
                      return MessageBubble(
                        key: ValueKey(message.id),
                        message: message,
                        isMine: message.senderId == userId,
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      enabled: connected,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: connected ? 'Message' : 'Waiting for connection…',
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    tooltip: 'Send',
                    onPressed: connected ? _send : null,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({required this.status, required this.online});

  final ChatStatus status;
  final int online;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      ChatStatus.connected => (Colors.green, 'Connected · $online online'),
      ChatStatus.connecting => (Colors.orange, 'Connecting…'),
      ChatStatus.disconnected => (Colors.red, 'Offline'),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.serverUrl, required this.onRetry});

  final String serverUrl;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Can\'t reach $serverUrl. Retrying automatically…',
                style: TextStyle(color: scheme.onErrorContainer),
              ),
            ),
            TextButton(onPressed: onRetry, child: const Text('Retry now')),
          ],
        ),
      ),
    );
  }
}

class _EmptyChat extends StatelessWidget {
  const _EmptyChat();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.outline;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.forum_outlined, size: 64, color: color),
          const SizedBox(height: 12),
          Text('No messages yet — say hi!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: color)),
        ],
      ),
    );
  }
}
