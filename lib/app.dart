import 'package:flutter/material.dart';
import 'theme/app_colours.dart';
import 'screens/home_screen.dart';

class LastQuestionApp extends StatelessWidget {

    const LastQuestionApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Last Question',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                useMaterial3: true,
                fontFamily: 'Roboto',
                scaffoldBackgroundColor: AppColours.background,
            ),
            home: const HomeScreen(),
        );
    }

}