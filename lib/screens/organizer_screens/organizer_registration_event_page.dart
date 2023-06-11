import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_entry/widgets/datetime_picker.dart';

class OrganizerRegistrationEventPage extends StatefulWidget {
  const OrganizerRegistrationEventPage({super.key});

  @override
  State<OrganizerRegistrationEventPage> createState() =>
      _OrganizerRegistrationEventPageState();
}

class _OrganizerRegistrationEventPageState
    extends State<OrganizerRegistrationEventPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _eventNameController;
  late TextEditingController _eventAddressController;
  late TextEditingController _eventDateAndTimeController;
  late TextEditingController _eventDescriptionController;

  @override
  void initState() {
    super.initState();
    _eventNameController = TextEditingController();
    _eventAddressController = TextEditingController();
    _eventDateAndTimeController = TextEditingController();
    _eventDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventAddressController.dispose();
    _eventDateAndTimeController.dispose();
    _eventDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Registracija eventa'),
        automaticallyImplyLeading: false,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CupertinoTextFormFieldRow(
                  controller: _eventNameController,
                  placeholder: 'Ime eventa',
                  keyboardType: TextInputType.text,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.black,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Unesite ime eventa';
                    }
                    return null;
                  },
                ),
                CupertinoTextFormFieldRow(
                  controller: _eventAddressController,
                  placeholder: 'Adresa eventa',
                  keyboardType: TextInputType.emailAddress,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.black,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Unesite adresu eventa';
                    }
                    // Add email validation logic if needed
                    return null;
                  },
                ),
                CupertinoTextFormFieldRow(
                  controller: _eventDescriptionController,
                  placeholder: 'Opis eventa',
                  keyboardType: TextInputType.text,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.black,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Unesite opis eventa';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Vrijeme početka eventa"),
                                  content: Container(
                                    height: 200,
                                    child: DatePickerExample(),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("Zatvori"))
                                  ],
                                );
                              })
                        },
                        label: Text("Odaberi vrijeme"),
                        icon: Icon(Icons.timelapse),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange)),
                        child: Text(
                          "22.06.2023 - 15:00",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                CupertinoButton.filled(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Retrieve the values from the TextEditingController
                      // final organizerName = _oranizerNameController.text;
                      // final organizerEmail = _organizerEmailController.text;
                      // final organizerAddress = _organizerAddressController.text;
                      // final organizerMobileNumber =
                      //     _organizerMobileNumberController.text;
                      // Process the registration data
                      // For example, send the data to an API or save it locally
                      // using companyName, companyEmail, and companyAddress variables
                    }
                  },
                  child: Text('Registriraj event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
