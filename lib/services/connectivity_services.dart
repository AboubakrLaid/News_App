import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
 static StreamController<bool> myStreamController = StreamController<bool>.broadcast();
 static late bool isDeviceConnected ;
  ConnectivityService() {
    
    _init();
    Connectivity().onConnectivityChanged.listen((event) async {
       await _init();
  

    });
  }
 static initIsDeviceConnected()async{
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
  }
  _init() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    myStreamController.add(isDeviceConnected);
  }

  close(){
    myStreamController.close();
  }
}
