import 'dart:io';

import 'package:ala_kosan/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageChooser extends StatefulWidget {
  final Function getImagePicked;

  const ImageChooser({Key key, @required this.getImagePicked})
      : super(key: key);
  @override
  _ImageChooserState createState() => _ImageChooserState();
}

class _ImageChooserState extends State<ImageChooser> {
  File _imageFile;

  void _selectAction() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Pilih Aksi",
                    style: contentTitle(context),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Ambil dengan Kamera"),
                onTap: () {
                  _pickImage();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text("Pilih Melalui Galeri"),
                onTap: () {
                  _pickImage(false);
                  Navigator.of(context).pop();
                },
              ),
              _imageFile != null
                  ? ListTile(
                      leading: Icon(Icons.delete),
                      title: Text("Hapus Foto"),
                      onTap: () {
                        setState(() {
                          _imageFile = null;
                          Navigator.of(context).pop();
                        });
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage([bool isFromCamera = true]) async {
    ImagePicker pick = ImagePicker();
    PickedFile pickedFile = await pick.getImage(
        source: isFromCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.getImagePicked(_imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectAction,
      child: CircleAvatar(
        backgroundColor: primaryColor,
        radius: 100,
        backgroundImage: (_imageFile != null) ? FileImage(_imageFile) : null,
        child: _imageFile != null
            ? null
            : Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 100,
              ),
      ),
    );
  }
}
