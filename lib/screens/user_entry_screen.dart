import 'package:flutter/material.dart';
import '../storage/hive_boxes.dart';
import '../logic/sahaj_controller.dart';
import '../voice/tts_service.dart'; // ✅ TTS added
import 'ghar_ki_sthithi_screen.dart';
import 'keval_dekhne_hetu_screen.dart';

class UserEntryScreen extends StatefulWidget {
  const UserEntryScreen({super.key});

  @override
  State<UserEntryScreen> createState() => _UserEntryScreenState();
}

class _UserEntryScreenState extends State<UserEntryScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final SahajController _controller = SahajController();

  String? gender;
  String? error;

  @override
  void initState() {
    super.initState();
    TtsService.init(); // ✅ init once
  }

  @override
  void dispose() {
    TtsService.stop();
    _nameCtrl.dispose();
    super.dispose();
  }

  bool _validateAndSave() {
    final name = _nameCtrl.text.trim();

    if (name.isEmpty) {
      setState(() => error = 'कृपया अपना नाम लिखें');
      return false;
    }

    if (gender == null) {
      setState(() => error = 'कृपया लिंग चुनें');
      return false;
    }

    HiveBoxes.saveUser(name: name, gender: gender!);
    setState(() => error = null);
    return true;
  }

  // 🔊 SMART TTS LOGIC
  void _speakHint() {
    final name = _nameCtrl.text.trim();

    if (name.isEmpty) {
      TtsService.speak('कृपया अपना नाम लिखें');
      return;
    }

    if (gender == null) {
      TtsService.speak('अब कृपया अपना लिंग चुनें');
      return;
    }

    TtsService.speak('धन्यवाद, अब आप आगे बढ़ सकते हैं');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('आप का परिचय'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: _speakHint, // ✅ TTS trigger
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'आप का नाम',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                hintText: 'नाम / Name',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'लिंग / Gender',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              initialValue: gender,
              hint: const Text('चुनें / Select'),
              items: const [
                DropdownMenuItem(
                  value: 'महिला / Female',
                  child: Text('महिला / Female'),
                ),
                DropdownMenuItem(
                  value: 'पुरुष / Male',
                  child: Text('पुरुष / Male'),
                ),
              ],
              onChanged: (v) => setState(() => gender = v),
            ),
            if (error != null) ...[
              const SizedBox(height: 10),
              Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 30),
            _bigButton(
              '🏠  घर की स्थिति जानने',
              () {
                if (!_validateAndSave()) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GharKiSthitiScreen(
                      controller: _controller,
                      userName: _nameCtrl.text.trim(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _bigButton(
              '👀  केवल देखने हेतु',
              () {
                if (!_validateAndSave()) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => KevalDekhneHetuScreen(
                      userName: _nameCtrl.text.trim(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _bigButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
