import 'package:bloc_example/presentation/main/bloc/main_bloc.dart';
import 'package:bloc_example/presentation/main/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
          ),
          body: ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              MyTask currentTask = state.tasks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 1,
                  child: ListTile(
                    leading: Checkbox(
                      value: currentTask.isDone,
                      onChanged: (bool? value) {
                        context.read<MainBloc>().add(CheckTaskEvent(index: index));
                      },
                    ),
                    title: Text(currentTask.description),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<MainBloc>().add(DeleteTaskEvent(index: index));
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
