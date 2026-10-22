import 'package:flutter/material.dart';

/// Shows a dialog to add (initialTitle == null) or edit a todo.
/// Returns the entered title, or null if cancelled.
Future<String?> showTodoDialog(BuildContext context, {String? initialTitle}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _TodoDialog(initialTitle: initialTitle),
  );
}

class _TodoDialog extends StatefulWidget {
  const _TodoDialog({this.initialTitle});

  final String? initialTitle;

  @override
  State<_TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<_TodoDialog> {
  late final TextEditingController _controller;

  bool get _isEditing => widget.initialTitle != null;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    Navigator.of(context).pop(text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Edit task' : 'New task'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          hintText: 'What needs to be done?',
          border: OutlineInputBorder(),
        ),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(_isEditing ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}
