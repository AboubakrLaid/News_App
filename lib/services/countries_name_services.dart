import 'package:news/api/api.dart';
import 'package:news/models/country_name.dart';
import 'package:news/services/connectivity_services.dart';
import 'package:news/util/global_variables.dart';

class CountriesNameServices {
  //
  //
  Future<CountryName?> getCountryName(String countryCode) async {
    if (ConnectivityService.isDeviceConnected) {
      Api api = Api();
      String url =
          "https://restcountries.com/v3.1/alpha/$countryCode?fields=name,translations";
      final data = await api.sentRequest(url);
      //
      if (data != null) {
        log.d("get country name success");
        return CountryName.fromJson(data);
      }

      log.e("getting null response");
      return null;
    } else {
      log.d("no internet");
      return null;
    }
  }
}
