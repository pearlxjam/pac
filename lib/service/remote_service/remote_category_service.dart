import 'package:http/http.dart' as http;

class RemoteCategoryService {
  var client = http.Client();
  var remoteUrl = 'https://www.tarjetavecinopac.com/api/categorias.php';

  Future<dynamic> get() async {
    var response = await client.get(Uri.parse(remoteUrl));
    return response;
  }
}
