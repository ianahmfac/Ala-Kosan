import 'dart:io';

import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/widgets/circle_icon_button.dart';
import 'package:ala_kosan/widgets/image_chooser.dart';
import 'package:flutter/material.dart';

class ImagePickPage extends StatefulWidget {
  static const String routeName = "/image-pick-page";

  @override
  _ImagePickPageState createState() => _ImagePickPageState();
}

class _ImagePickPageState extends State<ImagePickPage> {
  Map<String, Object> _dataSignUp;
  File _imageProfile;

  void _getImagePicked(File image) {
    _imageProfile = image;
  }

  void _signUp() async {
    String image = _imageProfile != null ? _imageProfile.path : "null";
    print(_dataSignUp.toString() + " - " + image);
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
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _signUp,
                child: Text(
                  "Setup New Account",
                  style: contentTitle(context).copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
