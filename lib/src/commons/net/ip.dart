///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.net.ip;

import 'dart:convert';

import 'package:http/http.dart' as http;

///
///
///
abstract class IPUtils {
  /// returns a future string with the public ip
  static Future<String> getPublicIP() async => json.decode(utf8.decode(
          (await http.get('http://checkip.amazonaws.com')).body.codeUnits))
      as String;
}
