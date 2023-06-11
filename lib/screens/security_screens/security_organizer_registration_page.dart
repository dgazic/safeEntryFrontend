import 'package:flutter/cupertino.dart';

class SecurityOrganizerRegistrationPage extends StatefulWidget {
  const SecurityOrganizerRegistrationPage({super.key});

  @override
  State<SecurityOrganizerRegistrationPage> createState() =>
      _SecurityOrganizerRegistrationPageState();
}

class _SecurityOrganizerRegistrationPageState
    extends State<SecurityOrganizerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _oranizerNameController;
  late TextEditingController _organizerEmailController;
  late TextEditingController _organizerAddressController;
  late TextEditingController _organizerMobileNumberController;

  @override
  void initState() {
    super.initState();
    _oranizerNameController = TextEditingController();
    _organizerEmailController = TextEditingController();
    _organizerAddressController = TextEditingController();
    _organizerMobileNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _oranizerNameController.dispose();
    _organizerEmailController.dispose();
    _organizerAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Registracija organizatora eventa'),
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
                  controller: _oranizerNameController,
                  placeholder: 'Ime organizatora',
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
                      return 'Unesite ime organizatora';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CupertinoTextFormFieldRow(
                  controller: _organizerEmailController,
                  placeholder: 'Email adresa organizatora',
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
                      return 'Unesite email adresu organizatora';
                    }
                    // Add email validation logic if needed
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CupertinoTextFormFieldRow(
                  controller: _organizerAddressController,
                  placeholder: 'Adresa organizatora',
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
                      return 'Unesite adresu organizatora';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CupertinoTextFormFieldRow(
                  controller: _organizerMobileNumberController,
                  placeholder: 'Broj telefona organizatora',
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
                      return 'Unesite adresu organizatora';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CupertinoButton.filled(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Retrieve the values from the TextEditingController
                      final organizerName = _oranizerNameController.text;
                      final organizerEmail = _organizerEmailController.text;
                      final organizerAddress = _organizerAddressController.text;
                      final organizerMobileNumber =
                          _organizerMobileNumberController.text;
                      // Process the registration data
                      // For example, send the data to an API or save it locally
                      // using companyName, companyEmail, and companyAddress variables
                    }
                  },
                  child: Text('Registriraj organizatora'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
