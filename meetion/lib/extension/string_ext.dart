
import 'dart:typed_data';

extension StringExtension on String {

  String withPrefix() {
    final hex = this;
    if (hex.startsWith(RegExp('^0[xX]'))) return hex;
    return "0x" + hex;
  }

  String trimHex() {
    final hex = this;
    if (hex.startsWith(RegExp('^0[xX]'))) return hex.substring(2);
    return hex;
  }

  Uint8List bytes() {
    final hex = this.trimHex();
    var result = new Uint8List(hex.length ~/ 2);
    for (var i = 0; i < hex.length; i += 2) {
      var num = hex.substring(i, i + 2);
      var byte = int.parse(num, radix: 16);
      result[i ~/ 2] = byte;
    }
    return result;
  }

  String hexToAscii1() { 
    final hex = this;
    List<String> splitted = [];
    for (int i = 0; i < hex.length; i = i + 2) {
      splitted.add(hex.substring(i, i + 2));
    }
    String ascii = List.generate(splitted.length,
        (i) => String.fromCharCode(int.parse(splitted[i], radix: 16))).join();
    print('${ascii}');
    return ascii;
  }

  String hexToAscii() {
    // if (!utils.isHexStrict(hex))
    //   throw new Error('The parameter must be a valid HEX string.');
    var hex = this.trimHex();
    var str = "";
    var i = 0, l = hex.length;
    for (; i < l; i+=2) {
        var code = int.parse(hex.substring(i, i + 2), radix: 16);
        str += String.fromCharCode(code);
    }

    return str;
  }
}