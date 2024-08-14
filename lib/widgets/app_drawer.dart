import 'package:flutter/material.dart';
import 'package:my_to_do_app/helpers/app_route_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class AppDrawerWidget extends StatefulWidget {
  const AppDrawerWidget({super.key});

  @override
  State<AppDrawerWidget> createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;
    return Drawer(
      backgroundColor: extensionColor.groundPrimary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: extensionColor.groundSecondary,
            ),
            child: UserAccountsDrawerHeader(
              accountName: Text(
                'Malai Joti Adhikary',
                style: FontStyles.txtUbuntuBold.copyWith(
                  color: extensionColor.highEmphasize,
                  fontSize: 22,
                ),
              ),
              accountEmail: Text(
                'moloy.cse20@gmail.com',
                style: FontStyles.txtUbuntuSemiBold.copyWith(
                  color: extensionColor.highEmphasize,
                  fontSize: 18,
                ),
              ),
              decoration: BoxDecoration(
                color: extensionColor.groundSecondary,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouteHelper.home,
                (Route<dynamic> route) => false,
              );
            },
            iconColor: extensionColor.highEmphasize,
            textColor: extensionColor.highEmphasize,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Completed Tasks'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRouteHelper.completedTasks);
            },
            iconColor: extensionColor.highEmphasize,
            textColor: extensionColor.highEmphasize,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRouteHelper.setting);
            },
            iconColor: extensionColor.highEmphasize,
            textColor: extensionColor.highEmphasize,
          ),
        ],
      ),
    );
  }
}
