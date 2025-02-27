import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
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
  
    
     final _controller = PageController(
      initialPage: 0,
     );
  

  @override
void dispose() {
  _controller.dispose();
  super.dispose();
}
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     
      appBar: AppBar(
        title: Text('Fading Text Animation'),
      ),
      body: Column(
        
        children:[
          Expanded(child: PageView(
      controller: _controller,
      children: [

        Page1(),
        Page2(),


      ],)
          
    ),
          AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24),
          ),
        ),
        ], 
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  


}
class Page1 extends StatelessWidget {
    const Page1({super.key});

    @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Text('hello new page')
      ],
    );
  }
  
  
  }
  class Page2 extends StatelessWidget {
    const Page2({super.key});
    @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Text('hello new page  2')
      ],
    );
  }
  
  
  }
