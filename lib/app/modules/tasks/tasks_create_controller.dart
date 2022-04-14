// ignore_for_file: unnecessary_getters_setters, avoid_print

import 'package:flutter_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_todo_list_provider/app/sevices/tasks/tasks_service.dart';

class TasksCreateController extends DefaultChangeNotifier {
  // ignore: unused_field
  final TasksService _tasksService;

  DateTime? _selectedDate;
  TasksCreateController({required TasksService tasksService})
      : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  void save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da tarefa não selecionada !');
      }
    } catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar tarefa !');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
