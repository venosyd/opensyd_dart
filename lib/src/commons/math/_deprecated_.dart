///
/// @author sergio lisan
///
/// venosyd © 2016-2020
///
library opensyd.dart.commons.math.deprecated;

import 'dart:math';

@Deprecated('Use a nova Aleatorio.next')

/// retorna um numero aleatorio
int next(int min, int max) => min + Random().nextInt(max - min);

@Deprecated('Vai cair em desuso. Uso Average.rateAvg')
abstract class RateUtil {
  @Deprecated('Vai cair em desuso. Uso Average.rateAvg')
  static int rateAverage(Map<String, int> ratings) {
    // calcula quantos pontos sao esperados (se todas as avaliacoes fossem de 5 estrelas)
    int expectedpoints = 0;
    ratings.forEach((_, acc) => expectedpoints += 5 * acc);

    // se a expectativa for zero, significa que ainda nao ha nenuma avaliacao
    if (expectedpoints == 0) {
      return 0;
    }

    // faz um calculo somando quantos pontos cada nota teve
    int accpoints = 0;
    ratings.forEach((rate, acc) => accpoints += rate.length * acc);

    // decide a media calculando qual nota teve mais evidencia
    return (((accpoints * 100) / expectedpoints).ceil() / 20).round();
  }
}
