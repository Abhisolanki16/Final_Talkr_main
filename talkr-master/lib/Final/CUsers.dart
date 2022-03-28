class cUser{
  String? username = '';
  String? email = '';
  String? uid = '';

  cUser({this.email,this.uid,  this.username});

  // ignore: non_constant_identifier_names
  cUser.FromJson(Map<String,dynamic> json){
    email: json['email'];
    username: json['username'];
    uid: json['uid'];
  }

  Map<String,dynamic> toJSon(){
    return {"uid": uid,"email": email,"username": username};
  }

  cUser.fromMap(Map<String,dynamic> map){
    uid = map['uid'];
    username = map['username'];
    email = map['email'];
  }

}