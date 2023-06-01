import 'package:flutter/cupertino.dart';

class AdministratorSecurityRegistrationPage extends StatefulWidget {
  const AdministratorSecurityRegistrationPage({super.key});

  @override
  State<AdministratorSecurityRegistrationPage> createState() =>
      _AdministratorSecurityRegistrationPageState();
}

class _AdministratorSecurityRegistrationPageState
    extends State<AdministratorSecurityRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _companyNameController;
  late TextEditingController _companyEmailController;
  late TextEditingController _companyAddressController;

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController();
    _companyEmailController = TextEditingController();
    _companyAddressController = TextEditingController();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _companyEmailController.dispose();
    _companyAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Registracija security tvrtke'),
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
                  controller: _companyNameController,
                  placeholder: 'Ime kompanije',
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
                      return 'Unesite ime kompanije';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CupertinoTextFormFieldRow(
                  controller: _companyEmailController,
                  placeholder: 'Email adresa kompanije',
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
                      return 'Unesite email adresu kompanije';
                    }
                    // Add email validation logic if needed
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CupertinoTextFormFieldRow(
                  controller: _companyAddressController,
                  placeholder: 'Adresa kompanije',
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
                      return 'Unesite adresu kompanije';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CupertinoButton.filled(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Retrieve the values from the TextEditingController
                      final companyName = _companyNameController.text;
                      final companyEmail = _companyEmailController.text;
                      final companyAddress = _companyAddressController.text;

                      // Process the registration data
                      // For example, send the data to an API or save it locally
                      // using companyName, companyEmail, and companyAddress variables
                    }
                  },
                  child: Text('Registriraj tvrtku'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
