import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_push_jeleapps/api/firebase_api.dart';
import 'package:test_push_jeleapps/bloc/notification_bloc/notification_bloc.dart';
import 'package:test_push_jeleapps/bloc/theme_cubit/theme_cubit.dart';
import 'package:test_push_jeleapps/data/repository/notification_repo.dart';
import 'package:test_push_jeleapps/firebase_options.dart';
import 'package:test_push_jeleapps/presentation/routes/routes.dart';
import 'package:test_push_jeleapps/presentation/screens/home_screen.dart';
import 'package:test_push_jeleapps/presentation/style/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Ensure that Firebase Messaging instance is initialized
  await FirebaseMessaging.instance.getToken();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(
            notificationRepo: NotificationRepo(),
            firebaseMessagingApi: FirebaseMessagingApi(),
          ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return AnimatedSwitcher(
            duration:
                const Duration(milliseconds: 500), // Adjust duration as needed
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: MaterialApp(
              key: ValueKey(themeMode),
              themeMode: themeMode,
              theme: AppTheme.lightTheme, // Light theme
              darkTheme: AppTheme.darkTheme, // Dark theme
              onGenerateRoute: AppRoutes.generateRoute,
              initialRoute: AppRoutes.home,
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
