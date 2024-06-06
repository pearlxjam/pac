import 'package:http/http.dart' as http;

class RemotePopularProductService {
  var client = http.Client();
  var remoteUrl = 'https://www.tarjetavecinopac.com/api/productos_inicio.php';

  Future<dynamic> get() async {
    var response = await client.get(Uri.parse(remoteUrl));
    return response;
  }
}
