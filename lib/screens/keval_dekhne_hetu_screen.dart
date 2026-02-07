import 'package:flutter/material.dart';
import '../data/learning_stories.dart';
import 'story_detail_screen.dart';

class KevalDekhneHetuScreen extends StatelessWidget {
  final String userName;

  const KevalDekhneHetuScreen({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EE),
      appBar: AppBar(
        title: Text('नमस्ते $userName'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: GridView.builder(
          itemCount: learningStories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.82,
          ),
          itemBuilder: (context, index) {
            final story = learningStories[index];
            final iconData = _iconForStory(story.title);

            return InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoryDetailScreen(story: story),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF8),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange.shade100,
                      ),
                      child: Icon(
                        iconData,
                        size: 30,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      story.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'गाँव की सच्ची कहानी',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.volume_up,
                            size: 16, color: Colors.orange),
                        SizedBox(width: 6),
                        Text(
                          'सुनो',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _iconForStory(String title) {
    if (title.contains('दिखावे')) return Icons.house;
    if (title.contains('सहारे')) return Icons.agriculture;
    if (title.contains('बारिश')) return Icons.cloud;
    if (title.contains('चोट')) return Icons.healing;
    if (title.contains('उधार')) return Icons.credit_card;
    if (title.contains('बचत')) return Icons.savings;
    if (title.contains('पढ़ाई')) return Icons.school;
    if (title.contains('बढ़ता')) return Icons.trending_up;
    return Icons.menu_book;
  }
}
