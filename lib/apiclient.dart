import 'package:http/http.dart' as http;

class Apiclient {
  String baseUrl = "";
  bool islocal = true;
  Apiclient(){
    islocal = true;
    if(islocal){
      baseUrl = "http://localhost:3000";
    }else{
      baseUrl = "https://rochatter.herokuapp.com";
    }
  }
  
}
