import 'package:flutter/material.dart';

extension AppNavigator on BuildContext {
  /// Push halaman baru ke stack.
  Future<T?> pushPage<T>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: page.runtimeType.toString()),
      ),
    );
  }

  /// Ganti halaman saat ini (tidak bisa back).
  Future<T?> pushReplacePage<T>(Widget page) {
    return Navigator.of(this).pushReplacement<T, dynamic>(
      MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: page.runtimeType.toString()),
      ),
    );
  }

  /// Push dan hapus semua route sebelumnya.
  Future<T?> pushAndRemoveAllPages<T>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: page.runtimeType.toString()),
      ),
      (route) => false,
    );
  }

  /// Pop halaman saat ini.
  void popPage<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Pop sampai halaman pertama.
  void popToFirst() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }
}
