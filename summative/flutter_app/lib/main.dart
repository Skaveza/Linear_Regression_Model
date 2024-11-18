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
  final _formKey = GlobalKey<FormState>();

  // Declare and initialize the controllers for the input fields
  final TextEditingController _adultMortalityController = TextEditingController();
  final TextEditingController _schoolingController = TextEditingController();
  final TextEditingController _totalExpenditureController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();

  String _prediction = '';
  String _lifeexpectancy = '';

  // Function to make prediction
  Future<void> _predictLifeExpectancy() async {
    final double adultMortality = double.tryParse(_adultMortalityController.text) ?? 0.0;
    final double schooling = double.tryParse(_schoolingController.text) ?? 0.0;
    final double totalExpenditure = double.tryParse(_totalExpenditureController.text) ?? 0.0;
    final double bmi = double.tryParse(_bmiController.text) ?? 0.0;

    final String apiUrl = 'https://uhai.onrender.com/predict/';

    try {
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
        print(response.body); // Debugging line
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _prediction = (data['prediction'] ?? 'No prediction').toString();
          _lifeexpectancy = data['life_expectancy'] ?? 'Unknown';
        });
      } else {
        print('Error: ${response.statusCode}, ${response.body}'); // Debugging line
        setState(() {
          _prediction = 'Error in prediction';
          _lifeexpectancy = 'Unknown';
        });
      }
    } catch (e) {
      print('Exception: $e'); // Debugging line
      setState(() {
        _prediction = 'An error occurred';
        _lifeexpectancy = 'Unknown';
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display results
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
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
                          _lifeexpectancy.isEmpty ? '' : 'Life Expectancy: $_lifeexpectancy',
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
                TextFormField(
                  controller: _adultMortalityController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Adult Mortality (73 - 723)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final double? mortality = double.tryParse(value ?? '');
                    if (mortality == null || mortality < 73 || mortality > 723) {
                      return 'Please enter a value between 73 and 723';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Schooling input
                const Text('Schooling'),
                TextFormField(
                  controller: _schoolingController,
                  decoration: const InputDecoration(
                    hintText: 'Enter years of schooling (9.2 - 10.1)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final double? schooling = double.tryParse(value ?? '');
                    if (schooling == null || schooling < 9.2 || schooling > 10.1) {
                      return 'Please enter a value between 9.2 and 10.1';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Total Expenditure input
                const Text('Total Expenditure'),
                TextFormField(
                  controller: _totalExpenditureController,
                  decoration: const InputDecoration(
                    hintText: 'Enter total expenditure (6.16 - 8.52)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final double? expenditure = double.tryParse(value ?? '');
                    if (expenditure == null || expenditure < 6.16 || expenditure > 8.52) {
                      return 'Please enter a value between 6.16 and 8.52';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // BMI input
                const Text('BMI'),
                TextFormField(
                  controller: _bmiController,
                  decoration: const InputDecoration(
                    hintText: 'Enter BMI (17.2 - 27.1)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final double? bmi = double.tryParse(value ?? '');
                    if (bmi == null || bmi < 17.2 || bmi > 27.1) {
                      return 'Please enter a value between 17.2 and 27.1';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Predict Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _predictLifeExpectancy();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please correct the errors in the form'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    child: const Text('Predict'),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
