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
  ThemeMode _themeMode = ThemeMode.system;
  Color selectedColor = Colors.blue;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomePage(
        toggleTheme: _toggleTheme,
        showColorPicker: () => showColorPicker,
        selectedColor: selectedColor,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final VoidCallback showColorPicker;
  final Color selectedColor;

  HomePage({
    required this.toggleTheme,
    required this.showColorPicker,
    required this.selectedColor,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe Between Pages'),
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
      body: PageView(
        controller: _controller,
        children: [
          Page1(),
          Page2(),
          Page3(selectedColor: widget.selectedColor), // Third page with dynamic color
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Page 1',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Page 2',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Page3 extends StatefulWidget {
  final Color selectedColor;
  Page3({required this.selectedColor});

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  bool _isVisible = true;
  double _rotationTurns = 0;
  String _displayText = "Hello, Flutter!";
  bool _showFrame = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(seconds: 2),
            child: Text(
              _displayText,
              style: TextStyle(fontSize: 24, color: widget.selectedColor),
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
          AnimatedRotation(
            turns: _rotationTurns,
            duration: Duration(seconds: 2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: _showFrame
                    ? BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3),
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
                _rotationTurns += 0.25;
              });
            },
            child: Text('Rotate Image'),
          ),
        ],
      ),
    );
  }
}
