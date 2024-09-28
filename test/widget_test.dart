import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:temperature_conversion_app/main.dart'; // Make sure this matches your app file

void main() {
  testWidgets('Temperature conversion test', (WidgetTester tester) async {
    // Build the temperature converter app and trigger a frame.
    await tester.pumpWidget(const TemperatureConverterApp());

    // Verify that the initial screen displays the correct conversion options and no result.
    expect(find.text('Fahrenheit to Celsius'), findsOneWidget);
    expect(find.text('Celsius to Fahrenheit'), findsOneWidget);
    expect(find.text('Converted Value:'), findsOneWidget);

    // Enter a temperature value into the text field.
    await tester.enterText(find.byType(TextField), '32');

    // Tap the convert button.
    await tester.tap(find.text('Convert'));
    await tester.pump(); // Trigger the conversion.

    // Verify the conversion result.
    expect(find.text('32.0 °F = 0.00 °C'), findsOneWidget);

    // Check that the history is updated.
    expect(find.text('32.0 °F = 0.00 °C'), findsOneWidget);

    // Now select Celsius to Fahrenheit.
    await tester.tap(find.text('Fahrenheit to Celsius')); // Tap to open dropdown.
    await tester.pumpAndSettle(); // Wait for dropdown animation.

    await tester.tap(find.text('Celsius to Fahrenheit').last); // Select conversion.
    await tester.pumpAndSettle(); // Wait for the dropdown to close.

    // Enter a new temperature value into the text field.
    await tester.enterText(find.byType(TextField), '100');

    // Tap the convert button again.
    await tester.tap(find.text('Convert'));
    await tester.pump(); // Trigger the conversion.

    // Verify the new conversion result.
    expect(find.text('100.0 °C = 212.00 °F'), findsOneWidget);

    // Verify the history now contains both conversions.
    expect(find.text('32.0 °F = 0.00 °C'), findsOneWidget);
    expect(find.text('100.0 °C = 212.00 °F'), findsOneWidget);
  });
}
