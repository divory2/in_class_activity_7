import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Manage current theme mode.
  ThemeMode _themeMode = ThemeMode.system;
  // Default color.
  Color selectedColor = Colors.blue;

  // Toggle theme.
  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  // Show color picker dialog, accepts a BuildContext.
  void showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (Color color) {
              setState(() {
                selectedColor = color;
              });
            },
            labelTypes: const [
              ColorLabelType.rgb,
              ColorLabelType.hsv,
              ColorLabelType.hsl
            ],
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Light theme.
      theme: ThemeData.light(),
      // Dark theme.
      darkTheme: ThemeData.dark(),
      // Apply theme.
      themeMode: _themeMode,
      // Use a Builder to obtain a BuildContext that is below MaterialApp.
      home: Builder(
        builder: (context) => FadingTextAnimation(
          toggleTheme: _toggleTheme,
          showColorPicker: () => showColorPicker(context),
          selectedColor: selectedColor,
        ),
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final VoidCallback toggleTheme;
  final VoidCallback showColorPicker;
  final Color selectedColor;

  FadingTextAnimation({
    required this.toggleTheme,
    required this.showColorPicker,
    required this.selectedColor,
  });

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check current brightness to choose icon.
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.sunny : Icons.mode_night),
            onPressed: widget.toggleTheme,
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: widget.showColorPicker,
          ),
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(
              fontSize: 24,
              color: widget.selectedColor,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
