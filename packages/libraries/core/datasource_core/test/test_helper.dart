import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// A fake AssetBundle that returns mock JSON content
class TestAssetBundle extends CachingAssetBundle {
  final Map<String, String> _mockAssets;

  TestAssetBundle(this._mockAssets);

  @override
  Future<ByteData> load(String key) async {
    if (_mockAssets.containsKey(key)) {
      final bytes = utf8.encode(_mockAssets[key]!);
      return ByteData.view(Uint8List.fromList(bytes).buffer);
    } else {
      throw FlutterError('Asset not found: $key');
    }
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    if (_mockAssets.containsKey(key)) {
      return _mockAssets[key]!;
    } else {
      throw FlutterError('Asset not found: $key');
    }
  }
}
