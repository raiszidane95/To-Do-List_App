// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:to_d_o_list_app/app/data/services/storage/repository.dart';

import '../../../data/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final textEditingCtrl = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);

  HomeController({
    required this.taskRepository,
  });

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTask());
    ever(tasks, (_) => taskRepository.writeTask(tasks));
    Logger().d(tasks);
  }

  @override
  void onClose() {
    super.onClose();
    textEditingCtrl.dispose();
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    } else {
      tasks.add(task);
      Logger().d(task);
      return true;
    }
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containeTodo(todos, title)) {
      return false;
    } else {
      var todo = {'title': title, 'done': false};
      todos.add(todo);
      var newtask = task.copyWith(todos: todos);
      int oldtask = tasks.indexOf(task);
      tasks[oldtask] = newtask;
      tasks.refresh();
      return true;
    }
  }

  bool containeTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }
}
