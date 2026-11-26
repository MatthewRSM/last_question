import 'package:flutter/material.dart';
import '../theme/app_colours.dart';
import '../theme/trivia_categories.dart';
import 'quiz_screen.dart';

class QuizSetupScreen extends StatefulWidget {
    const QuizSetupScreen({super.key});

    @override
    State<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {

    String selectedDifficulty = "Medium";
    String? selectedCategory;   

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
                                    child: Row(
                                        children: [
                                            // Navigation - Back Arrow
                                            IconButton(
                                                onPressed: () {
                                                    Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                    Icons.arrow_back,
                                                    color: AppColours.white,
                                                ),
                                            ),
                                            // Header Text
                                            const Expanded (
                                                child: Text(
                                                    'Quiz Setup',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: AppColours.white,
                                                        fontSize: 34,
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                            ),
                                            // Padding for Back Arrow
                                            const SizedBox(width: 48),
                                        ],
                                    ),
                                ),
                                // Spacing
                                const SizedBox(height: 40),

                                // Difficulty Selection
                                Padding (
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            // Label
                                            const Text(
                                                'SELECT DIFFICULTY',
                                                style: TextStyle(
                                                    color: AppColours.foreground,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                            // Spacing
                                            const SizedBox(height: 12),
                                            // Selector
                                            DropdownButtonFormField<String>(
                                                initialValue: selectedDifficulty,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: AppColours.foreground,
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                    ),
                                                ),
                                                dropdownColor: AppColours.foreground,
                                                style: const TextStyle(
                                                    color: AppColours.white,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                                iconEnabledColor: AppColours.white,
                                                items: ['Easy', 'Medium', 'Hard'].map((difficulty) {
                                                    return DropdownMenuItem(
                                                        value: difficulty,
                                                        child: Text(difficulty),
                                                    );
                                                }).toList(),
                                                onChanged: (value) {
                                                    if (value == null) return;
                                                    setState(() {
                                                        selectedDifficulty = value;
                                                    });
                                                },
                                            ),
                                        ],
                                    ),
                                ),
                                // Spacing
                                const SizedBox(height: 20),
                                // Category Selection
                                Padding (
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            // Label
                                            const Text(
                                                'SELECT A CATEGORY',
                                                style: TextStyle(
                                                    color: AppColours.foreground,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                            // Spacing
                                            const SizedBox(height: 12),
                                            // Selector
                                            DropdownButtonFormField<String>(
                                                initialValue: selectedCategory,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: AppColours.foreground,
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                    ),
                                                ),
                                                hint: const Text(
                                                    'Choose a category',
                                                    style: TextStyle(color: AppColours.white),
                                                ),
                                                dropdownColor: AppColours.foreground,
                                                style: const TextStyle(
                                                    color: AppColours.white,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                                iconEnabledColor: AppColours.white,
                                                items: TriviaCategories.categories.keys.map((category) {
                                                    return DropdownMenuItem(
                                                        value: category,
                                                        child: Text(category),
                                                    );
                                                }).toList(),
                                                onChanged: (value) {
                                                    if (value == null) return;
                                                    setState(() {
                                                        selectedCategory = value;
                                                    });
                                                },
                                            ),
                                        ],
                                    ),
                                ),
                                // Spacing
                                const SizedBox(height: 50),    
                                // Start Quiz Button
                                Padding (
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: 60,
                                        child: ElevatedButton(
                                            // Disable button if no category is selected
                                            onPressed: selectedCategory == null ? null : () {
                                                final categoryName = selectedCategory;
                                                if (categoryName == null) return;

                                                final categoryId = TriviaCategories.categories[categoryName]!;
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => QuizScreen(
                                                            difficulty: selectedDifficulty.toLowerCase(),
                                                            categoryId: categoryId,
                                                            categoryName: categoryName, 
                                                        ),
                                                    ),
                                                );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColours.white,
                                                foregroundColor: AppColours.foreground,
                                                disabledBackgroundColor: AppColours.white.withOpacity(0.5),
                                                disabledForegroundColor: AppColours.foreground.withOpacity(0.5),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                ),
                                                elevation: 0,
                                            ),
                                            child: const Text(
                                                'START QUIZ',
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