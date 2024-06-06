import 'package:http/http.dart' as http;

class RemoteProductService {
  var client = http.Client();
  var remoteUrl = 'https://www.tarjetavecinopac.com/api/productos_inicio.php';

  Future<dynamic> get() async {
    var url = remoteUrl;
    var response = await client.get(Uri.parse(url));
    return response;
  }

  Future<dynamic> getByName({required String keyword}) async {
    var url = '$remoteUrl?search=$keyword';
    var response = await client.get(Uri.parse(url));
    return response;
  }

  Future<dynamic> getByCategory({required int id}) async {
    var url = '$remoteUrl?categoria=$id';
    var response = await client.get(Uri.parse(url));

    return response;
  }
}
