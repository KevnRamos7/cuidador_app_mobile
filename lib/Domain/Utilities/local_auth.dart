import 'package:local_auth/local_auth.dart';

class LocalAuth{

  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
    await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async{
    try
    {
      if(!await _canAuthenticate()) return false; // Si no permite autenticacion, retorna falso

      return await _auth.authenticate(
        localizedReason: 'Por favor, autentiquese para continuar',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true
        ) 
      );
    }
    catch(exception)
    {
      return false;
    } 
  }

}