import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Api {
  String base_url = "https://collectionapi.metmuseum.org/public/collection/v1/";
  Map endpoints = {
    "objects":
        "objects", // A listing of all valid Object IDs available for access
    "departments": "department", //  A listing of all valid departments
    "search": "search"
  };

  Future<Map> getAllCollectionObjectID() async {
    // dmd kung tanan oy, mamatay tag hinuwat, wa rabay offset or pagination or perPage pota
    // kani nalang
    var url = Uri.parse("$base_url" + "search?isHighlight=true&dateBegin=1700&dateEnd=1800&q=France");
    var res;
    try {
      res = await http.get(url);

      if (res.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;

        return jsonResponse;
      }

      print("Request failed with status: ${res.statusCode}");
    } catch (e) {
      print("GET ALL COLLECTION OBJECT ID ERROR: " + e.toString());
    }

    return {};
  }

  Future<Map> getObjectInfo({id}) async {
    var url = Uri.parse("$base_url" + "${endpoints['objects']}/$id");
    var res;
    try {

      res = await http.get(url);

      if (res.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(res.body) as Map;

        return jsonResponse;
      }

      print("Request failed with status: ${res.statusCode}");
    } catch (e) {
      print("REQUEST FAILED while getting Object Info: " + e.toString());
    }
    
    return {};
  }
}
