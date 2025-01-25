import 'dart:ui';

import 'package:meals_app_new/model/Category_Model.dart';

final List<CatModel> foodCategories = [
  const CatModel(id: 1, title: 'Fruits', color: Color(0xFFFFA726)), // Orange
  const CatModel(id: 2, title: 'Vegetables', color: Color(0xFF66BB6A)), // Green
  const CatModel(id: 3, title: 'Dairy', color: Color(0xFF42A5F5)), // Blue
  const CatModel(id: 4, title: 'Grains', color: Color(0xFFFFD54F)), // Yellow
  const CatModel(id: 5, title: 'Protein', color: Color(0xFF8D6E63)), // Brown
  const CatModel(
      id: 6, title: 'Snacks', color: Color(0xFFFF7043)), // Red-Orange
  const CatModel(id: 7, title: 'Beverages', color: Color(0xFFAB47BC)), // Purple
  const CatModel(
      id: 8, title: 'Seafood', color: Color(0xFF29B6F6)), // Light Blue
  const CatModel(id: 9, title: 'Desserts', color: Color(0xFFE91E63)), // Pink
  const CatModel(id: 10, title: 'Fast Food', color: Color(0xFFBDBDBD)), // Grey
];
