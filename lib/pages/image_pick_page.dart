import 'dart:io';

import 'package:ala_kosan/pages/home_page.dart';
import 'package:ala_kosan/services/auth_service.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/widgets/circle_icon_button.dart';
import 'package:ala_kosan/widgets/image_chooser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImagePickPage extends StatefulWidget {
  static const String routeName = "/image-pick-page";

  @override
  _ImagePickPageState createState() => _ImagePickPageState();
}

class _ImagePickPageState extends State<ImagePickPage> {
  Map<String, Object> _dataSignUp;
  File _imageProfile;
  bool _isLoading = false;

  void _getImagePicked(File image) {
    _imageProfile = image;
  }

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    String image = _imageProfile != null ? _imageProfile.path : "";
    try {
      await AuthService.signUp(_dataSignUp["email"], _dataSignUp["password"]);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      showSnackbarError(context, e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    _dataSignUp = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              bottom: false,
              child: CircleIconButton(),
            ),
            SizedBox(height: 32),
            RichText(
              text: TextSpan(
                text: "Upload Foto Profil,\n",
                style: onBoardTitle(context),
                children: [
                  TextSpan(
                    text: _dataSignUp["name"],
                    style: onBoardTitle(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: ImageChooser(getImagePicked: _getImagePicked),
              ),
            ),
            _isLoading
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
                      onPressed: _signUp,
                      child: Text(
                        "Setup New Account",
                        style:
                            contentTitle(context).copyWith(color: Colors.white),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
