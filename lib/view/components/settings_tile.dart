import 'package:flutter/material.dart';

class SettingsTile extends StatefulWidget {
  IconData leadingIcon;
  String title;
  bool isProfile;

  SettingsTile(
      {Key? key,
      required this.leadingIcon,
      required this.title,
      required this.isProfile})
      : super(key: key);

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Card(
        elevation: widget.isProfile ? 10 : 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          leading: Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(25)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 4.0),
                child: Icon(
                  widget.leadingIcon,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ],
          ),
          title: widget.isProfile
              ? Text(
                  widget.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(widget.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
          subtitle: widget.isProfile
              ? const Text("mrtaoufiklahmidi@gmail.com")
              : const Text(''),
          trailing: widget.isProfile
              ? const Icon(
                  Icons.arrow_drop_down_circle_sharp,
                  color: Colors.black,
                  size: 30,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
