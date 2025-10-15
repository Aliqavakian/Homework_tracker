import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'homework_repository.dart';
import 'homework_tile.dart';
import 'task_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';

class HomeworkListPage extends StatelessWidget {
  const HomeworkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Homework'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _FilterChips(),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state.loading && state.tasks.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (state.tasks.isEmpty) {
                    return _EmptyState();
                  }
                  
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return HomeworkTile(task: task);
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.go('/add'),
          child: const Icon(Icons.add),
          tooltip: 'Add homework',
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              FilterChip(
                label: const Text('All'),
                selected: state.filter == Filter.all,
                onSelected: (_) {
                  context.read<TaskBloc>().add(const ChangeFilter(Filter.all));
                },
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Active'),
                selected: state.filter == Filter.active,
                onSelected: (_) {
                  context.read<TaskBloc>().add(const ChangeFilter(Filter.active));
                },
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Completed'),
                selected: state.filter == Filter.completed,
                onSelected: (_) {
                  context.read<TaskBloc>().add(const ChangeFilter(Filter.completed));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 72,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No homework yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first assignment',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.go('/add'),
            icon: const Icon(Icons.add),
            label: const Text('Add Homework'),
          ),
        ],
      ),
    );
  }
}