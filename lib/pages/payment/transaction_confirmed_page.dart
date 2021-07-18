import 'package:flutter/material.dart';

class TransactionConfirmedPage extends StatelessWidget {
  static final String routeName = "/transaction-confirmed-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Transaksi Sewa Kosan Berhasil"),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/");
              },
              child: Text("Kembali ke Halaman Utama"),
            ),
          ],
        ),
      ),
    );
  }
}
