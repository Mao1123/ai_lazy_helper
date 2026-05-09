import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

class ResultCard extends StatefulWidget {
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
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  bool _isAnimating = false;

  void _handleRefresh() {
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
    });

    // 先执行退出动画，再刷新数据，最后执行进入动画
    Future.delayed(const Duration(milliseconds: 300), () {
      widget.onRefresh();
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) {
          setState(() {
            _isAnimating = false;
          });
        }
      });
    });
  }

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
                FaIcon(widget.icon, color: AppColors.accent, size: 24),
                const SizedBox(width: 10),
                Text(
                  widget.title,
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
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: 0.8,
                        end: 1.0,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutBack,
                      )),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  widget.result,
                  key: ValueKey<String>(widget.result),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.2),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      )),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  '"${widget.quote}"',
                  key: ValueKey<String>(widget.quote),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: _handleRefresh,
                icon: AnimatedRotation(
                  turns: _isAnimating ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: const FaIcon(FontAwesomeIcons.arrowRotateRight, size: 16),
                ),
                label: const Text('再抽一次'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
