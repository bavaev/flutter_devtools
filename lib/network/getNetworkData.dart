import 'package:http/http.dart' as http;

class Network {
  Future<http.Response> fetchData() async {
    return await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
  }

  void loadData() {
    fetchData().then((response) {
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.statusCode);
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
}
