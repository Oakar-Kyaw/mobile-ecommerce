// import 'dart:async';

// import 'package:flutter/material.dart';

// class AnimatedSingleLetterText extends StatefulWidget {
//   final String text;
//   final TextStyle textStyle;
//   final Duration speed;

//   const AnimatedSingleLetterText({
//     Key? key,
//     required this.text,
//     required this.textStyle,
//     this.speed = const Duration(milliseconds: 200),
//   }) : super(key: key);

//   @override
//   State<AnimatedSingleLetterText> createState() => _AnimatedSingleLetterTextState();
// }

// class _AnimatedSingleLetterTextState extends State<AnimatedSingleLetterText> {
//   int _index = 0;
//   String _currentLetter = "";
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _startAnimation();
//   }

//   void _startAnimation() {
//     _timer = Timer.periodic(widget.speed, (timer) {
//       setState(() {
//         _currentLetter = widget.text[_index];
//         _index = (_index + 1) % widget.text.length;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       _currentLetter,
//       style: widget.textStyle,
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final String? imageUrl;

  const AnimatedText({Key? key, required this.text, required this.textStyle, this.imageUrl})
      : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  String _visibleText = "";
  bool _isForward = true;
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    const duration = Duration(milliseconds: 250);
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        if (_isForward) {
          // show letters
          _index++;
          if (_index == widget.text.length) _isForward = false;
        } else {
          // hide letters
          _index--;
          if (_index == 0) _isForward = true;
        }
        _visibleText = widget.text.substring(0, _index);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Image.asset(
           widget.imageUrl!,
           fit: BoxFit.contain,
           width: 60,
           height: 80,
        ),
        Positioned(
          top: 20,
          child: Text(
            _visibleText,
            style: widget.textStyle,
          ),
        ),
      ],
    );
  }
}

