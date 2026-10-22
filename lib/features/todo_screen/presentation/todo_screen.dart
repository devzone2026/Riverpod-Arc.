import 'package:accesibility_together/core/utils_widgets/app_text.dart';
import 'package:accesibility_together/core/utils_widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../settings/presentation/theme_mode_button.dart';
import '../application/todo_providers.dart';
import '../domain/todo.dart';
import '../domain/todo_filter.dart';
import '../domain/todo_stats.dart';
import 'widgets/todo_dialog.dart';
import 'widgets/todo_tile.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  Future<void> _addTodo(BuildContext context, WidgetRef ref) async {
    final title = await showTodoDialog(context);
    if (title != null) await ref.read(todoListProvider.notifier).add(title);
  }

  Future<void> _editTodo(BuildContext context, WidgetRef ref, Todo todo) async {
    final title = await showTodoDialog(context, initialTitle: todo.title);
    if (title != null) {
      await ref.read(todoListProvider.notifier).edit(todo, title);
    }
  }

  void _deleteTodo(BuildContext context, WidgetRef ref, Todo todo) {
    final notifier = ref.read(todoListProvider.notifier);
    notifier.remove(todo.id);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Deleted "${todo.title}"'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => notifier.restore(todo),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoListProvider);
    final visibleTodos = ref.watch(filteredTodosProvider);
    final stats = ref.watch(todoStatsProvider);
    final syncing = ref.watch(todoSyncProvider.select((s) => s.isLoading));

    ref.listen(todoSyncProvider, (previous, next) {
      if (next.isLoading) return;
      final messenger = ScaffoldMessenger.of(context);
      next.when(
        data: (count) {
          if (count == null) return;
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(count == 0
                  ? 'Already up to date'
                  : 'Imported $count task${count == 1 ? '' : 's'}'),
            ));
        },
        error: (error, _) {
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(error is ApiException ? error.message : 'Import failed'),
            ));
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
        actions: [
          const ThemeModeButton(),
          IconButton(
            tooltip: 'Import from API',
            onPressed: syncing
                ? null
                : () => ref.read(todoSyncProvider.notifier).importFromApi(),
            icon: syncing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.cloud_download_outlined),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              final notifier = ref.read(todoListProvider.notifier);
              switch (value) {
                case 'complete_all':
                  notifier.setAllCompleted(true);
                case 'clear_completed':
                  notifier.clearCompleted();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'complete_all',
                enabled: stats.active > 0,
                child: const Text('Mark all complete'),
              ),
              PopupMenuItem(
                value: 'clear_completed',
                enabled: stats.completed > 0,
                child: const Text('Clear completed'),
              ),
            ],
          ),
        ],
      ),
      body: todosAsync.when(
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorView(
          message: 'Could not load your todos.',
          onRetry: () => ref.invalidate(todoListProvider),
        ),
        data: (_) => Column(
          children: [
            _Header(stats: stats),
            const _SearchField(),
            const _FilterBar(),
            const Divider(height: 1),
            Expanded(
              child: visibleTodos.isEmpty
                  ? _EmptyState(hasAnyTodos: stats.total > 0)
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 88),
                      itemCount: visibleTodos.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final todo = visibleTodos[i];
                        return TodoTile(
                          key: ValueKey(todo.id),
                          todo: todo,
                          onToggle: () =>
                              ref.read(todoListProvider.notifier).toggle(todo),
                          onEdit: () => _editTodo(context, ref, todo),
                          onDelete: () => _deleteTodo(context, ref, todo),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addTodo(context, ref),
        icon: const Icon(Icons.add),
        label: AppText.title('Add task', color: Colors.white)
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.stats});

  final TodoStats stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stats.total == 0
                ? 'Nothing to do yet'
                : '${stats.completed} of ${stats.total} completed',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: stats.progress, minHeight: 6),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends ConsumerWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: AppTextField(
        prefixIcon: Icon(Icons.search),
          hint: 'Search tasks',
          onChanged: ref.read(searchQueryProvider.notifier).setQuery),
    );
  }
}

class _FilterBar extends ConsumerWidget {
  const _FilterBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(selectedFilterProvider);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SegmentedButton<TodoFilter>(
        showSelectedIcon: false,
        segments: [
          for (final f in TodoFilter.values)
            ButtonSegment(value: f, label: Text(f.label)),
        ],
        selected: {filter},
        onSelectionChanged: (s) =>
            ref.read(selectedFilterProvider.notifier).setFilter(s.first),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasAnyTodos});

  final bool hasAnyTodos;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            hasAnyTodos ? Icons.search_off : Icons.checklist_rtl,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(
            hasAnyTodos ? 'No tasks match your filter' : 'Tap "Add task" to get started',
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: 12),
          Text(message),
          const SizedBox(height: 12),
          FilledButton.tonal(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
