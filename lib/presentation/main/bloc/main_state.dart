part of 'main_bloc.dart';

class MainState extends Equatable {
  final List<MyTask> tasks;
  final bool isUpdated;

  const MainState({
    this.tasks = const [],
    this.isUpdated = false,
  });

  MainState copyWith({
    List<MyTask>? tasks,
  }) {
    return MainState(
      tasks: tasks ?? this.tasks,
      isUpdated: !isUpdated,
    );
  }

  @override
  List<Object?> get props => [tasks, isUpdated];
}
