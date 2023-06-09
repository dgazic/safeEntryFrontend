import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:safe_entry/models/login_model.dart';
import 'package:safe_entry/providers/auth_provider.dart';
import 'package:safe_entry/resources/EnumUserRoles.dart';
import 'package:safe_entry/routes/routes_manager.dart';
import 'package:safe_entry/utils/color_utils.dart';
import 'package:safe_entry/utils/common_styles.dart';
import 'package:safe_entry/widgets/appMessages.dart';

class LogInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogInPageState();
  }
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.60,
                width: double.infinity,
                decoration: BoxDecoration(gradient: ColorUtils.appBarGradient),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Prijavi se",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 25),
                    ),
                    SizedBox(height: 30),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: LoginFormWidget())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginFormWidgetState();
  }
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  var _userEmailController = TextEditingController();
  var _userPasswordController = TextEditingController();
  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = true;
  bool _autoValidate = false;
  late LoginRequestModel requestModel;
  late LoginResponseModel responseModel;

  @override
  void initState() {
    super.initState();
    requestModel = LoginRequestModel();
    responseModel = LoginResponseModel();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget>[
          Card(
            elevation: 8,
            child: Column(
              children: <Widget>[
                _buildEmailField(context),
                _buildPasswordField(context),
                SizedBox(height: 20),
                _buildForgotPasswordWidget(context),
                _buildSignUpButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _passwordInputValidation(String value) {
    if (value.isEmpty) {
      return "Unesite lozinku";
    } else {
      return null;
    }
  }

  Widget _buildEmailField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _userEmailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          requestModel.email = _userEmailController.text;
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        validator: (value) => _emailValidation(value!),
        decoration: CommonStyles.textFormFieldStyle("Email", ""),
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

  Widget _buildPasswordField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _userPasswordController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          requestModel.password = _userPasswordController.text;
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
        validator: (value) => _passwordInputValidation(value!),
        obscureText: _isPasswordVisible,
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              }),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 190,
          height: 30,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: () {
                Get.toNamed(Routes.securityPage);
              },
              child: Text(
                'Zaboravljena lozinka?',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              )),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(
    BuildContext context,
  ) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          child: authProvider.loading
              ? CircularProgressIndicator(
                  color: Colors.amber,
                )
              : Text(
                  "Prijava",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
          onPressed: () {
            _signUpProcess(context);
          },
        ),
      ),
    );
  }

  void _signUpProcess(BuildContext context) async {
    AppMessages appMessages = AppMessages();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var validate = _formKey.currentState?.validate();
    requestModel.email = _userEmailController.text;
    requestModel.password = _userPasswordController.text;

    if (validate!) {
      var dataProvider = await authProvider.login(requestModel);
      if (dataProvider.success == true && dataProvider.token != "") {
        authProvider.setLoading(false);
        Map<String, dynamic> decodedToken =
            Jwt.parseJwt(dataProvider.token.toString());

        if (decodedToken["UserRoleId"] == EnumUserRole.Administrator) {
          Get.offAllNamed(Routes.administratorPage);
        }
        if (decodedToken["UserRoleId"] == EnumUserRole.SecurityCompany) {
          Get.offAllNamed(Routes.securityPage);
        }
        if (decodedToken["UserRoleId"] == EnumUserRole.OrganizerCompany) {
          Get.offAllNamed(Routes.organizerPage);
        }
      } else {
        appMessages.showInformationMessage(
            context, 2, "Pogrešno korisničko ime ili lozinka");
        _userPasswordController.clear();
        authProvider.setLoading(false);
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
