import 'dart:convert';
import 'package:flutter/services.dart';

/// Utility service for reading JSON from assets
class AssetService {
  /// Loads and decodes a JSON file from assets.
  static Future<Map<String, dynamic>> loadJson(String path) async {
    try {
      final String jsonString = await rootBundle.loadString(path);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw AssetException('Failed to load asset [$path]: $e');
    }
  }
}

class AssetException implements Exception {
  final String message;
  AssetException(this.message);

  @override
  String toString() => 'AssetException: $message';
}
