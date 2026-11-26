import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import '../data/trivia_question.dart';

class TriviaApi {

    static const String _baseUrl = 'https://opentdb.com/api.php';

    Future<List<TriviaQuestion>> fetchTriviaQuestions({
        required int amount,
        required String difficulty,
        required int categoryId,
    }) async {
        
        // Make an HTTP GET request to the trivia API with the specified parameters
        final response = await http.get(Uri.parse('$_baseUrl?amount=$amount&difficulty=$difficulty&category=$categoryId&type=multiple'));

        // Success
        if (response.statusCode == 200) {

            final data = jsonDecode(response.body);
            final List<dynamic> results = data['results'];

            // Maps the JSON data to a list of TriviaQuestion objects
            return results.map((questionData) {
                return TriviaQuestion(
                    question: decodeHtml(questionData['question']),
                    correctAnswer: decodeHtml(questionData['correct_answer']),
                    incorrectAnswers: List<String>.from(questionData['incorrect_answers']).map(decodeHtml).toList(),
                );
            }).toList();

        } else {
            throw Exception('Failed to load trivia questions');
        }
    }
    
    // Decodes HTML in strings returned by the API
    String decodeHtml(String text) {
        return parse(text).documentElement!.text;
    }

}
