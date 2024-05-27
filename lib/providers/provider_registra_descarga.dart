import 'package:http/http.dart';

Future<void> registraDescarga(int productoID, String? usuarioID) async {
  String url =
      'https://www.tarjetavecinopac.com/api/registraDescarga.php?productoID=$productoID&usuarioID=$usuarioID';

  await get(Uri.parse(url));
}
