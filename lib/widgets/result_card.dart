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
  final String type;
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

class _ResultCardState extends State<ResultCard> with SingleTickerProviderStateMixin {
  bool _isAnimating = false;
  bool _isFavorite = false;
  late AnimationController _refreshAnimController;
  late Animation<double> _refreshRotation;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
    _refreshAnimController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _refreshRotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _refreshAnimController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _refreshAnimController.dispose();
    super.dispose();
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

    _refreshAnimController.forward().then((_) {
      _refreshAnimController.reset();
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
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey.withValues(alpha: 0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FaIcon(widget.icon, color: AppColors.accent, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _toggleFavorite,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _isFavorite
                            ? Colors.red.withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
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
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.7,
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
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        )),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    key: ValueKey<String>(widget.quote),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '"${widget.quote}"',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _handleRefresh,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 3,
                    shadowColor: AppColors.accent.withValues(alpha: 0.3),
                  ),
                  icon: AnimatedBuilder(
                    animation: _refreshRotation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _refreshRotation.value * 2 * 3.14159,
                        child: child,
                      );
                    },
                    child: const FaIcon(FontAwesomeIcons.arrowRotateRight, size: 16),
                  ),
                  label: const Text(
                    '再抽一次',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
