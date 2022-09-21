import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:paap/domain/entities/usuario.dart';

class SecureStorage {
  static const storage = FlutterSecureStorage();

  static Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  static Future setUsuario(UsuarioEntity usuario) async =>
      await storage.write(key: 'usuario', value: usuarioToJson(usuario));

  static Future<UsuarioEntity?> getUsuario() async {
    final usuario = await storage.read(key: 'usuario');
    if (usuario != null) {
      return usuarioFromJson(usuario);
    } else {
      return null;
    }
  }
}
