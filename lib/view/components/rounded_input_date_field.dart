import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RoundedInputDate extends StatefulWidget {
  String? dateTime;
  final String? label;
  final TextEditingController? dateController;
  final ValueChanged<String>? changed;
  final String? initialValue;
  RoundedInputDate(
      {Key? key,
      this.label,
      this.dateTime,
      this.dateController,
      this.initialValue,
      this.changed})
      : super(key: key);

  @override
  State<RoundedInputDate> createState() => _RoundedInputDateState();
}

class _RoundedInputDateState extends State<RoundedInputDate> {
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.dateController,
      onChanged: widget.changed,
      onTap: () async {
         DatePicker.showDateTimePicker(context,
                              
                              showTitleActions: true,
                              minTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                             onConfirm: (date) {
                            String formattedDate =
              DateFormat('yyyy MMMM dd,HH:mm').format(date);
          setState(() {
            widget.dateController?.text = formattedDate;
          });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);

        
      },
      readOnly: true,
      decoration: const InputDecoration(
        label: Text("Deadline",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        suffixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.calendar_today,
          ),
        ),
      ),
    );
  }
}
