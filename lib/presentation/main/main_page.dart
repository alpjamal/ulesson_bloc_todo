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
          body: state.pageStatus.isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : state.tasks.isNotEmpty
                  ? ListView.builder(
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
                                onPressed: currentTask.isDone
                                    ? () {
                                        context.read<MainBloc>().add(DeleteTaskEvent(index: index));
                                      }
                                    : null,
                                icon: Icon(
                                  Icons.delete,
                                  color: currentTask.isDone ? Colors.red : Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Oops, you have no tasks to do!',
                              style: TextStyle(fontSize: 30),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<MainBloc>().add(LoadTasksEvent());
                              },
                              child: const Text('Generate tasks'),
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
