Sahaj – Family Safety and Stability Assessment
Sahaj is a voice-assisted, question-based assessment application designed to help families understand their financial, medical, educational, and emergency stability in a simple and empathetic manner.

The app guides users through short, easy-to-understand questions and then presents a clear safety score and risk breakdown, enabling reflection on their current situation and possible next steps.

Key Features
Structured Question Flow
Simple yes/no and option-based questions covering:

Income stability

Emergency savings

Medical preparedness

Education-related pressure

Support systems

Text-to-Speech (TTS) Support
Questions can be read aloud to improve accessibility for:

Low-literacy users

Elderly users

First-time smartphone users

Safety Score and Status Screen

Overall safety score (out of 100)

Clear stability status (for example: Vulnerable, Stable)

Category-wise risk indicators

Logic-Driven Architecture
Assessment and scoring logic is separated from the user interface for clarity and maintainability.

Tech Stack
Flutter (Dart) for cross-platform development

Android Native Text-to-Speech for voice output

Custom rule-based assessment engine
Application Flow
User Entry
The user enters basic details such as name.

Ghar Ki Sthiti (Assessment)
The user answers a sequence of questions related to household stability.
Text-to-Speech can be used to hear questions.

Proceed
After completing the assessment, the user confirms and proceeds.

Safety Status Screen
The app displays:

Overall safety score

Stability status

Section-wise risk evaluation

Purpose and Impact
Sahaj is built on the belief that understanding one’s situation is the first step toward improvement.

The application focuses on:

Financial awareness

Non-judgmental self-assessment

Simple language and interaction

Accessibility and inclusivity

How to Run the Project
flutter pub get
flutter run
Note: The project uses Android native Text-to-Speech. An Android device or emulator with TTS support is required.

Team
Developed by the Sahaj Team as part of a hackathon project focused on social impact and accessibility.



Clean separation of logic, UI, and services
