import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Life Expectancy Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const LifeExpectancyScreen(),
    );
  }
}

class LifeExpectancyScreen extends StatefulWidget {
  const LifeExpectancyScreen({super.key});

  @override
  State<LifeExpectancyScreen> createState() => LifeExpectancyScreenState();
}

class LifeExpectancyScreenState extends State<LifeExpectancyScreen> {
  // Declare and initialize the controllers for the input fields
  final TextEditingController _adultMortalityController = TextEditingController();
  final TextEditingController _schoolingController = TextEditingController();
  final TextEditingController _totalExpenditureController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();

  String _prediction = '';
  String _riskLevel = '';

  // Function to make prediction
  Future<void> _predictLifeExpectancy() async {
    // Get values from text controllers
    final double adultMortality = double.tryParse(_adultMortalityController.text) ?? 0.0;
    final double schooling = double.tryParse(_schoolingController.text) ?? 0.0;
    final double totalExpenditure = double.tryParse(_totalExpenditureController.text) ?? 0.0;
    final double bmi = double.tryParse(_bmiController.text) ?? 0.0;

    // Define the API URL
    final String apiUrl = 'https://uhai.onrender.com/predict/';

    // Send data to the API for prediction
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Adult_Mortality': adultMortality,
        'Schooling': schooling,
        'Total_expenditure': totalExpenditure,
        'BMI': bmi,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response data
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _prediction = data['prediction'].toString();
        _riskLevel = data['risk_level'];
      });
    } else {
      setState(() {
        _prediction = 'Error in prediction';
        _riskLevel = 'Unknown';
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _adultMortalityController.dispose();
    _schoolingController.dispose();
    _totalExpenditureController.dispose();
    _bmiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Expectancy Prediction'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              Center(
                child:               Container(
                  padding: EdgeInsets.all(16.0),
                  width: double.infinity,
                  color: Colors.deepOrange,

                  child: Column(
                    children: [
                      const Text(
                        'Prediction:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _prediction.isEmpty ? '' : _prediction,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _riskLevel.isEmpty ? '' : 'Risk Level: $_riskLevel',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Heading for form
              const Text(
                'Health-Related Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Adult Mortality input
              const Text('Adult Mortality'),
              TextField(
                controller: _adultMortalityController,
                decoration: const InputDecoration(
                  hintText: 'Enter Adult Mortality value',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              // Schooling input
              const Text('Schooling'),
              TextField(
                controller: _schoolingController,
                decoration: const InputDecoration(
                  hintText: 'Enter years of schooling',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              // Total Expenditure input
              const Text('Total Expenditure'),
              TextField(
                controller: _totalExpenditureController,
                decoration: const InputDecoration(
                  hintText: 'Enter total expenditure',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              // BMI input
              const Text('BMI'),
              TextField(
                controller: _bmiController,
                decoration: const InputDecoration(
                  hintText: 'Enter BMI',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              // Predict Button
              Center(
                child: ElevatedButton(
                  onPressed: _predictLifeExpectancy,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: const Text('Predict'),
                ),
              ),
              const SizedBox(height: 30),
              // Prediction Result Box

            ],
          ),
        ),
      ),
    );
  }
}
