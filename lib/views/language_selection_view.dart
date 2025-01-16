import 'package:flutter/material.dart';
import 'dart:developer';

class LanguageSelectionView extends StatefulWidget {
  const LanguageSelectionView({super.key});

  @override
  State<LanguageSelectionView> createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  final List<String> myLanguages = [
    "English",
    "Chinese",
    "Spanish",
    "Hindi",
    "Arabic",
    "Bengali",
    "Portuguese",
    "Russian",
    "Japanese",
    "German",
    "French",
    "Korean",
    "Turkish",
    "Italian",
    "Vietnamese",
    "Urdu",
    "Persian",
    "Thai",
    "Dutch",
    "Swedish",
    "Greek",
    "Hebrew",
    "Polish",
    "Czech",
    "Hungarian",
    "Romanian",
    "Danish",
    "Finnish",
    "Norwegian",
    "Ukrainian",
    "Malay",
    "Indonesian",
    "Tagalog",
    "Tamil",
    "Telugu",
    "Kannada",
    "Gujarati",
    "Marathi",
    "Punjabi",
    "Afrikaans",
    "Zulu",
    "Swahili",
    "Somali",
    "Hausa",
    "Yoruba",
    "Amharic",
    "Pashto",
    "Kurdish",
    "Mongolian",
    "Burmese",
    "Khmer",
    "Lao",
    "Sinhala",
    "Nepali",
    "Tibetan",
    "Bosnian",
    "Serbian",
    "Croatian",
    "Slovak",
    "Slovenian",
    "Lithuanian",
    "Latvian",
    "Estonian",
    "Icelandic",
    "Irish",
    "Welsh",
    "Scottish Gaelic",
    "Macedonian",
    "Albanian",
    "Georgian",
    "Armenian",
    "Azerbaijani",
    "Kazakh",
    "Uzbek",
    "Turkmen",
    "Kyrgyz",
    "Tatar",
    "Tajik",
    "Bashkir",
    "Chechen",
    "Belarusian",
    "Malagasy",
    "Fijian",
    "Tongan",
    "Samoan",
    "Maori",
    "Hawaiian",
    "Luxembourgish",
    "Basque",
    "Galician",
    "Catalan",
    "Corsican",
    "Occitan",
    "Esperanto",
    "Chichewa",
    "Tswana",
    "Xhosa",
    "Shona",
    "Igbo",
    "Zulu"
  ];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your language from below'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 4)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  iconSize: 36,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  isExpanded: true,
                  items: myLanguages.map(buildLanguageItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (value == null) {
                log('No language selected');
              } else {
                log('$value selected');
              }
            },
            child: const Text(
              'Confirm',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildLanguageItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
