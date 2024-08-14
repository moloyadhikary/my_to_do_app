import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_to_do_app/features/setting/bloc/setting_bloc.dart';
import 'package:my_to_do_app/helpers/enum_helper.dart';
import 'package:my_to_do_app/styles/font_styles.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  // static Widget builder(BuildContext context) {
  //   return BlocProvider(
  //     create: (context) => SettingBloc()..add(const OnLoadPage()),
  //     child: const SettingPage(),
  //   );
  // }

  static Widget builder(BuildContext context) {
    return const SettingPage();
  }

  @override
  Widget build(BuildContext context) {
    final extensionColor = Theme.of(context).extension<AppThemeProvider>()!;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return const Center(child: CircularProgressIndicator());
      },
      overlayWholeScreen: true,
      overlayColor: Colors.black.withOpacity(0.8),
      child: Scaffold(
        backgroundColor: extensionColor.groundPrimary,
        appBar: AppBar(
          backgroundColor: extensionColor.groundSecondary,
          centerTitle: true,
          title: Text(
            'My To Do App',
            style: FontStyles.txtLatoBold.copyWith(
              color: extensionColor.highEmphasize,
            ),
          ),
          foregroundColor: extensionColor.highEmphasize,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<SettingBloc, SettingState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dark Mode',
                          style: FontStyles.txtUbuntuBold.copyWith(
                            color: extensionColor.highEmphasize,
                            fontSize: 18,
                          ),
                        ),
                        CupertinoSwitch(
                          activeColor: Colors.green,
                          value: state.themeType == ThemeType.dark,
                          onChanged: (value) {
                            BlocProvider.of<SettingBloc>(context).add(
                              OnTapThemeSwitch(
                                themeType:
                                    value ? ThemeType.dark : ThemeType.light,
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
