import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

class Cryptography {
  var key = Uint8List(32);
  var params = base64.decode("BBCXKlVk6ByAxl7yTpQL3seA");

  /*var params = Uint8List(18)
    ..[0] = 4
    ..[1] = 16;
  void setDataEncrypting() {
    for (int i = 2; i < 18; i++) {
      params[i] = Random().nextInt(256);
    }
    print(base64.encode(key));
    print(base64.encode(params));
  }

  Encrypting() {
    setDataEncrypting();
  }*/

  Uint8List encrypt(String plainText) {
    var iv = params.sublist(2);

    var cipher = PaddedBlockCipherImpl(
      PKCS7Padding(),
      CBCBlockCipher(AESFastEngine()),
    )..init(
        true,
        PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
          ParametersWithIV<KeyParameter>(KeyParameter(key), iv),
          null,
        ),
      );

    var plainBytes = utf8.encode(base64.encode(utf8.encode(plainText)));
    var cipherText = cipher.process(Uint8List.fromList(plainBytes));

    return cipherText;
  }

  String decrypt(Uint8List cipherText) {
    var iv = params.sublist(2);

    var cipher = PaddedBlockCipherImpl(
      PKCS7Padding(),
      CBCBlockCipher(AESFastEngine()),
    );

    cipher.init(
      false /*decrypt*/,
      PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
        ParametersWithIV<KeyParameter>(KeyParameter(key), iv),
        null,
      ),
    );

    var plainishText = cipher.process(cipherText);
    print("cipherText: "+json.encode(cipherText));

    return (utf8.decode(base64.decode(utf8.decode(plainishText))));
  }
}
