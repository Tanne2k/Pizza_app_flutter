import 'dart:core';

Map<String, String> _vi = {
  "hello": "Xin chào",
  "deli": 'Pizza ngon!',
  "hot": 'Pizza nóng hổi vừa thổi, vừa ăn :>',
  "mess": "Cảm ơn bạn đã tin tưởng dịch vụ của chúng tôi!"
};

Map<String, String> _en = {
  "hello": "Hello",
  "deli": 'Good Pizza!',
  "hot": 'Pizza so hot so good :>',
  "mess": "Thank you for trusting our service!"
};

String currentLanguage = "VI";

String lang(String key, String defaultString) {
  if (currentLanguage == "EN") return _en[key] ?? defaultString;
  return _vi[key] ?? defaultString;
}
