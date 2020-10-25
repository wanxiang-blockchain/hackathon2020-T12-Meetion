
import 'dart:typed_data';

extension Uint8ListExtension on Uint8List {

  String hex() {
    final bytes = this.sublist(0);
    var result = new StringBuffer();
    for (var i = 0; i < bytes.lengthInBytes; i++) {
    var part = bytes[i];
      result.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
    }
    return result.toString();
  }

  Uint8List padLeft(int count) {
    if (this.length >= count)
      return Uint8List.fromList(this);
    var bytes = Uint8List(count);
    int padCount = count - this.length;
    bytes.setRange(0, padCount, List<int>.filled(padCount, 0));
    bytes.setRange(padCount, count, this);
    return bytes;
  }


}