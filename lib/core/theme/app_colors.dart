import 'package:flutter/material.dart';

abstract final class AppColors {
  // Identidad principal de Yachay Ñan
  static const Color primary = Color(0xFF2FAAA7);
  static const Color primaryDark = Color(0xFF238A87);
  static const Color primaryLight = Color(0xFFD9F3F1);

  // Colores complementarios
  static const Color secondary = Color(0xFFFF9A25);
  static const Color secondaryLight = Color(0xFFFFE8C7);

  // Fondos y superficies
  static const Color background = Color(0xFFFFF8EC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFFAFCFB);

  // Textos
  static const Color textPrimary = Color(0xFF1F3E3A);
  static const Color textSecondary = Color(0xFF5D6C73);
  static const Color textMuted = Color(0xFF8A999E);

  // Bordes y divisores
  static const Color border = Color(0xFFD8E5E1);
  static const Color divider = Color(0xFFE6EEEB);

  // Estados
  static const Color success = Color(0xFF42B883);
  static const Color warning = Color(0xFFF4B740);
  static const Color error = Color(0xFFC62828);
  static const Color info = Color(0xFF3D8FD1);

  // Sombras
  static const Color shadowSoft = Color(0x22000000);

  // Regiones del Perú
  static const Color coast = Color(0xFF4CB7D8);
  static const Color highlands = Color(0xFFD08B4A);
  static const Color jungle = Color(0xFF4EAD66);
}
