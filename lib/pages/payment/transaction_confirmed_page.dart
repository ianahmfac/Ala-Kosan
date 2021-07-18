import 'package:ala_kosan/pages/wrapper.dart';
import 'package:flutter/material.dart';

class TransactionConfirmedPage extends StatelessWidget {
  static final String routeName = "/transaction-confirmed-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Transaksi Sewa Kosan Berhasil"),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Wrapper(),
              ));
            },
            child: Text("Kembali ke Halaman Utama"),
          ),
        ],
      ),
    );
  }
}
