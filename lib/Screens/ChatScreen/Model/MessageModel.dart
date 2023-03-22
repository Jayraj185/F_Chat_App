class MessageModel {
  MessageModel({
   required this.toId,
   required this.fromId,
   required this.message,
   required this.read,
   required this.sent,
   required this.type,
  });

  String? toId;
  String? fromId;
  String? message;
  String? read;
  String? sent;
  Type? type;

  MessageModel.fromJson(dynamic json) {
    toId = json['toId'].toString();
    fromId = json['fromId'].toString();
    message = json['message'].toString();
    read = json['read'].toString();
    sent = json['sent'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['toId'] = toId;
    map['fromId'] = fromId;
    map['message'] = message;
    map['read'] = read;
    map['sent'] = sent;
    map['type'] = type!.name;
    return map;
  }
}

enum Type { text, image }
