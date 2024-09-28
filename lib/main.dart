import 'package:flutter/material.dart';

void main() => runApp( const TemperatureConverterApp());

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Blue theme for the app
        scaffoldBackgroundColor: Colors.white, // White background
      ),
      home: const TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String _selectedConversion = 'Fahrenheit to Celsius';
  final TextEditingController _inputController = TextEditingController();
  String _convertedValue = '';
  final List<String> _conversionHistory = [];

  // Function to convert temperatures
  void _convertTemperature() {
    setState(() {
      double inputTemp = double.tryParse(_inputController.text) ?? 0;
      double result;

      if (_selectedConversion == 'Fahrenheit to Celsius') {
        result = (inputTemp - 32) * 5 / 9;
        _convertedValue = '${inputTemp.toStringAsFixed(1)} °F = ${result.toStringAsFixed(2)} °C';
      } else {
        result = (inputTemp * 9 / 5) + 32;
        _convertedValue = '${inputTemp.toStringAsFixed(1)} °C = ${result.toStringAsFixed(2)} °F';
      }

      _conversionHistory.insert(0, _convertedValue); // Add to history at the top
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter'),
        backgroundColor: Colors.blue, // Blue header
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Conversion options
                const Text(
                  'Conversion:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text('Fahrenheit to Celsius'),
                        leading: Radio<String>(
                          value: 'Fahrenheit to Celsius',
                          groupValue: _selectedConversion,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedConversion = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Celsius to Fahrenheit'),
                        leading: Radio<String>(
                          value: 'Celsius to Fahrenheit',
                          groupValue: _selectedConversion,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedConversion = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Input field
                TextField(
                  controller: _inputController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter temperature',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Change to your desired color
                        width: 2.0, // Adjust the thickness
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),

                const SizedBox(height: 10),

                // Convert button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Use 'const'
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: _convertTemperature,
                    child: const Text('CONVERT'),
                  ),
                ),
                const SizedBox(height: 20),


                // Display converted value
                Text(
                  'Converted Value: $_convertedValue',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // History
                const Text(
                  'History:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _conversionHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_conversionHistory[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
