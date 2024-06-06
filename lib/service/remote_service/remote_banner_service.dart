import 'package:http/http.dart' as http;

class RemoteBannerService {
  var client = http.Client();
  var remoteUrl = 'https://www.tarjetavecinopac.com/api/banner.php';

  Future<dynamic> get() async {
    var response = await client.get(Uri.parse('$remoteUrl?populate=image'));
    return response;
  }
}
