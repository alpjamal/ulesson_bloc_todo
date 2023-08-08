import 'package:bloc_example/presentation/main/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<LoadTasksEvent>(_loadTasks);
    on<CheckTaskEvent>(_checkTask);
    on<DeleteTaskEvent>(_deleteTask);
  }

  void _loadTasks(LoadTasksEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(
      pageStatus: PageStatus.loading,
    ));
    var tasks = _getTasks(event.count);
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(
      pageStatus: PageStatus.success,
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

  void _deleteTask(DeleteTaskEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(
      pageStatus: PageStatus.loading,
    ));
    var editingTaskList = state.tasks;

    editingTaskList = editingTaskList..removeAt(event.index);
    await Future.delayed(const Duration(milliseconds: 300));

    emit(state.copyWith(
      tasks: editingTaskList,
      pageStatus: PageStatus.success,
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
