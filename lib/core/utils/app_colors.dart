import 'package:flutter/material.dart';

/// Semua warna aplikasi terpusat di sini.
/// Jangan hardcode Color() di file lain — panggil dari sini.
class AppColors {
  AppColors._();

  // ── Onboarding / Global ───────────────────────────────────────────────────
  static const Color primary = Color(0xFFFFA726);
  static const Color primaryLight = Color(0xFFFFE0B2);
  static const Color background = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF616161);

  // ── Pojok Statistik ───────────────────────────────────────────────────────
  static const Color pojokNavy = Color(0xFF0A2A6B);
  static const Color pojokNavyLight = Color(0xFF1565C0);
  static const Color pojokOrange = Color(0xFFF29F05);
  static const Color pojokOrangeDark = Color(0xFFE65100);
  static const Color pojokBg = Color(0xFFF0F4FA);
  static const Color pojokCardBorder = Color(0xFFD6E4F7);

  // ── Desa Cantik ───────────────────────────────────────────────────────────
  static const Color desaOrange = Color(0xFFF59E0B);
  static const Color desaOrangeDark = Color(0xFFE65100);
  static const Color desaOrangeLight = Color(0xFFFFF3E8);
  static const Color desaBlue = Color(0xFF0A2A6B);
  static const Color desaGreen = Color(0xFF1B8A4A);
  static const Color desaGreenLight = Color(0xFFE8F5EE);
  static const Color desaBlueLight = Color(0xFFE8EEF8);
  static const Color desaBg = Color(0xFFF4F6FA);
  static const Color desaCardBg = Color(0xFFFFFFFF);
  static const Color desaTextPrimary = Color(0xFF0A2A6B);
  static const Color desaTextSecondary = Color(0xFF6B7A99);
  static const Color desaDivider = Color(0xFFE8EDF5);

  // ── Pembinaan Sektoral ────────────────────────────────────────────────────
  static const Color pembinaanNavy = Color(0xFF0A3A75);
  static const Color pembinaanBg = Color(0xFFF4F6F9);
  static const Color pembinaanBlue = Color(0xFF0B3D91);

  // ── Auth / Login ──────────────────────────────────────────────────────────
  static const Color authBg = Color(0xFFF4F6FA);
  static const Color authNavy = Color(0xFF0A2A6B);
  static const Color authNavyText = Color(0xFF6B7A99);
  static const Color authOrange = Color(0xFFF59E0B);

  // ── Kuis ─────────────────────────────────────────────────────────────────
  static const Color kuisOrange = Color(0xFFFF9500);
  static const Color kuisOrangeDark = Color(0xFFFF7B00);

  // ── Thumb gradients Pojok ─────────────────────────────────────────────────
  static const List<List<Color>> pojokThumbGradients = [
    [Color(0xFF0D1B5E), Color(0xFF1A237E)],
    [Color(0xFF1A237E), Color(0xFF283593)],
    [Color(0xFF0A1540), Color(0xFF0D1B5E)],
    [Color(0xFF162040), Color(0xFF1A237E)],
  ];

  // ── Kuis card colors ──────────────────────────────────────────────────────
  static const List<Color> kuisCardColors = [
    Color(0xFFFF9500),
    Color(0xFFFF6B6B),
    Color(0xFF4ECDC4),
    Color(0xFF45B7D1),
    Color(0xFF96CEB4),
    Color(0xFFDDA15E),
    Color(0xFFC9ADA7),
  ];
}
