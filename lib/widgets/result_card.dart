import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

class ResultCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String result;
  final String quote;
  final VoidCallback onRefresh;

  const ResultCard({
    super.key,
    required this.icon,
    required this.title,
    required this.result,
    required this.quote,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(icon, color: AppColors.accent, size: 24),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .scale(begin: const Offset(0.8, 0.8)),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                '"$quote"',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: 150.ms, duration: 300.ms),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const FaIcon(FontAwesomeIcons.arrowRotateRight, size: 16),
                label: const Text('再抽一次'),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }
}
