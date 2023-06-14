import 'package:flutter/material.dart';
import 'package:task1_app/DBhelper/db_connection.dart';
import 'package:task1_app/model/detail.dart';
import 'package:task1_app/screens/view_list.dart';

class SaveDetails extends StatefulWidget {
  const SaveDetails({super.key});

  @override
  State<SaveDetails> createState() => _SaveDetailsState();
}

class _SaveDetailsState extends State<SaveDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController luckyNumberController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Detail? detail;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Save Details"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) => value == null || value.isEmpty
                        ? "Name cannot be empty"
                        : null,
                    decoration: const InputDecoration(
                        labelText: "Enter your Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        )),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: luckyNumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? "lucky number cannot be empty"
                        : null,
                    decoration: const InputDecoration(
                        labelText: "Enter your lucky Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        )),
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? "salary cannot be empty"
                      : null,
                  decoration: const InputDecoration(
                      labelText: "Enter your Salary",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      toSave();
                      setState(() {
                        debugPrint("set state of save has been called");
                      });
                    },
                    child: const Text("Save"),
                  ),
                  const Spacer(
                    flex: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      nameController.clear();
                      luckyNumberController.clear();
                      salaryController.clear();
                      debugPrint("The values were cleared");
                    },
                    child: const Text("Clear"),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void toSave() async {
    if (_formKey.currentState!.validate()) {
      int luckyNumber = int.parse(luckyNumberController.text);
      double salary = double.parse(salaryController.text);
      // Detail dt = Detail(name: nameController.text,luckyNumber: luckyNumber,salary: salary);
      Detail dt = Detail();
      dt.name = nameController.text;
      dt.luckyNumber = luckyNumber;
      dt.salary = salary;
      debugPrint(
          "name:$nameController.text,luckyNumber:$luckyNumberController.text,salary:$salaryController.text");
      await _databaseHelper.insert(dt);
      debugPrint("details Added");
      setState(() {
        const ListViewer();
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }
}
