// questions.dart
// type: BOOLEAN → ✓ / ✗
// type: NUMBER  → options / input

class Question {
  final String key;
  final String type; // "BOOLEAN" | "NUMBER"
  final Map<String, String> question; // hinglish / hindi
  final List<String>? options;

  Question({
    required this.key,
    required this.type,
    required this.question,
    this.options,
  });
}

final List<Question> QUESTIONS = [
  // -------------------------
  // आय की स्थिति
  // -------------------------
  Question(
    key: "singleIncome",
    type: "BOOLEAN",
    question: {
      "hinglish":
          "Kya ghar ka kharcha zyada tar sirf ek hi kamai ke source par depend karta hai?",
      "hindi":
          "क्या घर का खर्च अधिकतर केवल एक ही आय के स्रोत पर निर्भर है?"
    },
  ),

  Question(
    key: "incomeUnstable",
    type: "BOOLEAN",
    question: {
      "hinglish":
          "Kya pichhle kuch mahino mein kamai kam hone ya rukne ka darr raha hai?",
      "hindi":
          "क्या पिछले कुछ महीनों में आय कम होने या रुकने की आशंका रही है?"
    },
  ),

  // -------------------------
  // आय (संख्या आधारित)
  // -------------------------
  Question(
    key: "monthlyIncomeRange",
    type: "NUMBER",
    question: {
      "hinglish": "Ghar ki total monthly income lagbhag kitni hai?",
      "hindi": "घर की कुल मासिक आय लगभग कितनी है?"
    },
    options: [
      "₹0 – ₹5,000",
      "₹5,001 – ₹10,000",
      "₹10,001 – ₹20,000",
      "₹20,000 से अधिक",
      "बताना नहीं चाहते"
    ],
  ),

  Question(
    key: "earningMembers",
    type: "NUMBER",
    question: {
      "hinglish": "Ghar mein kitne log kamai kar rahe hain?",
      "hindi": "घर में कितने सदस्य आय अर्जित करते हैं?"
    },
    options: ["0", "1", "2", "3 या अधिक"],
  ),

  // -------------------------
  // बचत व आपात स्थिति
  // -------------------------
  Question(
    key: "emergencySavingsActive",
    type: "BOOLEAN",
    question: {
      "hinglish":
          "Agar achanak koi kharcha aa jaye, toh kya ghar bina udhaar sambhal sakta hai?",
      "hindi":
          "यदि अचानक कोई खर्च आ जाए, तो क्या घर बिना उधार लिए उसे संभाल सकता है?"
    },
  ),

  Question(
    key: "emergencySavingsMonths",
    type: "NUMBER",
    question: {
      "hinglish":
          "Agar kamai ruk jaye, toh ghar kitne mahine bachat ke sahare chal sakta hai?",
      "hindi":
          "यदि आय रुक जाए, तो घर कितने महीनों तक बचत के सहारे चल सकता है?"
    },
    options: [
      "0 महीना",
      "1 महीना",
      "2 महीने",
      "3 या उससे अधिक",
      "पता नहीं"
    ],
  ),

  // -------------------------
  // शिक्षा
  // -------------------------
  Question(
    key: "childrenInSchool",
    type: "BOOLEAN",
    question: {
      "hinglish":
          "Kya bachchon ki padhai bina kisi rukawat ke chal rahi hai?",
      "hindi":
          "क्या बच्चों की पढ़ाई बिना किसी रुकावट के चल रही है?"
    },
  ),

  Question(
    key: "educationWorry",
    type: "BOOLEAN",
    question: {
      "hinglish":
          "Kya padhai ya fees ke kharch ko lekar chinta bani rehti hai?",
      "hindi":
          "क्या पढ़ाई या फीस के खर्च को लेकर चिंता बनी रहती है?"
    },
  ),

  // -------------------------
  // स्वास्थ्य व सहारा
  // -------------------------
  Question(
    key: "medicalCovered",
    type: "BOOLEAN",
    question: {
      "hinglish":
          "Bimaari ki situation mein ilaaj ka proper intezaam hai kya?",
      "hindi":
          "बीमारी की स्थिति में इलाज की उचित व्यवस्था है क्या?"
    },
  ),

  Question(
    key: "medicalExpenseRange",
    type: "NUMBER",
    question: {
      "hinglish":
          "Agar bimaari ho jaye, toh ilaaj par lagbhag kitna kharcha aa sakta hai?",
      "hindi":
          "बीमारी होने पर इलाज पर लगभग कितना खर्च आ सकता है?"
    },
    options: [
      "₹0 – ₹2,000",
      "₹2,001 – ₹5,000",
      "₹5,001 – ₹10,000",
      "₹10,000 से अधिक",
      "पता नहीं"
    ],
  ),

  Question(
    key: "hasSupportNetwork",
    type: "BOOLEAN",
    question: {
      "hinglish":
          "Mushkil waqt mein kya kisi apne ya madad ka sahara mil jata hai?",
      "hindi":
          "कठिन समय में क्या किसी अपने या सहायता का सहारा मिल जाता है?"
    },
  ),
];
