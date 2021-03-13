import 'package:ala_kosan/helpers/constants.dart';
import 'package:ala_kosan/pages/auth/signup_page.dart';
import 'package:ala_kosan/services/auth_service.dart';
import 'package:ala_kosan/shared/device.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/widgets/container_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              bottom: false,
              child: Image.asset(
                "assets/images/gummy-bed.png",
                height: heightOfDevice(context) * 0.25,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 32),
            Text(
              "Masuk",
              style: contentTitle2(context),
            ),
            SizedBox(height: 16),
            SignInForm(),
          ],
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  String _email;
  String _password;

  bool _isSecure = true;
  bool _isLoading = false;

  void _signIn() async {
    FocusManager.instance.primaryFocus.unfocus();
    setState(() {
      _isLoading = true;
    });
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    try {
      await AuthService.signInWithEmail(_email, _password);
    } catch (e) {
      showSnackbarError(context, e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ContainerForm(
            text: "Email",
            child: TextFormField(
              key: _emailKey,
              style: contentBody(context).copyWith(fontSize: 14),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Your Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: primaryColor.withOpacity(0.1),
              ),
              onChanged: (value) async {
                await Future.delayed(Duration(seconds: 1));
                _emailKey.currentState.validate();
              },
              onSaved: (newValue) => _email = newValue,
              validator: (value) {
                if (value.trim().isEmpty) return "Email tidak boleh kosong";
                if (!Constants.isValidEmail(value))
                  return "Format email tidak valid";
                return null;
              },
            ),
          ),
          SizedBox(height: 12),
          ContainerForm(
            text: "Password",
            child: TextFormField(
              key: _passwordKey,
              obscureText: _isSecure,
              style: contentBody(context).copyWith(fontSize: 14),
              textInputAction: TextInputAction.done,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                hintText: "Your Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                fillColor: primaryColor.withOpacity(0.1),
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isSecure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isSecure = !_isSecure;
                    });
                  },
                ),
              ),
              onChanged: (value) async {
                await Future.delayed(Duration(seconds: 1));
                _passwordKey.currentState.validate();
              },
              onSaved: (newValue) => _password = newValue,
              validator: (value) {
                if (value.trim().isEmpty) return "Password tidak boleh kosong";
                if (value.length < 8)
                  return "Password setidaknya memiliki 8 karakter";
                return null;
              },
            ),
          ),
          SizedBox(height: 32),
          (_isLoading)
              ? Center(
                  child: SpinKitFadingCircle(
                    color: accentColor,
                    size: 50,
                  ),
                )
              : SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signIn,
                    child: Text(
                      "Sign In",
                      style:
                          contentTitle(context).copyWith(color: Colors.white),
                    ),
                  ),
                ),
          SizedBox(height: 16),
          if (!_isLoading)
            SizedBox(
              height: 50,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, SignUpPage.routeName),
                child: Text(
                  "Create Account",
                  style: contentTitle(context).copyWith(color: primaryColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
