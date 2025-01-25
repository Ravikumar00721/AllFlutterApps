import 'dart:ui';

class CatModel {
  final dynamic id;
  final String title;
  final Color color;

  const CatModel({
    required this.title,
    required this.id,
    this.color = const Color(0xFFC84600), // Corrected default black color
  });
}
