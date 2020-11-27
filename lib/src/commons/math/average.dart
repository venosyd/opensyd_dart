///
/// venosyd © 2016-2020.
///
/// sergio lisan <sels@venosyd.com>
///
library opensyd.dart.commons.date.average;

///
/// utilidades para avaliacoes
///
abstract class Average {
  /// coleta avaliacoes dispostas em um mapa. avaliacoes de 5 a 1 estrelas seguindo
  /// o padrao abaixo
  ///
  ///  Map ratings = {
  ///    '*****': 10,
  ///    '****': 15,
  ///    '***': 2,
  ///    '**': 3,
  ///    '*': 5,
  ///  };
  ///
  /// retorna a nota media de 1 a 5, arredondada para um numero inteiro
  ///
  static int rateAvg(Map<String, int> ratings) {
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
