import 'dart:async';
import 'package:flutter/material.dart';
import 'user_entry_screen.dart';

class NamasteScreen extends StatefulWidget {
  const NamasteScreen({super.key});

  @override
  State<NamasteScreen> createState() => _NamasteScreenState();
}

class _NamasteScreenState extends State<NamasteScreen> {
  final String _namasteHindi = 'नमस्ते';
  final String _welcomeEnglish = 'Welcome';

  String _typedHindi = '';
  String _typedEnglish = '';

  int _hiIndex = 0;
  int _enIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();

    // ⏱ Auto navigate after 5 sec
    Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UserEntryScreen()),
      );
    });
  }

  void _startTyping() {
    // Hindi typing
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (_hiIndex < _namasteHindi.length) {
        setState(() {
          _typedHindi += _namasteHindi[_hiIndex];
          _hiIndex++;
        });
      } else {
        timer.cancel();
        _startEnglishTyping();
      }
    });
  }

  void _startEnglishTyping() {
    Timer.periodic(const Duration(milliseconds: 180), (timer) {
      if (_enIndex < _welcomeEnglish.length) {
        setState(() {
          _typedEnglish += _welcomeEnglish[_enIndex];
          _enIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE0B2), // warm village orange
              Color(0xFFFFF8E1), // soft cream
            ],
          ),
        ),
        child: Stack(
          children: [
            // 🌾 Subtle background circle (not plain)
            Positioned(
              top: -80,
              right: -80,
              child: _softCircle(220),
            ),
            Positioned(
              bottom: -100,
              left: -100,
              child: _softCircle(260),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🙏 Symbol
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange.shade200,
                    ),
                    child: const Text(
                      '🙏',
                      style: TextStyle(fontSize: 56),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ✍️ Typing Hindi
                  Text(
                    _typedHindi,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ✍️ Typing English
                  Text(
                    _typedEnglish,
                    style: const TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.1,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Tagline
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Text(
                      'परिवार की सुरक्षा और समझ के लिए\n'
                      'For family safety and understanding',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.brown.shade700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Loading
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Shuru ho raha hai...',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _softCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orange.withOpacity(0.15),
      ),
    );
  }
}
