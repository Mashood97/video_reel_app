import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_reel_app/features/reels/presentation/pages/reel_video_page.dart';
import 'package:video_reel_app/l10n/l10n.dart';
import 'package:video_reel_app/utils/dependency_injection/di_container.dart';
import 'package:video_reel_app/utils/internet_checker/network_bloc.dart';
import 'package:video_reel_app/utils/internet_checker/network_event.dart';
import 'package:video_reel_app/utils/theme/cubit/cubit/theme_cubit.dart';

final internetConnection = getItInstance.get<NetworkBloc>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ThemeCubit themeCubit;

  @override
  void initState() {
    super.initState();
    themeCubit = getItInstance.get<ThemeCubit>();
    internetConnection.add(const NetworkObserve());
  }

  @override
  void dispose() {
    themeCubit.close();
    internetConnection.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: themeCubit,
        ),
        BlocProvider.value(
          value: internetConnection,
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: state.lightTheme,
            darkTheme: state.darkTheme,
            home: const ReelVideoPage(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
