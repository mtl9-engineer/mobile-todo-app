import 'package:flutter/material.dart';
import 'package:todolist/view/components/color_picker.dart';
import 'package:todolist/view/components/rounded_input_date_field.dart';
import 'package:group_button/group_button.dart';
import 'package:uuid/uuid.dart';
import '../../bloc/task_bloc.dart';
import '../../model/task_model.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  NewTask({
    Key? key,
    this.editTodo,
  }) : super(key: key);

  Todo? editTodo;
  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final _taskTypeController = GroupButtonController();
  final TodoBloc todoBloc = TodoBloc();
  Color? _selectedColor = Colors.black;

  final List<String> _buttons = ['Basic', 'Urgent', 'Important'];
  String _selectedTaskType = "Basic";
  @override
  void initState() {
    super.initState();
    if (widget.editTodo != null) {
      _taskNameController.text = widget.editTodo!.description;
      _dateController.text =
          "${widget.editTodo!.date},${widget.editTodo!.time}";
      _taskTypeController
          .selectIndex(_buttons.indexOf(widget.editTodo!.taskType));
      _selectedColor = Color(widget.editTodo!.colorValue);
    } else {
      _taskTypeController.selectIndex(0);
    }
  }

  callback(newColor) {
    setState(() {
      _selectedColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              debugPrint(_selectedColor.toString());
              final newTodo = Todo(
                  id: widget.editTodo?.id ?? const Uuid().v1(),
                  description: _taskNameController.text,
                  date: _dateController.text.split(',')[0],
                  time: _dateController.text.split(',')[1],
                  taskType: _selectedTaskType,
                  colorValue: _selectedColor?.value ?? Colors.black.value,
                  isDone: widget.editTodo?.isDone ?? false);
              if (newTodo.description.isNotEmpty && newTodo.date.isNotEmpty) {
                widget.editTodo != null
                    ? todoBloc.updateTodo(
                        newTodo,
                        0,
                        DateFormat('yyyy MMMM dd').format(DateTime.now()),
                        true,
                        '')
                    : todoBloc.addTodo(
                        newTodo,
                        0,
                        DateFormat('yyyy MMMM dd').format(DateTime.now()),
                        true,
                        '');
                Navigator.of(context).pop(true);
              }
            },
            backgroundColor: Colors.black,
            label: SizedBox(
                width: size.width * 0.8,
                child: Center(
                  child: widget.editTodo != null
                      ? const Text("Save Edited Task",
                          style: TextStyle(fontSize: 17))
                      : const Text(
                          "Save Task",
                          style: TextStyle(fontSize: 17),
                        ),
                ))),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Center(
                                    child: widget.editTodo != null
                                        ? const Text("Edit Task",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22))
                                        : const Text("New Task",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22))),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 40,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Column(
                            children: [
                              TextField(
                                controller: _taskNameController,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                    label: const Text("My New Task",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: ColorPickerButton(
                                        initialColor: _selectedColor,
                                        callback: callback,
                                      ),
                                    )),
                              ),
                              const SizedBox(height: 20),
                              RoundedInputDate(
                                dateController: _dateController,
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Task Type",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: GroupButton(
                                        onSelected: (test, i, selected) {
                                          setState(() {
                                            _selectedTaskType = test.toString();
                                          });
                                        },
                                        controller: _taskTypeController,
                                        isRadio: true,
                                        options: GroupButtonOptions(
                                          selectedShadow: const [],
                                          selectedTextStyle: TextStyle(
                                            fontSize:
                                                size.width <= 375 ? 14 : 16,
                                            color: Colors.white,
                                          ),
                                          selectedColor: Colors.black,
                                          unselectedShadow: const [],
                                          unselectedColor: Colors.white,
                                          unselectedTextStyle: TextStyle(
                                            fontSize:
                                                size.width <= 375 ? 14 : 16,
                                            color: Colors.black,
                                          ),
                                          selectedBorderColor: Colors.black,
                                          unselectedBorderColor: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          spacing: 10,
                                          runSpacing: 10,
                                          groupingType: GroupingType.row,
                                          direction: Axis.horizontal,
                                          buttonHeight: 42,
                                          buttonWidth:
                                              size.width <= 375 ? 70 : 100,
                                          mainGroupAlignment:
                                              MainGroupAlignment.spaceBetween,
                                          textAlign: TextAlign.center,
                                          textPadding: EdgeInsets.zero,
                                          alignment: Alignment.center,
                                          elevation: 0,
                                        ),
                                        maxSelected: 1,
                                        buttons: _buttons,
                                      )),
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                  ),
                                  SizedBox(
                                    
                                    child: TextButton(
                                      onPressed: (() {
                                        
                                      }),
                                      child: Container(
                                        height : 60,
                                        decoration:  BoxDecoration(
                                          color: _selectedColor ?? Colors.black,
                                          borderRadius: BorderRadius.circular(25) 
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:  <Widget>[
                                            Icon(
                                              Icons.file_copy,
                                              color: _selectedColor == Colors.black ? Colors.white : Colors.black,
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(left :10.0),
                                              child: Text(
                                                'Attach File',
                                                style:
                                                    TextStyle(color: _selectedColor == Colors.black ? Colors.white : Colors.black , fontSize: 17),
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ]),
                  ))),
        ));
  }
}
