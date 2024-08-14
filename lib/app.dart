import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_to_do_app/features/setting/bloc/setting_bloc.dart';
import 'package:my_to_do_app/helpers/app_route_helper.dart';
import 'package:my_to_do_app/helpers/theme_helper.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingBloc()..add(const OnLoadPage()),
        ),
      ],
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          return MaterialApp(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            theme: ThemeHelper.getThemeData(state.themeType),
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouteHelper.initialRoute,
            routes: AppRouteHelper.routes,
          );
        },
      ),
    );
  }
}
