import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:safe_entry/models/register_model.dart';
import 'package:safe_entry/providers/auth_provider.dart';
import 'package:safe_entry/widgets/appMessages.dart';

class SecurityOrganizerRegistrationPage extends StatefulWidget {
  const SecurityOrganizerRegistrationPage({super.key});

  @override
  State<SecurityOrganizerRegistrationPage> createState() =>
      _SecurityOrganizerRegistrationPageState();
}

class _SecurityOrganizerRegistrationPageState
    extends State<SecurityOrganizerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  AppMessages appMessages = AppMessages();
  late TextEditingController _ownerFirstNameController;
  late TextEditingController _ownerLastNameController;
  late TextEditingController _companyMobileController;
  late TextEditingController _companyNameController;
  late TextEditingController _companyEmailController;
  late TextEditingController _companyAddressController;

  late RegisterRequestModel requestModel;
  late RegisterResponseModel responseModel;

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController();
    _companyEmailController = TextEditingController();
    _companyAddressController = TextEditingController();
    _ownerFirstNameController = TextEditingController();
    _ownerLastNameController = TextEditingController();
    _companyMobileController = TextEditingController();
    requestModel = RegisterRequestModel(userRole: 2);
    responseModel = RegisterResponseModel();
  }

  @override
  void dispose() {
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
            child: SingleChildScrollView(
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
                    validator: (value) => _emailValidation(value!),
                  ),
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
                  CupertinoTextFormFieldRow(
                    controller: _ownerFirstNameController,
                    placeholder: 'Ime vlasnika kompanije',
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
                        return 'Unesite ime vlasnika kompanije';
                      }
                      return null;
                    },
                  ),
                  CupertinoTextFormFieldRow(
                    controller: _ownerLastNameController,
                    placeholder: 'Prezime vlasnika kompanije',
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
                        return 'Unesite prezime vlasnika kompanije';
                      }
                      return null;
                    },
                  ),
                  CupertinoTextFormFieldRow(
                    controller: _companyMobileController,
                    placeholder: 'Broj telefona kompanije',
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
                        return 'Unesite broj telefona kompanije';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CupertinoButton.filled(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signUpProcess(context);
                      }
                    },
                    child: Text('Registriraj tvrtku'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _emailValidation(String value) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (!emailValid) {
      return "Molim unesite važeću e-mail adresu";
    } else {
      return null;
    }
  }

  void _signUpProcess(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var validate = _formKey.currentState?.validate();
    requestModel.companyName = _companyNameController.text;
    requestModel.email = _companyEmailController.text;
    requestModel.address = _companyAddressController.text;
    requestModel.firstName = _ownerFirstNameController.text;
    requestModel.lastName = _ownerLastNameController.text;
    requestModel.phoneNumber = _companyMobileController.text;

    if (validate!) {
      var dataProvider = await authProvider.register(requestModel);
      if (dataProvider.success == true) {
        _companyNameController.clear();
        _companyEmailController.clear();
        _companyAddressController.clear();
        _ownerFirstNameController.clear();
        _ownerLastNameController.clear();
        _companyMobileController.clear();
        appMessages.showInformationMessage(
            context, 1, "Uspiješno dodan korisnik");
      } else {
        appMessages.showInformationMessage(
            context, 2, "Korisnik sa unesenim emailom već postoji");
      }
    }
  }
}
