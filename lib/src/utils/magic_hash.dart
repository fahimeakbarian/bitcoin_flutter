import 'dart:typed_data';
import 'dart:convert';

import 'varuint.dart';
import '../../src/crypto.dart';
import '../../src/models/networks.dart';

Uint8List magicHash(String message, [NetworkType network = mainnet]) {
  Uint8List messagePrefix = utf8.encode(network.messagePrefix) as Uint8List;
  int messageVISize = encodingLength(message.length);
  int length = messagePrefix.length + messageVISize + message.length;
  Uint8List buffer = new Uint8List(length);
  buffer.setRange(0, messagePrefix.length, messagePrefix);
  encode(message.length, buffer, messagePrefix.length);
  buffer.setRange(
      messagePrefix.length + messageVISize, length, utf8.encode(message));
  return hash256(buffer);
}
