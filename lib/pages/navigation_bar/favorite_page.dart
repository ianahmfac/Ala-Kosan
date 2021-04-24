import 'package:ala_kosan/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/kosan_provider.dart';
import '../../widgets/kosan_item.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kosanFavorites =
        Provider.of<KosanProvider>(context).getKosanFavorites();
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
        brightness: Brightness.dark,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<KosanProvider>(context, listen: false).getKosan(),
        child: kosanFavorites.isNotEmpty
            ? ListView.builder(
                itemCount: kosanFavorites.length,
                itemBuilder: (context, index) {
                  final kosanItem = kosanFavorites[index];
                  return KosanItem(kosanItem: kosanItem);
                },
              )
            : NoDataFound(message: "Tambahkan Kosan ke Daftar Favorit"),
      ),
    );
  }
}
