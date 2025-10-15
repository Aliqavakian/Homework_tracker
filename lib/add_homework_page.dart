import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'task.dart';
import 'task_bloc.dart';
import 'task_event.dart';

class AddHomeworkPage extends StatefulWidget {
  const AddHomeworkPage({super.key});

  @override
  State<AddHomeworkPage> createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _titleController = TextEditingController();
  
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().add(const Duration(days: 1));
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Homework'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title/Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title or description';
                  }
                  return null;
                },
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Due Date',
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.calendar_today),
                  hintText: DateFormat('EEE, MMM d, y').format(_selectedDate),
                ),
                onTap: _selectDate,
                controller: TextEditingController(
                  text: DateFormat('EEE, MMM d, y').format(_selectedDate),
                ),
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: _isFormValid() ? _saveHomework : null,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isFormValid() {
    return _subjectController.text.trim().isNotEmpty &&
           _titleController.text.trim().isNotEmpty;
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveHomework() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        subject: _subjectController.text.trim(),
        title: _titleController.text.trim(),
        dueDateMillis: _selectedDate.millisecondsSinceEpoch,
        completed: false,
      );

      context.read<TaskBloc>().add(AddTask(task));
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Homework saved'),
          duration: Duration(seconds: 2),
        ),
      );
      
      context.go('/');
    }
  }
}