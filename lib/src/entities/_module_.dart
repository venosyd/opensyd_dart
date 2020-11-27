///
/// opensyd © 2016-2020.
///
/// sergio lisan <sels@opensyd.com>
///
library opensyd.dart.entities;

import 'addr/_module_.dart';
import 'apps/_module_.dart';
import 'login/_module_.dart';
import 'logs/_module_.dart';
import 'util/_module_.dart';

export '_deprected_.dart';
export 'addr/_module_.dart';
export 'apps/_module_.dart';
export 'login/_module_.dart';
export 'logs/_module_.dart';
export 'util/_module_.dart';

///
///
///
final opensydClasses = <SerializableEntity>[
  //
  // for apps
  ...[Account(), Configuracoes()],
  //
  //
  // login
  ...[AuthUser(), Session()],
  //
  // Logs
  ...[Log(), Namespace()],
  //
  // address
  ...[Endereco(), EnderecoLocal(), Logradouro(), TipoLogradouro()],
  ...[Distrito(), Cidade(), Estado(), Pais()],
];

///
T opensydEmptyInstance<T extends SerializableEntity>(String type) =>
    opensydClasses.firstWhere((clazz) => type == '${clazz.runtimeType}',
        orElse: () => null) as T;

///
SerializableEntity opensydEntitiesMap(Map<String, dynamic> data) =>
    buildMap[data['collection_key']](data);

///
String opensydCollectionMap(Type type) =>
    opensydEmptyInstance('$type').collectionKey;

///
Map<String, SerializableEntity Function(Map<String, dynamic>)> buildMap = {
  for (var c in opensydClasses)
    c.collectionKey: (Map<String, dynamic> data) => c.fromJson(data)
};
