import 'dart:convert';
import 'package:covid19_tracker/ViewModel/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:covid19_tracker/Model/world_stats_model.dart';


class WorldStatesViewModel{
  Future<WorldStatsModel> fetchWorldRecords () async {
    final response = await http.get(Uri.parse(AppUrl.worldStatsApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> fetchCountriesRecords () async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}

