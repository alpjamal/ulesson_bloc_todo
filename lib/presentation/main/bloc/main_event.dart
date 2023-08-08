part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {}

class LoadTasksEvent extends MainEvent {
  final int count;

  LoadTasksEvent({this.count = 10});

  @override
  List<Object?> get props => [count];
}

class CheckTaskEvent extends MainEvent {
  final int index;

  CheckTaskEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class DeleteTaskEvent extends MainEvent {
  final int index;

  DeleteTaskEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
