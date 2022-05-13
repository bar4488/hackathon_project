import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hackathon_project/community_page/community_controller.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:intl/intl.dart';

class ModalAddSession extends StatefulWidget {
  const ModalAddSession({Key? key, required this.controller}) : super(key: key);

  final CommunityPageController controller;

  @override
  State<ModalAddSession> createState() => _ModalAddSessionState();
}

class _ModalAddSessionState extends State<ModalAddSession> {
  TextEditingController nameController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var f = DateFormat('yyyy.MM.dd hh:mm');
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.text_fields),
            title: TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: "name"),
            ),
          ),
          ListTile(
            title: TextFormField(
              controller: startController,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Start Date",
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await DatePicker.showDateTimePicker(
                  context,
                  currentTime: DateTime.now(),
                  minTime: DateTime.now(),
                );

                if (pickedDate != null) {
                  String formattedDate = f.format(pickedDate);
                  setState(() {
                    startController.text = formattedDate;
                  });
                }
              },
            ),
          ),
          ListTile(
            title: TextFormField(
              controller: endController,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "End Date",
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await DatePicker.showDateTimePicker(
                  context,
                  currentTime: DateTime.now(),
                  minTime: DateTime.now(),
                );

                if (pickedDate != null) {
                  String formattedDate = f.format(pickedDate);
                  setState(() {
                    endController.text = formattedDate;
                  });
                }
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.place),
            title: TextFormField(
              decoration: InputDecoration(hintText: "location"),
              controller: locationController,
            ),
          ),
          ListTile(
            leading: Icon(Icons.text_increase),
            title: TextFormField(
              decoration: InputDecoration(hintText: "description"),
              controller: descriptionController,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffFF9518),
                  Color(0xffFF4D4D),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    startController.text.isNotEmpty &&
                    endController.text.isNotEmpty) {
                  await widget.controller.createMeeting(
                    int.parse(widget.controller.community.id!),
                    Meeting(
                      name: nameController.text,
                      start: f.parse(startController.text),
                      end: f.parse(endController.text),
                      location: locationController.text.isEmpty
                          ? null
                          : locationController.text,
                      description: descriptionController.text.isEmpty
                          ? null
                          : descriptionController.text,
                      members: ["me"],
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text("Create!"),
            ),
          )
        ],
      ),
    );
  }
}
