import 'dart:convert';
import 'package:http/http.dart' as http;

// AI 服务抽象类
abstract class AiService {
  Future<String> generateQuote({
    required String food,
    required String activity,
    required String mood,
    required String timeOfDay,
    required String season,
  });
}

// 本地 AI 服务（使用预设文案，无需 API）
class LocalAiService implements AiService {
  @override
  Future<String> generateQuote({
    required String food,
    required String activity,
    required String mood,
    required String timeOfDay,
    required String season,
  }) async {
    // 本地生成，返回空字符串表示使用默认文案
    return '';
  }
}

// OpenAI 兼容 API 服务
class OpenAiService implements AiService {
  final String apiKey;
  final String baseUrl;
  final String model;

  OpenAiService({
    required this.apiKey,
    this.baseUrl = 'https://api.openai.com/v1',
    this.model = 'gpt-3.5-turbo',
  });

  @override
  Future<String> generateQuote({
    required String food,
    required String activity,
    required String mood,
    required String timeOfDay,
    required String season,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': model,
          'messages': [
            {
              'role': 'system',
              'content': '你是一个幽默风趣的 AI 助手，专门生成搞笑吐槽文案。文案要简短有趣，符合年轻人的网络用语风格。'
            },
            {
              'role': 'user',
              'content': '请生成一句搞笑吐槽文案。当前情况：推荐吃$food，推荐做$activity，心情是$mood，时间是$timeOfDay，季节是$season。文案要贴合这些信息，有趣好玩。'
            }
          ],
          'max_tokens': 100,
          'temperature': 0.8,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].toString().trim();
      }
    } catch (e) {
      // 出错时返回空字符串，使用默认文案
    }
    return '';
  }
}

// AI 服务管理器
class AiServiceManager {
  static AiService _service = LocalAiService();

  static AiService get service => _service;

  // 配置为 OpenAI 兼容 API
  static void configureOpenAi({
    required String apiKey,
    String? baseUrl,
    String? model,
  }) {
    _service = OpenAiService(
      apiKey: apiKey,
      baseUrl: baseUrl ?? 'https://api.openai.com/v1',
      model: model ?? 'gpt-3.5-turbo',
    );
  }

  // 配置为本地服务
  static void configureLocal() {
    _service = LocalAiService();
  }

  // 检查是否已配置 AI
  static bool get isConfigured => _service is OpenAiService;
}
