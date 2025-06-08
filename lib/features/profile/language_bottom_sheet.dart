import 'package:flutter/material.dart';
import 'package:news_app/features/profile/app_controller.dart';
import 'package:provider/provider.dart';

class AppLanguage {
  final String name;
  final String code;

  const AppLanguage({required this.name, required this.code});
}

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late String _selectedCode;
  final List<AppLanguage> _languages = const [
    AppLanguage(name: 'English', code: 'en'),
    AppLanguage(name: 'العربية', code: 'ar'),
  ];

  @override
  void initState() {
    super.initState();
    final appController = Provider.of<AppController>(context, listen: false);
    _selectedCode = appController.selectedLanguageCode ?? 'en';
  }

  @override
  Widget build(BuildContext context) {
    final appController = Provider.of<AppController>(context, listen: false);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Language', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF141414),
                    fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _languages.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final lang = _languages[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                title: Text(lang.name, style: const TextStyle(fontSize: 16)),
                trailing: Radio<String>(
                  value: lang.code,
                  groupValue: _selectedCode,
                  onChanged: (value) => setState(() => _selectedCode = value!),
                ),
                onTap: () => setState(() => _selectedCode = lang.code),
              );
            },
          ),

          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                final selectedLang = _languages.firstWhere(
                  (lang) => lang.code == _selectedCode,
                );
                appController.setLanguage(selectedLang.name, selectedLang.code);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
