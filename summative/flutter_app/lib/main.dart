import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HeartDisease Risk App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const HealthcareRiskScreen(),
    );
  }
}

class HealthcareRiskScreen extends StatelessWidget {
  const HealthcareRiskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEART DISEASE RISKS'),
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
                child: Image.asset(
                  'assets/Medical.jpeg',
                  width: 700,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              // Heading for form
              const Text(
                'HEALTH-RELATED INFORMATION',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // BMI Dropdown
              const Text('BMI'),
              DropdownButtonFormField<String>(
                items: <String>['Overweight', 'Healthy weight', 'Underweight']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Select BMI category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Blood Pressure Dropdown
              const Text('Blood Pressure'),
              DropdownButtonFormField<String>(
                items: <String>['Yes', 'No']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'High Blood Pressure',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Gender Dropdown
              const Text('Sex'),
              DropdownButtonFormField<String>(
                items: <String>['Male', 'Female']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Select Gender',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Smoker Dropdown
              const Text('Smoker'),
              DropdownButtonFormField<String>(
                items: <String>['Frequent', 'Rarely', 'Never']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Smoking Frequency',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Predict Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Placeholder for prediction logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: const Text('Predict'),
                ),
              ),
              const SizedBox(height: 30),
              // Prediction Result Box
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                color: Colors.deepOrange,
                child: const Text(
                  'Prediction:\nYour Risk Score is:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
