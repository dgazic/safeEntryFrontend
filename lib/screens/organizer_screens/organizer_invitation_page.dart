import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_entry/models/event_invitation_model.dart';
import 'package:safe_entry/providers/event_provider.dart';
import 'package:safe_entry/services/jwt_decoder.dart';
import 'package:safe_entry/widgets/appMessages.dart';

class OrganizerInvitationSendPage extends StatefulWidget {
  const OrganizerInvitationSendPage({super.key});

  @override
  State<OrganizerInvitationSendPage> createState() =>
      _OrganizerInvitationSendPageState();
}

class _OrganizerInvitationSendPageState
    extends State<OrganizerInvitationSendPage> {
  final _formKey = GlobalKey<FormState>();
  AppMessages appMessages = AppMessages();
  late TextEditingController _guestFirstNameController;
  late TextEditingController _guestLastNameController;
  late TextEditingController _guestEmailController;
  late TextEditingController _guestMobileNumberController;
  late EventProvider eventProvider;
  late EventInvitationRequestModel eventInvitationRequestModel;
  late Map<int, String> mappedData;
  late EventInvitationResponseModel eventInvitationResponseModel;
  late int selectedEvent;

  List<String> dropdownEventsItemSource = <String>[];
  String? dropdownEvent;
  List<int> eventsIds = [];

  @override
  void initState() {
    super.initState();
    EventProvider eventProvider = EventProvider();
    eventInvitationRequestModel = EventInvitationRequestModel();
    eventInvitationResponseModel = EventInvitationResponseModel();
    _guestFirstNameController = TextEditingController();
    _guestLastNameController = TextEditingController();
    _guestEmailController = TextEditingController();
    _guestMobileNumberController = TextEditingController();
    eventProvider.fetchEvents().then((value) {
      for (var v in value) {
        dropdownEventsItemSource.add(v.Name!);
        eventsIds.add(v.Id!);
        print(dropdownEventsItemSource);
        print(eventsIds);
        mappedData = Map.fromIterables(eventsIds, dropdownEventsItemSource);
        print(mappedData);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _guestFirstNameController.dispose();
    _guestLastNameController.dispose();
    _guestEmailController.dispose();
    _guestMobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Pozivanje uzvanika na događaj'),
        automaticallyImplyLeading: false,
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text("Registrirani eventi"),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13),
                          child: Container(child: _buildEventDropDownField())),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _guestFirstNameController,
                    placeholder: 'Ime uzvanika',
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
                        return 'Unesite ime uzvanika';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _guestLastNameController,
                    placeholder: 'Prezime uzvanika',
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
                        return 'Unesite prezime uzvanika';
                      }
                      // Add email validation logic if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _guestEmailController,
                    placeholder: 'Email adresa uzvanika',
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
                        return 'Unesite email adresu organizatora';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTextFormFieldRow(
                    controller: _guestMobileNumberController,
                    placeholder: 'Broj telefona uzvanika',
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
                        return 'Unesite broj telefona uzvanika';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CupertinoButton.filled(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _invitationProcess(context);
                      }
                    },
                    child: Text('Poziva na događaj'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventDropDownField() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.055,
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5.0)))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: dropdownEvent,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: dropdownEventsItemSource.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(items),
              ),
            );
          }).toList(),
          onChanged: (String? newProduct) {
            if (newProduct != null) {
              dropdownEvent = newProduct;
              mappedData.forEach((key, value) {
                if (value == dropdownEvent) {
                  selectedEvent = key;
                }
              });
              setState(() {});
            }
          },
        ),
      ),
    );
  }

  void _invitationProcess(BuildContext context) async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    var validate = _formKey.currentState?.validate();
    eventInvitationRequestModel.firstName = _guestFirstNameController.text;
    eventInvitationRequestModel.lastName = _guestLastNameController.text;
    eventInvitationRequestModel.email = _guestEmailController.text;
    eventInvitationRequestModel.phoneNumber = _guestMobileNumberController.text;
    eventInvitationRequestModel.eventId = selectedEvent;

    if (validate!) {
      var dataProvider = await eventProvider.PeopleRegistrationEvent(
          eventInvitationRequestModel);
      if (dataProvider.success == true) {
        _guestFirstNameController.clear();
        _guestLastNameController.clear();
        _guestEmailController.clear();
        _guestMobileNumberController.clear();

        appMessages.showInformationMessage(
            context, 1, "Uspiješno poslana pozivnica za event");
      } else {
        appMessages.showInformationMessage(
            context, 2, "Neuspješno slanje pozivnice");
      }
    }
  }
}
