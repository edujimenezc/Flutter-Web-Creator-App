import 'dart:ui';

/**
 *Clase que hereda de Color para hacer una conversión hacia o desde hexadecimal a Color.
 *
 * @author Eduardo Jimenez Cobos
 */


extension HexColor on Color {
/**
 * Funcion que pasa el color actual a hexadecimal
 */
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
      
/**
 * Funcion que convierte un hexadecimal a Color
 * @param hexString, String con el código hexadecimal para transformarlo a color
 */
       Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}