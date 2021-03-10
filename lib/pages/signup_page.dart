import 'package:ala_kosan/helpers/constants.dart';
import 'package:ala_kosan/pages/image_pick_page.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/widgets/circle_icon_button.dart';
import 'package:ala_kosan/widgets/container_form.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = "/signup-page";
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
              child: CircleIconButton(),
            ),
            SizedBox(height: 32),
            Text(
              "Buat Akun Baru\nAla Kosan",
              style:
                  onBoardTitle(context).copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _nameKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _numberKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _confirmPasswordKey = GlobalKey<FormFieldState>();

  TextEditingController _passwordController = TextEditingController();

  bool _isSecure = true;
  bool _isConfirmSecure = true;
  String _email;
  String _name;
  String _number;
  String _password;

  void _signUp() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    print("$_email - $_name - ${_fullNumber(_number)} - $_password");
    Navigator.of(context).pushNamed(ImagePickPage.routeName, arguments: {
      "email": _email,
      "name": _name,
      "number": _fullNumber(_number),
      "password": _password,
    });
  }

  String _fullNumber(String number) {
    if (number.startsWith("0")) return "+62${number.replaceFirst("0", "")}";
    return "+62$number";
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
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
          SizedBox(height: 8),
          ContainerForm(
            text: "Nama Lengkap",
            child: TextFormField(
              key: _nameKey,
              style: contentBody(context).copyWith(fontSize: 14),
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Your Full Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: primaryColor.withOpacity(0.1),
              ),
              onChanged: (value) async {
                await Future.delayed(Duration(seconds: 1));
                _nameKey.currentState.validate();
              },
              onSaved: (newValue) => _name = newValue,
              validator: (value) {
                if (value.trim().isEmpty) return "Nama tidak boleh kosong";
                return null;
              },
            ),
          ),
          SizedBox(height: 8),
          ContainerForm(
            text: "Nomor HP",
            child: TextFormField(
              key: _numberKey,
              style: contentBody(context).copyWith(fontSize: 14),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Phone Number",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("+62"),
                ),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: primaryColor.withOpacity(0.1),
              ),
              onChanged: (value) async {
                await Future.delayed(Duration(seconds: 1));
                _numberKey.currentState.validate();
              },
              onSaved: (newValue) => _number = newValue,
              validator: (value) {
                if (value.trim().isEmpty) return "Nomor HP tidak boleh kosong";
                return null;
              },
            ),
          ),
          SizedBox(height: 8),
          ContainerForm(
            text: "Password",
            child: TextFormField(
              controller: _passwordController,
              key: _passwordKey,
              obscureText: _isSecure,
              style: contentBody(context).copyWith(fontSize: 14),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => node.nextFocus(),
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
                if (value.length <= 8)
                  return "Password setidaknya memiliki 8 karakter";
                return null;
              },
            ),
          ),
          SizedBox(height: 8),
          ContainerForm(
            text: "Konfirmasi Password",
            child: TextFormField(
              key: _confirmPasswordKey,
              obscureText: _isConfirmSecure,
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
                    _isConfirmSecure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmSecure = !_isConfirmSecure;
                    });
                  },
                ),
              ),
              onChanged: (value) async {
                await Future.delayed(Duration(seconds: 1));
                _confirmPasswordKey.currentState.validate();
              },
              validator: (value) {
                if (value.trim().isEmpty) return "Password tidak boleh kosong";
                if (value.length <= 8)
                  return "Password setidaknya memiliki 8 karakter";
                if (value != _passwordController.text)
                  return "Password tidak sama";
                return null;
              },
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _signUp,
              child: Text(
                "Continue",
                style: contentTitle(context).copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
