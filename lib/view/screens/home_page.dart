import 'dart:async';
import 'package:flutter/material.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:todolist/view/components/task_card.dart';
import 'package:todolist/view/screens/new_task.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:todolist/view/screens/settings_page.dart';
import '../../bloc/task_bloc.dart';
import '../../model/task_model.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  final _taskTagTime = GroupButtonController();
  final List<String> _buttons = ['Today', 'Upcoming', 'Done'];
  final TodoBloc todoBloc = TodoBloc();
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _taskTagTime.selectIndex(0);
    textController.addListener(_filterChange);
  }

  FutureOr onGoBack(dynamic value) {
    _selectedIndex = 0;
    _taskTagTime.selectIndex(0);
    todoBloc.getTodos(
        isDone: 0,
        date: DateFormat('yyyy MMMM dd').format(DateTime.now()),
        isNow: true,
        description: textController.text);
  }

  void _filterChange() {
    switch (_selectedIndex) {
      case 0:
        todoBloc.getTodos(
            isDone: 0,
            date: DateFormat('yyyy MMMM dd').format(DateTime.now()),
            isNow: true,
            description: textController.text);
        break;
      case 1:
        todoBloc.getTodos(
            isDone: 0,
            date: DateFormat('yyyy MMMM dd').format(DateTime.now()),
            isNow: false,
            description: textController.text);
        break;
      case 2:
        todoBloc.getTodos(
            isDone: 1,
            date: DateFormat('yyyy MMMM dd').format(DateTime.now()),
            description: textController.text);
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            textController.text = '';
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewTask()),
            ).then(onGoBack);
          },
          backgroundColor: Colors.black,
          icon: const Icon(
            Icons.add_box_rounded,
            size: 18,
          ),
          label: const Text(
            "Add Task",
            style: TextStyle(fontSize: 17),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     IconButton(icon:const Icon(Icons.apps_sharp , size: 40,),onPressed: (() {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> const Settings()));
                     }),),
                     Padding(
                      padding: size.width <= 375 ? const EdgeInsets.only(left:  19) : const EdgeInsets.only(left:  24) ,
                      child: const Text("Task Manager",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                    ),
                    IconBadge(
                      icon: const Icon(Icons.notifications_none_outlined,
                          color: Colors.black, size: 40),
                      badgeColor: Colors.red,
                      itemColor: Colors.red,
                      hideZero: false,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(" Here's Update Today!",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                AnimSearchBar(
                  width: 400.w,
                  textController: textController,
                  onSuffixTap: () {
                    setState(() {
                      textController.clear();
                    });
                  },
                  rtl: true,
                ),
                GroupButton(
                  controller: _taskTagTime,
                  onSelected: (title, index, selected) {
                    switch (index) {
                      case 0:
                        _selectedIndex = index;
                        todoBloc.getTodos(
                            isDone: 0,
                            date: DateFormat('yyyy MMMM dd')
                                .format(DateTime.now()),
                            isNow: true,
                            description: textController.text);
                        break;
                      case 1:
                        _selectedIndex = index;
                        todoBloc.getTodos(
                            isDone: 0,
                            date: DateFormat('yyyy MMMM dd')
                                .format(DateTime.now()),
                            isNow: false,
                            description: textController.text);
                        break;
                      case 2:
                        _selectedIndex = index;
                        todoBloc.getTodos(
                            isDone: 1,
                            date: DateFormat('yyyy MMMM dd')
                                .format(DateTime.now()),
                            description: textController.text);
                        break;

                      default:
                    }
                  },
                  options: GroupButtonOptions(
                    selectedTextStyle: TextStyle(
                      fontSize: size.width <= 375 ? 12 : 14,
                      color: Colors.white,
                    ),
                    selectedColor: Colors.black,
                    unselectedShadow: const [],
                    unselectedColor: Colors.white,
                    unselectedTextStyle: TextStyle(
                      fontSize: size.width <= 375 ? 12 : 14,
                      color: Colors.black,
                    ),
                    selectedBorderColor: Colors.black,
                    unselectedBorderColor: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    spacing: 10,
                    runSpacing: 10,
                    groupingType: GroupingType.row,
                    direction: Axis.horizontal,
                    buttonHeight: 40,
                    buttonWidth: size.width <= 375 ? 70 : 100,
                    mainGroupAlignment: MainGroupAlignment.spaceBetween,
                    textAlign: TextAlign.center,
                    textPadding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    elevation: 0,
                  ),
                  isRadio: true,
                  buttons: _buttons,
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 300.h,
                  child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.white
                          ],
                          stops: [
                            0.0,
                            0.1,
                            0.9,
                            1.0
                          ], // 10% purple, 80% transparent, 10% purple
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: StreamBuilder(
                          stream: todoBloc.todos,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Todo>> snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data!.isNotEmpty
                                  ? ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        Todo todo = snapshot.data![index];
                
                                        return ListTile(
                                          title: TaskCard(
                                            size: size,
                                            taskType: todo.taskType,
                                            date: todo.date,
                                            time: todo.time,
                                            name: todo.description,
                                            colorValue: todo.colorValue,
                                            isDone: todo.isDone,
                                            onDelete: () {
                                              switch (_selectedIndex) {
                                                case 0:
                                                  todoBloc.deleteTodoById(
                                                      todo.id,
                                                      0,
                                                      DateFormat('yyyy MMMM dd')
                                                          .format(
                                                              DateTime.now()),
                                                      true,
                                                      textController.text);
                                                  break;
                
                                                case 1:
                                                  todoBloc.deleteTodoById(
                                                      todo.id,
                                                      0,
                                                      DateFormat('yyyy MMMM dd')
                                                          .format(
                                                              DateTime.now()),
                                                      false,
                                                      textController.text);
                                                  break;
                
                                                case 2:
                                                  todoBloc.deleteTodoById(
                                                      todo.id,
                                                      1,
                                                      DateFormat('yyyy MMMM dd')
                                                          .format(
                                                              DateTime.now()),
                                                      null,
                                                      textController.text);
                
                                                  break;
                                                default:
                                              }
                                            },
                                            onChangeStatus: (selected) {
                                              todo.isDone = selected;
                                              switch (_selectedIndex) {
                                                case 0:
                                                  todoBloc.updateTodo(
                                                      todo,
                                                      0,
                                                      DateFormat('yyyy MMMM dd')
                                                          .format(
                                                              DateTime.now()),
                                                      true,
                                                      textController.text);
                                                  break;
                
                                                case 1:
                                                  todoBloc.updateTodo(
                                                      todo,
                                                      0,
                                                      DateFormat('yyyy MMMM dd')
                                                          .format(
                                                              DateTime.now()),
                                                      false,
                                                      textController.text);
                                                  break;
                
                                                case 2:
                                                  todoBloc.updateTodo(
                                                      todo,
                                                      1,
                                                      DateFormat('yyyy MMMM dd')
                                                          .format(
                                                              DateTime.now()),
                                                      null,
                                                      textController.text);
                
                                                  break;
                                                default:
                                              }
                                            },
                                            onPressed: () {
                                              textController.text = '';
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewTask(
                                                            editTodo: todo,
                                                          ))).then(onGoBack);
                                            },
                                          ),
                                        );
                                      })
                                  : const Center(
                                      child: Text(
                                        "Start adding Todo...",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );
                            } else {
                              todoBloc.getTodos(
                                  isDone: 0,
                                  date: DateFormat('yyyy MMMM dd')
                                      .format(DateTime.now()),
                                  isNow: true,
                                  description: textController.text);
                
                              return Center(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      CircularProgressIndicator(),
                                      Text("Loading...",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                              );
                            }
                          })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
