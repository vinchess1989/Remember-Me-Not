import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'media_management_screen.dart';

class GuardianDashboardScreen extends StatelessWidget {
  const GuardianDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guardian Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient Analytics',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.analytics, color: AppTheme.primaryBlue),
                      title: Text('Accuracy & Speed'),
                      subtitle: Text('Last 7 days performance'),
                    ),
                    const SizedBox(height: 16),
                    // Placeholder for a chart
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('Performance Graph Placeholder'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Media Management',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.photo_library, color: AppTheme.secondaryTeal),
                title: const Text('Upload & Tag Photos'),
                subtitle: const Text('Manage patient\'s image gallery'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MediaManagementScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Smart AI Suggestions',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.lightbulb, color: AppTheme.accentYellow),
                title: const Text('Difficulty Adjusted'),
                subtitle: const Text('Matching Game difficulty was increased based on recent high scores.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
