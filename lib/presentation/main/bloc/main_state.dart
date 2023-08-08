part of 'main_bloc.dart';

class MainState extends Equatable {
  final List<MyTask> tasks;
  final bool isUpdated;
  final PageStatus pageStatus;

  const MainState({
    this.tasks = const [],
    this.isUpdated = false,
    this.pageStatus = PageStatus.initial,
  });

  MainState copyWith({
    List<MyTask>? tasks,
    PageStatus? pageStatus,
  }) {
    return MainState(
      tasks: tasks ?? this.tasks,
      isUpdated: !isUpdated,
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }

  @override
  List<Object?> get props => [tasks, isUpdated, pageStatus];
}

enum PageStatus { initial, loading, success, error }

extension BasketStateStatusX on PageStatus {
  bool get isInitial => this == PageStatus.initial;

  bool get isLoading => this == PageStatus.loading;

  bool get isSuccess => this == PageStatus.success;

  bool get isError => this == PageStatus.error;
}
