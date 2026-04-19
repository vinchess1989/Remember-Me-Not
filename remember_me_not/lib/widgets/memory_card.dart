import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MemoryCard extends StatelessWidget {
  final IconData? icon;
  final String? imageUrl;
  final bool isFlipped;
  final bool isMatched;
  final VoidCallback onTap;

  const MemoryCard({
    super.key,
    this.icon,
    this.imageUrl,
    required this.isFlipped,
    required this.isMatched,
    required this.onTap,
  }) : assert(icon != null || imageUrl != null, 'Either icon or imageUrl must be provided.');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isFlipped && !isMatched) {
          onTap();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: isFlipped || isMatched ? Colors.white : AppTheme.primaryBlue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: isMatched ? AppTheme.accentYellow : Colors.transparent,
            width: 3,
          ),
        ),
        child: AnimatedOpacity(
          opacity: isFlipped || isMatched ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                )
              : Center(
                  child: Icon(
                    icon,
                    size: 48,
                    color: AppTheme.textDark,
                  ),
                ),
        ),
      ),
    );
  }
}
