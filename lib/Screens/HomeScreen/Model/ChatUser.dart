/// name : "Jayraj Ahir"
/// email : "ahirjayraj185@gmail.com"
/// image : "https://lh3.googleusercontent.com/a/AGNmyxaz-cVUoR78v4ZgwDr-zLqVSg0PGq-nXDvq--h5=s96-c"
/// about : "Flutter Devloper"
/// isOnline : false
/// lastActive : "yesterday"
/// id : "w5TJvu6qSCE1F0uHf0mN"
/// lastMessage : "hiiii"
/// uid : "y63NnpwiQIUXeTQERJDKURettor2"

class ChatUser {
  ChatUser({
      String? name, 
      String? email, 
      String? image, 
      String? about, 
      bool? isOnline, 
      String? lastActive, 
      String? id, 
      String? lastMessage, 
      String? uid,
      String? Tocken,
  }){
    _name = name;
    _email = email;
    _image = image;
    _about = about;
    _isOnline = isOnline;
    _lastActive = lastActive;
    _id = id;
    _lastMessage = lastMessage;
    _uid = uid;
    _Token = Tocken;
}

  ChatUser.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _image = json['image'];
    _about = json['about'];
    _isOnline = json['isOnline'];
    _lastActive = json['lastActive'];
    _id = json['id'];
    _lastMessage = json['lastMessage'];
    _uid = json['uid'];
    _Token = json['token'];
  }
  String? _name;
  String? _email;
  String? _image;
  String? _about;
  bool? _isOnline;
  String? _lastActive;
  String? _id;
  String? _lastMessage;
  String? _uid;
  String? _Token;
ChatUser copyWith({  String? name,
  String? email,
  String? image,
  String? about,
  bool? isOnline,
  String? lastActive,
  String? id,
  String? lastMessage,
  String? uid,
  String? Token,
}) => ChatUser(  name: name ?? _name,
  email: email ?? _email,
  image: image ?? _image,
  about: about ?? _about,
  isOnline: isOnline ?? _isOnline,
  lastActive: lastActive ?? _lastActive,
  id: id ?? _id,
  lastMessage: lastMessage ?? _lastMessage,
  uid: uid ?? _uid,
  Tocken: Token ?? _Token,
);
  String? get name => _name;
  String? get email => _email;
  String? get image => _image;
  String? get about => _about;
  bool? get isOnline => _isOnline;
  String? get lastActive => _lastActive;
  String? get id => _id;
  String? get lastMessage => _lastMessage;
  String? get uid => _uid;
  String? get Token => _Token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['image'] = _image;
    map['about'] = _about;
    map['isOnline'] = _isOnline;
    map['lastActive'] = _lastActive;
    map['id'] = _id;
    map['lastMessage'] = _lastMessage;
    map['uid'] = _uid;
    map['token'] = _Token;
    return map;
  }

}