import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'homework_task.dart';
import 'task_bloc.dart';
import 'task_event.dart';

class HomeworkTile extends StatelessWidget {
  const HomeworkTile({
    super.key,
    required this.task,
  });

  final HomeworkTask task;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dueDate = DateTime.fromMillisecondsSinceEpoch(task.dueDateMillis);
    final formattedDate = DateFormat('EEE, MMM d').format(dueDate);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: task.completed,
          onChanged: (value) {
            context.read<TaskBloc>().add(ToggleCompleted(task));
          },
          semanticsLabel: task.completed 
              ? 'Mark ${task.title} as incomplete'
              : 'Mark ${task.title} as complete',
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.subject,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              task.title,
              style: theme.textTheme.bodyLarge?.copyWith(
                decoration: task.completed ? TextDecoration.lineThrough : null,
                color: task.completed 
                    ? theme.colorScheme.onSurface.withOpacity(0.6)
                    : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        trailing: Text(
          'Due $formattedDate',
          style: theme.textTheme.bodySmall?.copyWith(
            color: task.completed 
                ? theme.colorScheme.onSurface.withOpacity(0.6)
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        tileColor: task.completed 
            ? theme.colorScheme.surface.withOpacity(0.5)
            : null,
        semanticsLabel: 'Homework: ${task.subject} - ${task.title}. Due $formattedDate. ${task.completed ? 'Completed' : 'Pending'}',
      ),
    );
  }
}