import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/widgets/kosan_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListKos extends StatelessWidget {
  static const String routeName = "/list-kos";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Kosan"),
        brightness: Brightness.dark,
      ),
      body: Consumer<KosanProvider>(builder: (context, kosanProvider, _) {
        final kosanItem = kosanProvider.listOfKosan;
        return RefreshIndicator(
          onRefresh: () =>
              Provider.of<KosanProvider>(context, listen: false).getKosan(),
          child: ListView.builder(
            itemCount: kosanItem.length,
            itemBuilder: (BuildContext context, int index) {
              final kosan = kosanItem[index];
              return KosanItem(kosanItem: kosan);
            },
          ),
        );
      }),
    );
  }
}
