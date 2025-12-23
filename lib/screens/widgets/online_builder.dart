import 'package:euro/screens/widgets/offline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class OnlineBuilder extends StatelessWidget {
  final Widget onlineWidget;

  const OnlineBuilder({super.key, required this.onlineWidget});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget child,
      ) {
        final bool connected = connectivity.first != ConnectivityResult.none;
        if (connected) {
          return onlineWidget;
        } else {
          return const OfflineScreen();
        }
      },
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
