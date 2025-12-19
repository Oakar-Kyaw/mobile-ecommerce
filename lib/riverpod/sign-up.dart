
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupNotifier extends Notifier<Map<String, String>?> {
  @override
  Map<String,String>? build(){
    return null ;
  }

  void save(Map<String, String> data){
    state = data;
  }

  Map<String,String>? get(){
    return state;
  }

  void clear () {
    state = null;
  }
}

final signUpDataProvider = NotifierProvider<SignupNotifier, Map<String,String>?> ((){
   return SignupNotifier();
});