import 'dart:developer';
import 'dart:io';

import 'package:euro/generated/l10n.dart';
import 'package:euro/screens/about_us/about_us_screen.dart';
import 'package:euro/screens/map/map_screen.dart';
import 'package:euro/screens/profile/profile_screen.dart';
import 'package:euro/screens/services/widgets/service_drawe_item.dart';
import 'package:euro/screens/terms_of_use/terms_of_use_screen.dart';
import 'package:euro/screens/welcome/welcome_screen.dart';
import 'package:euro/utils/app_colors.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:euro/utils/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ServiceDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ServiceDrawer({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      right: true,
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: AppColors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      HiveUtils.getUser?.name ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ServiceDrawerItem(
                      icon: Icons.settings,
                      text: S
                          .of(context)
                          .services,
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const WelcomeScreen()),
                                (route) => false);
                      },
                    ),
                    ServiceDrawerItem(
                      icon: Icons.account_circle,
                      text: S
                          .of(context)
                          .profile,
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfileScreen()));
                      },
                    ),
                    ServiceDrawerItem(
                      icon: Icons.task,
                      text: S
                          .of(context)
                          .requestAssistance,
                      onTap: () async {
                        try {
                          await LocationHelper.determinePosition()
                              .then((location) =>
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MapScreen(
                                      location: LatLng(location.latitude,
                                          location.longitude),
                                    ),
                              ),
                            )
                          });
                        } catch (e) {
                          log("$e");
                        }
                      },
                    ),
                    ServiceDrawerItem(
                      icon: Icons.task,
                      text: S
                          .of(context)
                          .requestAMembership,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfileScreen()));
                      },
                    ),
                    ServiceDrawerItem(
                      text: S
                          .of(context)
                          .aboutUs,
                      icon: Icons.people,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AboutUsScreen()));
                      },
                    ),
                    ServiceDrawerItem(
                      text: S
                          .of(context)
                          .termsOfUse,
                      icon: Icons.task,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TermsOfUseScreen()));
                      },
                    ),
                    ServiceDrawerItem(
                      text: S
                          .of(context)
                          .share,
                      icon: Icons.share,
                      onTap: () {
                        Share.share(Platform.isAndroid
                            ? "https://play.google.com/store/apps/details?id=com.euroclub.rescue"
                            : "https://apps.apple.com/app/id1228959878");
                      },
                    ),
                    if (HiveUtils.getUser != null)
                      ServiceDrawerItem(
                        text: S
                            .of(context)
                            .logOut,
                        icon: Icons.logout,
                        onTap: () {
                          HiveUtils.deleteUser();
                          scaffoldKey.currentState!.closeDrawer();
                        },
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
