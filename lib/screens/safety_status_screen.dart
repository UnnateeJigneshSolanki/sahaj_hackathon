import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_filex/open_filex.dart';

import '../logic/sahaj_controller.dart';
import '../voice/tts_service.dart';

class SafetyStatusScreen extends StatelessWidget {
  final SahajController controller;
  final String userName;

  const SafetyStatusScreen({
    super.key,
    required this.controller,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final status = controller.getSafetyStatus();

    if (status['ready'] != true) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final int score = status['score'];
    final String state = status['state'];
    final Map<String, dynamic> risks =
        Map<String, dynamic>.from(status['risks']);

    return Scaffold(
      appBar: AppBar(
        title: Text('नमस्ते $userName'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _scoreCard(score, state),
            const SizedBox(height: 20),

            _riskCard(Icons.work, 'आमदनी / Income', risks['income']),
            _riskCard(Icons.local_hospital, 'इलाज / Medical', risks['medical']),
            _riskCard(Icons.school, 'पढ़ाई / Education', risks['education']),
            _riskCard(Icons.savings, 'आपात बचत / Emergency Fund',
                risks['emergencyFund']),

            const SizedBox(height: 20),

            _recommendations(risks),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.volume_up),
                    label: const Text('पूरी स्थिति सुनें'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      TtsService.speak(
                        _ttsSummary(userName, score, state, risks),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.orange,
                    size: 32,
                  ),
                  onPressed: () async {
                    final file =
                        await _savePdf(userName, score, state, risks);

                    // 🔥 PDF OPEN IMMEDIATELY
                    await OpenFilex.open(file.path);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('रिपोर्ट खुल गई है'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= SCORE CARD =================

  Widget _scoreCard(int score, String state) {
    final Color color =
        score >= 70 ? Colors.green : score >= 40 ? Colors.orange : Colors.red;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.shield, size: 48, color: color),
          const SizedBox(height: 10),
          Text(
            '$score / 100',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _stateLabel(state),
            style: TextStyle(fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }

  // ================= RISK CARD =================

  Widget _riskCard(IconData icon, String title, String value) {
    final bool safe =
        value == 'stable' || value == 'covered' || value == 'strong';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: safe ? Colors.green : Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            _pretty(value),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: safe ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // ================= RECOMMENDATIONS =================

  Widget _recommendations(Map<String, dynamic> risks) {
    final List<String> tips = [];

    if (risks['income'] == 'fragile') {
      tips.add(
          'एक से ज़्यादा कमाई का रास्ता सोचें (Hinglish: side income)');
    }
    if (risks['medical'] == 'not_covered') {
      tips.add('सरकारी स्वास्थ्य योजना या बीमा से जुड़ें');
    }
    if (risks['education'] != 'stable') {
      tips.add('बच्चों की पढ़ाई लगातार चलती रहे, इस पर ध्यान दें');
    }
    if (risks['emergencyFund'] != 'strong') {
      tips.add('हर महीने थोड़ा पैसा आपात स्थिति के लिए बचाएं');
    }

    if (tips.isEmpty) {
      tips.add(
          'आपकी स्थिति संतुलित है। इसी तरह समझदारी से निर्णय लेते रहें।');
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🔍 सलाह / Suggestions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...tips.map((t) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text('• $t'),
              )),
        ],
      ),
    );
  }

  // ================= TEXT HELPERS =================

  String _pretty(String value) {
    switch (value) {
      case 'stable':
        return 'ठीक है / Stable';
      case 'fragile':
        return 'कमज़ोर / Weak';
      case 'covered':
        return 'सुरक्षित / Covered';
      case 'not_covered':
        return 'सुरक्षा नहीं / Not Covered';
      case 'strong':
        return 'मजबूत / Strong';
      case 'weak':
        return 'कमज़ोर / Weak';
      case 'missing':
        return 'नहीं है / Missing';
      case 'at_risk':
        return 'खतरे में / At Risk';
      case 'broken':
        return 'रुकी हुई / Stopped';
      default:
        return value.replaceAll('_', ' ');
    }
  }

  String _stateLabel(String state) {
    if (state == 'safe') return 'स्थिति सुरक्षित है';
    if (state == 'stressed') return 'स्थिति दबाव में है';
    return 'स्थिति जोखिम में है';
  }

  // ================= TTS =================

  String _ttsSummary(
      String name, int score, String state, Map<String, dynamic> risks) {
    return '''
$name,
आपकी पारिवारिक सुरक्षा का अंक $score है।

आमदनी की स्थिति ${_pretty(risks['income'])} है।
इलाज की सुरक्षा ${_pretty(risks['medical'])} है।
पढ़ाई की स्थिति ${_pretty(risks['education'])} है।
आपातकालीन बचत ${_pretty(risks['emergencyFund'])} है।

कुल मिलाकर, आपकी ${_stateLabel(state)}।
''';
  }

  // ================= PDF =================

  Future<File> _savePdf(
    String name,
    int score,
    String state,
    Map<String, dynamic> risks,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Sahaj – Family Safety Report',
              style: pw.TextStyle(
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 12),
            pw.Text('नाम / Name: $name'),
            pw.Text('सुरक्षा अंक / Score: $score / 100'),
            pw.Text('स्थिति / Status: ${_stateLabel(state)}'),
            pw.SizedBox(height: 12),
            pw.Text('विवरण / Details:'),
            pw.Text('• आमदनी: ${_pretty(risks['income'])}'),
            pw.Text('• इलाज: ${_pretty(risks['medical'])}'),
            pw.Text('• पढ़ाई: ${_pretty(risks['education'])}'),
            pw.Text('• आपात बचत: ${_pretty(risks['emergencyFund'])}'),
          ],
        ),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/sahaj_safety_report.pdf');
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
