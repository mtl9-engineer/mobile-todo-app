import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ColorPickerButton extends StatefulWidget {
  Color? initialColor;
  late Function(Color) callback;

  ColorPickerButton({Key? key, this.initialColor, required this.callback})
      : super(key: key);

  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerButton> {
  late Color dialogSelectColor; // Color for picker using color select dialog.

  @override
  void initState() {
    dialogSelectColor = widget.initialColor ?? Colors.black;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColorIndicator(
      borderRadius: 25,
      color: dialogSelectColor,
      onSelectFocus: false,
      onSelect: () async {
        final Color colorBeforeDialog = dialogSelectColor;
        if (!(await colorPickerDialog())) {
          setState(() {
            dialogSelectColor = colorBeforeDialog;
            widget.callback(colorBeforeDialog);
          });
        }
      },
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      pickersEnabled: const {ColorPickerType.accent: false},
      enableShadesSelection: false,
      onColorChanged: (Color color) => setState(() {
        dialogSelectColor = color;
        widget.callback(color);
      }),
      width: 44,
      height: 44,
      borderRadius: 22,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.headline5,
      ),
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 200, minWidth: 200, maxWidth: 320),
    );
  }
}
