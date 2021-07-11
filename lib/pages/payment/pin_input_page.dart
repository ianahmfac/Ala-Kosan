import 'package:ala_kosan/helpers/text_encrypter.dart';
import 'package:ala_kosan/models/transaction.dart';
import 'package:ala_kosan/providers/user_provider.dart';
import 'package:ala_kosan/shared/platform_alert_dialog.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class PinInputPage extends StatefulWidget {
  static String routeName = "/pin-input-page";

  @override
  _PinInputPageState createState() => _PinInputPageState();
}

class _PinInputPageState extends State<PinInputPage> {
  final _formKey = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  Transaction _transaction;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _transaction = ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Input Your PIN",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(40.0),
            child: FractionallySizedBox(
              heightFactor: 1.0,
              child: Center(
                child: onlySelectedBorderPinPut(),
              ),
            ),
          ),
          _bottomAppBar,
        ],
      ),
    );
  }

  Widget onlySelectedBorderPinPut() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(5.0),
    );
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onLongPress: () {
              print(_formKey.currentState.validate());
            },
            child: PinPut(
              validator: (s) {
                if (s.contains('1')) return null;
                return 'NOT VALID';
              },
              useNativeKeyboard: false,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              withCursor: true,
              fieldsCount: 6,
              obscureText: "●",
              fieldsAlignment: MainAxisAlignment.spaceAround,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
              eachFieldMargin: EdgeInsets.all(0),
              eachFieldWidth: 45.0,
              eachFieldHeight: 55.0,
              onSubmit: (String pin) => _submitTransaction(pin),
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration.copyWith(
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: const Color.fromRGBO(160, 215, 220, 1),
                ),
              ),
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.scale,
            ),
          ),
          SizedBox(height: 30),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(30),
            physics: NeverScrollableScrollPhysics(),
            children: [
              ...[1, 2, 3, 4, 5, 6, 7, 8, 9, '', 0].map((e) {
                if (e == '') return Container();
                return RoundedButton(
                  title: '$e',
                  onTap: () {
                    _pinPutController.text = '${_pinPutController.text}$e';
                  },
                );
              }),
              RoundedButton(
                title: '←',
                onTap: () {
                  if (_pinPutController.text.isNotEmpty) {
                    _pinPutController.text = _pinPutController.text
                        .substring(0, _pinPutController.text.length - 1);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _bottomAppBar {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: null,
              child: Text(
                'Total Bayar: ${convertCurrency(_transaction.totalPrice)}',
              ),
            ),
            TextButton(
              onPressed: () => _pinPutController.text = '',
              child: const Text('Clear All'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitTransaction(String pin) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final encryptedPin = TextEncrypter.encryptText(pin);
    if (user.balance >= _transaction.totalPrice) {
      if (user.pin == encryptedPin) {
        final newTransaction = _transaction.copyWith(
          id: "AlaKosan-${DateTime.now()}",
          createdAt: DateTime.now(),
        );
      } else {
        PlatformAlertDialog(
          titleText: 'Transaksi Gagal',
          contentText: 'Pin kamu salah nih. Masukkan pin yang benar.',
          buttonDialogText: 'OK',
        ).show(context);
      }
    } else {
      await PlatformAlertDialog(
        titleText: 'Transaksi Gagal',
        contentText: 'Saldo kamu tidak cukup nih, yuk isi saldo kamu.',
        buttonDialogText: 'OK',
      ).show(context);
      Navigator.of(context).pop();
    }
  }
}

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  RoundedButton({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor,
        ),
        alignment: Alignment.center,
        child: Text(
          '$title',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
