import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/ai_service.dart';
import '../theme/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _apiKeyController = TextEditingController();
  final _baseUrlController = TextEditingController();
  final _modelController = TextEditingController();
  bool _useAi = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _useAi = prefs.getBool('use_ai') ?? false;
      _apiKeyController.text = prefs.getString('ai_api_key') ?? '';
      _baseUrlController.text = prefs.getString('ai_base_url') ?? 'https://api.openai.com/v1';
      _modelController.text = prefs.getString('ai_model') ?? 'gpt-3.5-turbo';
    });

    if (_useAi && _apiKeyController.text.isNotEmpty) {
      _configureAi();
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('use_ai', _useAi);
    await prefs.setString('ai_api_key', _apiKeyController.text);
    await prefs.setString('ai_base_url', _baseUrlController.text);
    await prefs.setString('ai_model', _modelController.text);

    if (_useAi) {
      _configureAi();
    } else {
      AiServiceManager.configureLocal();
    }
  }

  void _configureAi() {
    AiServiceManager.configureOpenAi(
      apiKey: _apiKeyController.text,
      baseUrl: _baseUrlController.text.isEmpty ? null : _baseUrlController.text,
      model: _modelController.text.isEmpty ? null : _modelController.text,
    );
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _baseUrlController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: AppColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // AI 配置
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: AppColors.accent),
                      const SizedBox(width: 8),
                      const Text(
                        'AI 文案生成',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '开启后，AI 会根据你的选择生成个性化吐槽文案',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF888888),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('启用 AI 生成'),
                    value: _useAi,
                    onChanged: (value) {
                      setState(() {
                        _useAi = value;
                      });
                      _saveSettings();
                    },
                    activeThumbColor: AppColors.accent,
                  ),
                  if (_useAi) ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: _apiKeyController,
                      decoration: const InputDecoration(
                        labelText: 'API Key',
                        hintText: 'sk-...',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      onChanged: (_) => _saveSettings(),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _baseUrlController,
                      decoration: const InputDecoration(
                        labelText: 'API 地址（可选）',
                        hintText: 'https://api.openai.com/v1',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => _saveSettings(),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _modelController,
                      decoration: const InputDecoration(
                        labelText: '模型名称',
                        hintText: 'gpt-3.5-turbo',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => _saveSettings(),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '支持 OpenAI 兼容的 API，如 Claude、DeepSeek 等',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // 关于
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: AppColors.accent),
                      const SizedBox(width: 8),
                      const Text(
                        '关于',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('AI摆烂助手 v1.0.0'),
                  const SizedBox(height: 8),
                  const Text(
                    '一款轻松有趣的推荐小应用，根据时间、心情智能推荐吃什么、干什么。',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
