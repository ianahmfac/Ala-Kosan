import 'package:ala_kosan/models/kosan.dart';
import 'package:ala_kosan/services/auth_service.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteIconButton extends StatelessWidget {
  final Kosan kosan;
  final double size;
  final Color color;

  const FavoriteIconButton(
      {Key key, this.kosan, this.size = 24, this.color = Colors.white})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: kosan,
      child: _FavoriteButton(
        size: size,
        color: color,
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final double size;
  final Color color;

  const _FavoriteButton({Key key, this.size, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final kos = Provider.of<Kosan>(context);
    return IconButton(
      padding: const EdgeInsets.all(16),
      iconSize: size,
      color: color,
      icon: Icon(
        kos.isFavorite ? EvaIcons.heart : EvaIcons.heartOutline,
      ),
      onPressed: () {
        kos.setFavorite(AuthService.currentUid);
      },
    );
  }
}
