import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/favorite_model.dart';
import '../services/favorite_service.dart';
import '../theme/app_theme.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<FavoriteItem> _favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavoriteService.getAll();
    setState(() {
      _favorites = favorites;
      _isLoading = false;
    });
  }

  IconData _getFavoriteIcon(String type) {
    switch (type) {
      case 'food':
        return FontAwesomeIcons.utensils;
      case 'activity':
        return FontAwesomeIcons.gamepad;
      case 'movie':
        return FontAwesomeIcons.film;
      case 'music':
        return FontAwesomeIcons.headphones;
      case 'book':
        return FontAwesomeIcons.bookOpen;
      default:
        return FontAwesomeIcons.heart;
    }
  }

  Color _getFavoriteColor(String type) {
    switch (type) {
      case 'food':
        return AppColors.accent;
      case 'activity':
        return const Color(0xFF4A7C91);
      case 'movie':
        return const Color(0xFF9B59B6);
      case 'music':
        return const Color(0xFFE74C3C);
      case 'book':
        return const Color(0xFF27AE60);
      default:
        return AppColors.accent;
    }
  }

  Future<void> _removeFavorite(String id) async {
    await FavoriteService.remove(id);
    await _loadFavorites();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('已取消收藏'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的收藏'),
        backgroundColor: AppColors.background,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _favorites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.heart,
                        size: 64,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '还没有收藏哦~',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '点击推荐卡片上的爱心图标收藏',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _favorites.length,
                  itemBuilder: (context, index) {
                    final item = _favorites[index];
                    return Dismissible(
                      key: Key(item.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const FaIcon(
                          FontAwesomeIcons.trash,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (_) => _removeFavorite(item.id),
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _getFavoriteColor(item.type).withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: FaIcon(
                                _getFavoriteIcon(item.type),
                                color: _getFavoriteColor(item.type),
                                size: 20,
                              ),
                            ),
                          ),
                          title: Text(
                            item.content,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '"${item.quote}"',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF888888),
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.red,
                            ),
                            onPressed: () => _removeFavorite(item.id),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
