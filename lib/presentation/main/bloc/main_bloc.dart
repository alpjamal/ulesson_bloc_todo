import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/presentation/main/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<LoadTasksEvent>(_loadTasks);
    on<CheckTaskEvent>(_checkTask);
    on<DeleteTaskEvent>(_deleteTask);
  }

  void _loadTasks(LoadTasksEvent event, Emitter<MainState> emit) {
    var tasks = _getTasks(event.count);

    emit(state.copyWith(
      tasks: tasks,
    ));
  }

  void _checkTask(CheckTaskEvent event, Emitter<MainState> emit) {
    MyTask editingTask = state.tasks[event.index];
    editingTask = editingTask.copyWith(isDone: !editingTask.isDone);

    var editingTaskList = state.tasks;

    editingTaskList.removeAt(event.index);
    editingTaskList.insert(event.index, editingTask);

    emit(state.copyWith(
      tasks: editingTaskList,
    ));
  }

  void _deleteTask(DeleteTaskEvent event, Emitter<MainState> emit) {
    var editingTaskList = state.tasks;

    editingTaskList.removeAt(event.index);

    emit(state.copyWith(
      tasks: editingTaskList,
    ));
  }

  List<MyTask> _getTasks(int count) {
    return List.generate(
      count,
      (index) => MyTask(
        description: 'Task $index',
        isDone: false,
      ),
    );
  }
}
