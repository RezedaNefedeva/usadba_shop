
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedOrderDataBase {
  Future<void> init();

  Future<T> getOrder<T>(String key, T defaultValue);

  Future<void> setOrder<T>(String key, T value);
  
  Future<void> deleteOrder<T>(String key, T value);
  
  Future<void> updateOrder<T>(String key, T value);

}

class SharedOrderPrefs extends SharedOrderDataBase{
  SharedOrderPrefs();

  late final SharedPreferences _prefs;

  @override
  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  @override
  Future<void> deleteOrder<T>(String key, T value) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<T> getOrder<T>(String key, T defaultValue) {
    // TODO: implement getOrder
    throw UnimplementedError();
  }

  @override
  Future<void> setOrder<T>(String key, T value) {
    // TODO: implement setOrder
    throw UnimplementedError();
  }

  @override
  Future<void> updateOrder<T>(String key, T value) {
    // TODO: implement updateOrder
    throw UnimplementedError();
  }
  
}



