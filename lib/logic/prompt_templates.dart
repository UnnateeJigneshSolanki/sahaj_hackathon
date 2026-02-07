// prompt_templates.dart
// Final explainable templates (score-driven, no advice)

final Map<String, Map<String, String>> templates = {
  "EDUCATION": {
    "good":
        "Bachchon ki padhai abhi lagataar chal rahi hai, is wajah se is area mein zyada risk nahi dikh raha.",
    "bad":
        "Bachchon ki padhai mein rukawat ke sanket hain, jo aage chal kar risk badha sakte hain.",
  },

  "MEDICAL": {
    "good":
        "Bimari ya ilaaj ke kharche ke liye kuch suraksha maujood hai, isliye medical risk kam hai.",
    "bad":
        "Bimari ya ilaaj ke kharche ke liye koi pakki suraksha nahi dikh rahi, jo risk badha sakti hai.",
  },

  "EMERGENCY": {
    "good":
        "Achanak emergency ke liye kuch taiyari nazar aa rahi hai, isliye turant khatre ka level kam hai.",
    "bad":
        "Achanak emergency ke liye taiyari kam dikh rahi hai, jisse financial dabav badh sakta hai.",
  },

  "INCOME": {
    "good":
        "Ghar ki kamai ka sahara kaafi had tak balanced lag raha hai, isliye income risk filhaal kam hai.",
    "bad":
        "Ghar ka kharcha zyada tar ek hi kamai par nirbhar hai, jisse income risk badhta hai.",
  },
};
