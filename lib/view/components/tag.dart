import 'package:flutter/material.dart';

class Tag extends StatefulWidget {
  String mainText;
  double? width;
  double? height;
  Color? borderColor;
  Color? textColor;
  FontWeight? fontWeight;
  double? fontSize;
  Color? backgroundColor;
  bool isButton;
  Tag({
    Key? key,
    required this.mainText,
    this.width,
    this.height,
    this.borderColor,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.backgroundColor,
    required this.isButton,
  }) : super(key: key);

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.width ,
      height: widget.height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:  Text( widget.mainText, style: TextStyle(color:widget.textColor ?? Colors.white , fontWeight: widget.fontWeight , fontSize: widget.fontSize),),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: widget.borderColor ?? Colors.grey),
        color: widget.backgroundColor,
        
      ),
    );
  }
}