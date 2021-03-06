import 'package:ala_kosan/shared/device.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/widgets/container_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Image.asset(
                "assets/images/gummy-bed.png",
                height: heightOfDevice(context) * 0.25,
                width: double.infinity,
              ),
            ),
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
  GlobalKey _formKey = GlobalKey<FormState>();
  GlobalKey _emailKey = GlobalKey<FormFieldState>();
  GlobalKey _passwordKey = GlobalKey<FormFieldState>();

  bool _isSecure = true;

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
                border: InputBorder.none,
              ),
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
                border: InputBorder.none,
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
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Sign In",
                style: contentTitle(context).copyWith(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
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
