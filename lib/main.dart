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
  bool _showFrame = true;
  double _rotationTurns = 0;
  String _displayText = "Hello, Flutter!";

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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated text with a fading effect.
                AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  child: Text(
                    _displayText,
                    style: TextStyle(
                      fontSize: 24,
                      color: widget.selectedColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: toggleVisibility,
                  child: Text('Toggle Text Visibility'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _displayText = _displayText == 'Hello, Flutter!'
                          ? 'Welcome to Flutter!'
                          : 'Hello, Flutter!';
                    });
                  },
                  child: Text('Change Text'),
                ),
                SizedBox(height: 40),
                // Toggle switch to enable/disable image frame.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show Frame'),
                    Switch(
                      value: _showFrame,
                      onChanged: (value) {
                        setState(() {
                          _showFrame = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Rotating image with rounded corners.
                AnimatedRotation(
                  turns: _rotationTurns,
                  duration: Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: _showFrame
                          ? BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                            )
                          : null,
                      child: Image.asset(
                        'assets/images/image2.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _rotationTurns += 0.25; // Rotates 90° per tap.
                    });
                  },
                  child: Text('Rotate Image'),
                ),
              ],
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