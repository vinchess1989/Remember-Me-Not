import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/feature_card.dart';
import 'matching_game_screen.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Image Placeholder (Replace with actual asset later)
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    // using a placeholder network image that resembles the header
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1576765608535-5f04d1e3f289?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Memory Bridge',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppTheme.primaryBlue,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'What would you like to do today?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              // Stars Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x05000000),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_border, color: AppTheme.accentYellow),
                    const SizedBox(width: 8),
                    const Icon(Icons.star, color: AppTheme.accentYellow),
                    const SizedBox(width: 8),
                    Text(
                      '4 Stars Earned',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Grid of Features
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.5, // adjust based on card height
                children: [
                  FeatureCard(
                    title: 'Matching Game',
                    subtitle: 'Exercise your memory',
                    icon: Icons.extension,
                    iconBackgroundColor: AppTheme.primaryBlue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MatchingGameScreen(),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: 'Puzzles',
                    subtitle: 'Solve fun challenges',
                    icon: Icons.psychology,
                    iconBackgroundColor: AppTheme.accentYellow,
                    onTap: () {},
                  ),
                  FeatureCard(
                    title: 'My Images',
                    subtitle: 'Personalize your games',
                    icon: Icons.photo_library,
                    iconBackgroundColor: AppTheme.secondaryTeal,
                    onTap: () {},
                  ),
                  FeatureCard(
                    title: 'Music',
                    subtitle: 'Listen to your favorites',
                    icon: Icons.music_note,
                    iconBackgroundColor: AppTheme.primaryBlue,
                    onTap: () {},
                  ),
                  FeatureCard(
                    title: 'Contacts',
                    subtitle: 'Reach loved ones',
                    icon: Icons.phone,
                    iconBackgroundColor: AppTheme.softPurple,
                    onTap: () {},
                  ),
                  FeatureCard(
                    title: 'Daily Schedule',
                    subtitle: 'Your routine at a glance',
                    icon: Icons.calendar_today,
                    iconBackgroundColor: AppTheme.warmOrange,
                    onTap: () {},
                  ),
                  FeatureCard(
                    title: 'Resources',
                    subtitle: 'Helpful information',
                    icon: Icons.book,
                    iconBackgroundColor: AppTheme.accentYellow,
                    onTap: () {},
                  ),
                  FeatureCard(
                    title: 'About Us',
                    subtitle: 'Learn about Memory Bridge',
                    icon: Icons.favorite,
                    iconBackgroundColor: AppTheme.accentYellow,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Tap any card to get started',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
