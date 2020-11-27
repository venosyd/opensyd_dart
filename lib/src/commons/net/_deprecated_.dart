///
/// @author sergio lisan
///
/// venosyd © 2016-2020
///
library opensyd.dart.commons.net.deprecated;

import 'dart:convert';

import 'package:http/http.dart' as http;

@Deprecated('use IPUtils.getPublicIP()')

/// MANTIDO PARA COMPATIBILIDADE
Future<String> getPublicIP() async => json.decode(utf8.decode(
    (await http.get('http://checkip.amazonaws.com')).body.codeUnits)) as String;
