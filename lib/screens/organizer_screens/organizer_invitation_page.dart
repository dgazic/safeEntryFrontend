import 'package:flutter/cupertino.dart';

class OrganizerInvitationSendPage extends StatefulWidget {
  const OrganizerInvitationSendPage({super.key});

  @override
  State<OrganizerInvitationSendPage> createState() =>
      _OrganizerInvitationSendPageState();
}

class _OrganizerInvitationSendPageState
    extends State<OrganizerInvitationSendPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _guestFirstNameController;
  late TextEditingController _guestLastNameController;
  late TextEditingController _guestEmailController;
  late TextEditingController _guestMobileNumberController;

  @override
  void initState() {
    super.initState();
    _guestFirstNameController = TextEditingController();
    _guestLastNameController = TextEditingController();
    _guestEmailController = TextEditingController();
    _guestMobileNumberController = TextEditingController();
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
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                      // Retrieve the values from the TextEditingController
                      final guestFirstName = _guestFirstNameController.text;
                      final guestLastName = _guestLastNameController.text;
                      final guestEmailAddress = _guestEmailController.text;
                      final guestMobileNumber =
                          _guestMobileNumberController.text;
                      // Process the registration data
                      // For example, send the data to an API or save it locally
                      // using companyName, companyEmail, and companyAddress variables
                    }
                  },
                  child: Text('Poziva na događaj'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
