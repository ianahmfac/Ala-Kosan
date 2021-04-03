import 'package:ala_kosan/models/city.dart';
import 'package:ala_kosan/providers/kosan_provider.dart';
import 'package:ala_kosan/shared/themes.dart';
import 'package:ala_kosan/widgets/kosan_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CityListKos extends StatelessWidget {
  static const String routeName = "/city-list-kos";
  @override
  Widget build(BuildContext context) {
    final City city = ModalRoute.of(context).settings.arguments;
    final listKosan = context.read<KosanProvider>().getKosanByCity(city.id);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            brightness: Brightness.dark,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildCityImageHeader(city, context),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final kosan = listKosan[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, (index == 0) ? 16 : 8, 0, 0),
                  child: KosanItem(kosanItem: kosan),
                );
              },
              childCount: listKosan.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityImageHeader(City city, BuildContext context) {
    return Container(
      width: double.infinity,
      color: primaryColor,
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(city.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black87,
                Colors.transparent,
                Colors.black54,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city.city,
                style: contentTitle2(context).copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                city.desc,
                style: TextStyle(color: Colors.white, fontSize: 10),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
