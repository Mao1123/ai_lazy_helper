import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/favorite_model.dart';
import '../services/favorite_service.dart';
import '../theme/app_theme.dart';

class ResultCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String result;
  final String quote;
  final String type; // 'food' or 'activity'
  final VoidCallback onRefresh;

  const ResultCard({
    super.key,
    required this.icon,
    required this.title,
    required this.result,
    required this.quote,
    required this.type,
    required this.onRefresh,
  });

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  bool _isAnimating = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  @override
  void didUpdateWidget(ResultCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.result != widget.result) {
      _checkFavorite();
    }
  }

  Future<void> _checkFavorite() async {
    final id = FavoriteService.generateId(widget.type, widget.result);
    final isFavorite = await FavoriteService.isFavorite(id);
    if (mounted) {
      setState(() {
        _isFavorite = isFavorite;
      });
    }
  }

  void _handleRefresh() {
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
    });

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

  Future<void> _toggleFavorite() async {
    final id = FavoriteService.generateId(widget.type, widget.result);
    final item = FavoriteItem(
      id: id,
      type: widget.type,
      content: widget.result,
      quote: widget.quote,
      createdAt: DateTime.now(),
    );

    final isFavorite = await FavoriteService.toggle(item);
    if (mounted) {
      setState(() {
        _isFavorite = isFavorite;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isFavorite ? '已收藏' : '已取消收藏'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
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
                const Spacer(),
                GestureDetector(
                  onTap: _toggleFavorite,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: FaIcon(
                      _isFavorite
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      key: ValueKey<bool>(_isFavorite),
                      color: _isFavorite ? Colors.red : Colors.grey[400],
                      size: 22,
                    ),
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
