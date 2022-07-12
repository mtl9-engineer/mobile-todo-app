import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todolist/view/components/tag.dart';

class TaskCard extends StatefulWidget {
  TaskCard({
    Key? key,
    required this.date,
    required this.name,
    required this.taskType,
    required this.size,
    required this.colorValue,
    required this.onPressed,
    required this.isDone,
    required this.onChangeStatus,
    required this.onDelete,
    required this.time
  }) : super(key: key);

  final Size size;
  final String name;
  final String date;
  final String time;
  final String taskType;
  final int colorValue;
  final bool isDone;
  VoidCallback onPressed;
  Function(bool) onChangeStatus;
  VoidCallback onDelete;
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onLongPress: widget.onDelete,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(widget.colorValue),
        child: SizedBox(
          height: widget.isDone ? 100 : 180,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                widget.isDone
                    ? const SizedBox(
                        height: 6,
                      )
                    : const SizedBox(
                        height: 0,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Tag(
                      mainText: widget.taskType,
                      fontSize: 14,
                      isButton: false,
                      borderColor: Colors.white,
                    ),
                    widget.isDone
                        ? RoundCheckBox(
                            size: 32,
                            isChecked: widget.isDone,
                            checkedColor: Colors.black,
                            onTap: (selected) {
                              widget.onChangeStatus(selected!);
                            },
                            uncheckedColor: Color(widget.colorValue),
                            border: Border.all(color: Colors.black),
                          )
                        : IconButton(
                            onPressed: widget.onPressed,
                            icon: const Icon(
                              Icons.edit,
                              size: 22,
                              color: Colors.white,
                            ))
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: size.width <= 375 ? 14 : 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                widget.isDone
                    ? Container()
                    : Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined,
                              color: Colors.white, size: 22),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(widget.date,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 8,
                ),
                widget.isDone
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.access_alarm,
                                  color: Colors.white, size: 22),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(widget.time,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                            ],
                          ),
                          widget.isDone == false
                              ? RoundCheckBox(
                                  size: 32,
                                  isChecked: widget.isDone,
                                  checkedColor: Colors.black,
                                  onTap: (selected) {
                                    widget.onChangeStatus(selected!);
                                  },
                                  uncheckedColor: Color(widget.colorValue),
                                  border: Border.all(color: Colors.black),
                                )
                              : const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
