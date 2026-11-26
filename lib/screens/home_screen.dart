import 'package:flutter/material.dart';
import '../theme/app_colours.dart';
import 'quiz_setup_screen.dart';

class HomeScreen extends StatelessWidget {
    
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppColours.background,
            body: SafeArea(
                child: Stack(
                    children: [
                        Column(
                            children: [
                                // Header
                                Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 35,
                                        horizontal: 20,
                                    ),
                                    decoration: const BoxDecoration(
                                        color: AppColours.foreground,
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(30),
                                        ),
                                    ),
                                    child: Column(
                                        children: [
                                            const Text(
                                                'Last Question',
                                                style: TextStyle(
                                                    color: AppColours.white,
                                                    fontSize: 34,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                            // Spacing
                                            const SizedBox(height: 10),
                                            const Text(
                                                'How long can you survive?',
                                                style: TextStyle(
                                                    color: AppColours.white,
                                                    fontSize: 16,
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                                // Spacing
                                const SizedBox(height: 50),
                                // Setup Quiz Button
                                Padding (
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: 60,
                                        child: ElevatedButton(
                                            onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => QuizSetupScreen(),    
                                                    ),
                                                );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColours.white,
                                                foregroundColor: AppColours.foreground,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                ),
                                                elevation: 0,
                                            ),
                                            child: const Text(
                                                'SETUP QUIZ',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                ),
                                            ),
                                        ),
                                    ),
                                ),
                                // Spacing
                                const SizedBox(height: 15),
                                // Leaderboard Button
                                Padding (
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: 60,
                                        child: ElevatedButton(
                                            onPressed: null,
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColours.foreground,
                                                foregroundColor: AppColours.white,
                                                disabledBackgroundColor: AppColours.foreground.withOpacity(0.5),
                                                disabledForegroundColor: AppColours.white.withOpacity(0.5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                ),
                                                elevation: 0,
                                            ),
                                            child: const Text(
                                                'LEADERBOARD',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                ),
                                            ),
                                        ),
                                    ),
                                ),
                            ],
                        ),
                    ],
                ),
            ),
        );
    }
}