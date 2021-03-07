import 'package:ala_kosan/shared/themes.dart';
import 'package:flutter/material.dart';

class ContainerForm extends StatelessWidget {
  final String text;
  final TextFormField child;
  const ContainerForm({
    Key key,
    @required this.text,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            text,
            style: contentBody(context),
          ),
        ),
        child,
      ],
    );
  }
}
