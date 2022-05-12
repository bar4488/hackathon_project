import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ModalAddSession extends StatefulWidget {
  const ModalAddSession({Key? key}) : super(key: key);

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
                  String formattedDate =
                      DateFormat('yyyy.MM.dd hh:mm').format(pickedDate);
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
                  String formattedDate =
                      DateFormat('yyyy.MM.dd hh:mm').format(pickedDate);
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
            ),
          ),
          ListTile(
            leading: Icon(Icons.text_increase),
            title: TextFormField(
              decoration: InputDecoration(hintText: "description"),
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
              onPressed: () {},
              child: Text("Create!"),
            ),
          )
        ],
      ),
    );
  }
}
