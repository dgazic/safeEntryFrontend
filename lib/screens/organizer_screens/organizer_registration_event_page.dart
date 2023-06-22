import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe_entry/models/event_model.dart';
import 'package:safe_entry/providers/event_provider.dart';
import 'package:safe_entry/services/jwt_decoder.dart';
import 'package:safe_entry/widgets/appMessages.dart';

class OrganizerRegistrationEventPage extends StatefulWidget {
  const OrganizerRegistrationEventPage({super.key});

  @override
  State<OrganizerRegistrationEventPage> createState() =>
      _OrganizerRegistrationEventPageState();
}

class _OrganizerRegistrationEventPageState
    extends State<OrganizerRegistrationEventPage> {
  final _formKey = GlobalKey<FormState>();
  AppMessages appMessages = AppMessages();
  late EventRegistrationRequestModel eventRegistrationRequestModel;
  late EventRegistrationResponseModel eventRegistrationResponseModel;
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
    eventRegistrationRequestModel = EventRegistrationRequestModel();
    eventRegistrationResponseModel = EventRegistrationResponseModel();
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(child: Text("Vrijeme početka"))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            height: 50,
                            width: 330,
                            child: DateTimePicker(
                              locale: Locale("hr"),
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'd MMM, yyyy',
                              initialValue: DateTime.now().toString(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.event),
                              dateLabelText: 'Datum',
                              timeLabelText: "Vrijeme",
                              selectableDayPredicate: (date) {
                                if (date.weekday == 6 || date.weekday == 7) {
                                  return false;
                                }

                                return true;
                              },
                              onChanged: (val) {
                                DateFormat formatter =
                                    DateFormat("yyyy-MM-dd HH:mm");
                                DateTime dateTime = DateTime.parse(val);
                                String formattedString =
                                    formatter.format(dateTime);
                                _eventDateAndTimeController.text =
                                    formattedString;
                              },
                              validator: (val) {
                                DateFormat formatter =
                                    DateFormat("yyyy-MM-dd HH:mm");
                                DateTime dateTime = DateTime.parse(val!);
                                String formattedString =
                                    formatter.format(dateTime);
                                _eventDateAndTimeController.text =
                                    formattedString;
                                return null;
                              },
                              onSaved: (val) {
                                DateFormat formatter =
                                    DateFormat("yyyy-MM-dd HH:mm");
                                DateTime dateTime = DateTime.parse(val!);
                                String formattedString =
                                    formatter.format(dateTime);
                                _eventDateAndTimeController.text =
                                    formattedString;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CupertinoButton.filled(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _signUpProcess(context);
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

  void _signUpProcess(BuildContext context) async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final String userOrganizerId = jwtDecoder().getToken()['UserId'];
    var validate = _formKey.currentState?.validate();
    eventRegistrationRequestModel.eventName = _eventNameController.text;
    eventRegistrationRequestModel.eventAddress = _eventAddressController.text;
    eventRegistrationRequestModel.eventDescription =
        _eventDescriptionController.text;
    eventRegistrationRequestModel.eventStarts =
        _eventDateAndTimeController.text;
    eventRegistrationRequestModel.eventOrganizerId = int.parse(userOrganizerId);

    if (validate!) {
      var dataProvider =
          await eventProvider.EventRegistration(eventRegistrationRequestModel);
      if (dataProvider.success == true) {
        _eventNameController.clear();
        _eventAddressController.clear();
        _eventDescriptionController.clear();
        _eventDateAndTimeController.clear();

        appMessages.showInformationMessage(context, 1, "Uspiješno dodan event");
      } else {
        appMessages.showInformationMessage(
            context, 2, "Neuspješno dodan event");
      }
    }
  }
}
