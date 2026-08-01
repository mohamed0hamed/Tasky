import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {



  PreferenceManager._internal();
  static final PreferenceManager _instance = PreferenceManager._internal();


  factory PreferenceManager(){
    return _instance ;
  }

late final SharedPreferences _preference ;

 Future<void> init()async
{
  _preference = await SharedPreferences.getInstance();
}


String? getString (String key)
{
 return _preference.getString(key);
}

bool? getBool(String key)
{
 return _preference.getBool(key);
}

Future<bool> setString (String key ,String value)async
{
 return await _preference. setString(key, value);
}

Future <bool> setBool(String key , bool value)
{
 return _preference.setBool(key , value);
}

Future<bool> remove(String key)async
{
 return await _preference.remove(key);
}

}

