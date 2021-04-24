import 'package:ala_kosan/models/city.dart';
import 'package:ala_kosan/providers/city_provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataSearch extends SearchDelegate<City> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(EvaIcons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return resultCity(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    return resultCity(context);
  }

  Widget resultCity(BuildContext context) {
    final cities = Provider.of<CityProvider>(context, listen: false).cities;
    final suggestList = query.isEmpty
        ? cities
        : cities
            .where((element) =>
                element.city.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestList.length,
      itemBuilder: (BuildContext context, int index) {
        final city = suggestList[index];
        return ListTile(
          leading: Icon(EvaIcons.map),
          title: Text(city.city),
          onTap: () {
            close(context, city);
          },
        );
      },
    );
  }
}
