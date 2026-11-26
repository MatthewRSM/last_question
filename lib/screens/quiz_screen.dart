import 'package:flutter/material.dart';
import '../theme/app_colours.dart';
import '../theme/trivia_categories.dart';

class QuizScreen extends StatelessWidget {
    
    const QuizScreen({
        super.key,
        required this.difficulty,
        required this.categoryId,
        required this.categoryName,
    });

    final String difficulty;
    final int categoryId;
    final String categoryName;

    @override
    Widget build(BuildContext context) {
        return const Scaffold(
            body: SizedBox(),
        );
    }
}

