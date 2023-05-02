


class Usermodel {
String? name;
String? email;
String? phone;
String? image;
String? token;
  Usermodel({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.token,
  });
//named constructor will Assign the values ​​to the new variables get data
Usermodel.fromjson({required Map<String,dynamic>data}){
  //refactoring map or json
  name=data['name'];
  email=data['email'];
  phone=data['phone'];
  image=data['image'];
 token=data['token'];

}
//to map data inside the model i want to convert it into a map send data
Map<String,dynamic>toMap(){
  return {
    'name':name,
    'email':email,
    'phone':phone,
    'image':image,
    'token':token
  };
}

}
