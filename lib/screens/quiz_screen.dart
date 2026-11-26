import 'package:flutter/material.dart';
import '../theme/app_colours.dart';
import '../data/trivia_question.dart';
import '../api/trivia_api.dart';
import 'dart:async';

class QuizScreen extends StatefulWidget {
    
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
    State<QuizScreen> createState() => _QuizScreenState();

}

class _QuizScreenState extends State<QuizScreen> {

    /*
     * Question variables and functions
     */

    final TriviaApi triviaApi = TriviaApi();
    bool isLoading = true;

    List<TriviaQuestion> questions = [];
    List<String> shuffledAnswers = [];

    // Calls API on page load
    @override
    void initState() {

        super.initState();
        startTimer();
        loadTriviaQuestions();

    }

    // Cancels timer on page close
    @override
    void dispose() {

        gameTimer?.cancel();
        super.dispose();

    }

    // Fetch trivia questions
    Future<void> loadTriviaQuestions() async {
        
        try {
            questions = await triviaApi.fetchTriviaQuestions(
                // Fetch 25 questions based on the selected difficulty and category
                amount: 25,
                difficulty: widget.difficulty.toLowerCase(),
                categoryId: widget.categoryId,
            );

            if (questions.isNotEmpty) {
                shuffleAnswers();
            }
        } catch (e) {
            print('Error loading questions: $e');
        } finally {
            setState(() {
                isLoading = false;
            });
        }

    }

    void shuffleAnswers() {
        shuffledAnswers = [questions[currentQuestionIndex].correctAnswer, ...questions[currentQuestionIndex].incorrectAnswers];
        shuffledAnswers.shuffle();
    }

    /*
     * Game state variables and functions
     */

    int score = 0;
    int currentQuestionIndex = 0;

    Timer? gameTimer;
    int remainingSeconds = 30;
    bool isGameOver = false;

    void startTimer() {

        gameTimer?.cancel();

        gameTimer = Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
                if (!mounted || isGameOver) {
                    timer.cancel();
                    return;
                }
                if (remainingSeconds <= 0) {
                    timer.cancel();
                    setState(() {
                        remainingSeconds = 0;
                        isGameOver = true;
                    });
                    showGameOverDialog();
                } 
                else {
                    setState(() {
                        remainingSeconds--;
                    });
                }
            }
        );

    }

    void showGameOverDialog() {
        
        gameTimer?.cancel();

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
                return AlertDialog(
                    title: const Text('Game Over!'),
                    content: Text('Final Score: $score'),
                    actions: [
                        TextButton(
                            onPressed: () {
                                Navigator.popUntil(
                                    context,
                                    (route) => route.isFirst,
                                );
                            },
                            child: const Text('Back to Home'),
                        ),
                    ],
                );
            },
        );

    }

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
                                            Text(
                                                'Question ${currentQuestionIndex + 1}',
                                                style: TextStyle(
                                                    color: AppColours.white,
                                                    fontSize: 34,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                            // Spacing
                                            const SizedBox(height: 10),
                                            // Display the question text or a loading indicator
                                            if (isLoading)
                                                const CircularProgressIndicator()
                                            else if (questions.isEmpty)
                                                const Text(
                                                    'Unable to load questions. Please try again.',
                                                    style: TextStyle(color: AppColours.white),
                                                )
                                            else
                                                Text(
                                                    questions[currentQuestionIndex].question,
                                                    style: const TextStyle(
                                                        color: AppColours.white,
                                                        fontSize: 14,
                                                    ),
                                                ),
                                        ],
                                    ),
                                ),
                                // Spacing
                                const SizedBox(height: 50),
                                // Display answer buttons or a loading indicator
                                if (isLoading)
                                    const CircularProgressIndicator()
                                else if (questions.isEmpty)
                                    const Text(
                                        'Unable to load questions. Please try again.',
                                        style: TextStyle(color: AppColours.white),
                                    )
                                else
                                    Column(
                                        children: shuffledAnswers.map((answer) {
                                            return Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                                                child: SizedBox(
                                                    width: double.infinity,
                                                    height: 60,
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                            // Correct answer
                                                            if (answer == questions[currentQuestionIndex].correctAnswer) {
                                                                setState(() {
                                                                    score++;
                                                                    currentQuestionIndex++;
                                                                    remainingSeconds = 30;
                                                                });
                                                                
                                                                shuffleAnswers();
                                                            }
                                                            // Game Over
                                                            else {
                                                                setState(() {
                                                                    isGameOver = true;
                                                                });

                                                                showGameOverDialog();
                                                            }
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: AppColours.white,
                                                            foregroundColor: AppColours.foreground,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15),
                                                            ),
                                                            elevation: 0,
                                                        ),  
                                                        child: Text(
                                                            answer,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                letterSpacing: 1,
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            );
                                        }).toList(),
                                    ),   
                                // Spacing
                                const SizedBox(height: 20),
                                // Score
                                Text (
                                    'Score: $score',
                                    style: const TextStyle(
                                        color: AppColours.foreground,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                // Spacing
                                const SizedBox(height: 20),
                                // Timer
                                Text (
                                    'Time Remaining: ${remainingSeconds}s',
                                    style: const TextStyle(
                                        color: AppColours.foreground,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
