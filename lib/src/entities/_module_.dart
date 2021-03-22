///
/// venosyd © 2016-2021.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.entities;

import 'package:opensyd_dart/opensyd_dart.dart';

import 'addr/_module_.dart';
import 'apps/_module_.dart';
import 'login/_module_.dart';
import 'logs/_module_.dart';
import 'opensydentity.dart';
import 'support/_module_.dart';

export '_deprected_.dart';
export 'addr/_module_.dart';
export 'apps/_module_.dart';
export 'fillers.dart';
export 'login/_module_.dart';
export 'logs/_module_.dart';
export 'opensydentity.dart';
export 'parsers.dart';
export 'support/_module_.dart';

///
///
///
class VenosydModel extends EntitiesIntegrationModel {
  ///
  VenosydModel._()
      : super(
          exclusiveClasses: <OpensydEntity>[
            // for apps
            ...[Account(), Configuracoes()],
            // aulikara
            ...[News(), Topic(), Report()],
            // songhai
            ...[AuthUser(), Session()],
            // hotaki
            ...[Log(), Namespace()],
            // spanish
            ...[Endereco(), EnderecoLocal(), Logradouro(), TipoLogradouro()],
            ...[Distrito(), Cidade(), Estado(), Pais()],
          ],
        );

  ///
  static VenosydModel _instance;

  ///
  static VenosydModel get instance => _instance ??= VenosydModel._();
}
