import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favorite_model.dart';

class FavoriteService {
  static const String _key = 'favorites';

  // 获取所有收藏
  static Future<List<FavoriteItem>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonStr);
    return jsonList.map((json) => FavoriteItem.fromJson(json)).toList();
  }

  // 添加收藏
  static Future<void> add(FavoriteItem item) async {
    final favorites = await getAll();
    // 检查是否已存在
    if (!favorites.any((f) => f.id == item.id)) {
      favorites.add(item);
      await _save(favorites);
    }
  }

  // 删除收藏
  static Future<void> remove(String id) async {
    final favorites = await getAll();
    favorites.removeWhere((f) => f.id == id);
    await _save(favorites);
  }

  // 检查是否已收藏
  static Future<bool> isFavorite(String id) async {
    final favorites = await getAll();
    return favorites.any((f) => f.id == id);
  }

  // 切换收藏状态
  static Future<bool> toggle(FavoriteItem item) async {
    if (await isFavorite(item.id)) {
      await remove(item.id);
      return false;
    } else {
      await add(item);
      return true;
    }
  }

  // 保存到本地存储
  static Future<void> _save(List<FavoriteItem> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(favorites.map((f) => f.toJson()).toList());
    await prefs.setString(_key, jsonStr);
  }

  // 生成唯一 ID
  static String generateId(String type, String content) {
    return '${type}_${content}_${DateTime.now().millisecondsSinceEpoch}';
  }
}
