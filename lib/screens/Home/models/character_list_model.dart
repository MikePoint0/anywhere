class CharacterList {
  List<RelatedTopics>? relatedTopics;


  CharacterList(
      {
        this.relatedTopics});

  CharacterList.fromJson(Map<dynamic, dynamic> json) {
    if (json['RelatedTopics'] != null) {
      relatedTopics = <RelatedTopics>[];
      json['RelatedTopics'].forEach((v) {
        relatedTopics!.add(new RelatedTopics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.relatedTopics != null) {
      data['RelatedTopics'] =
          this.relatedTopics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RelatedTopics {
  String? firstURL;
  Iconn? icon;
  String? result;
  String? text;

  RelatedTopics(this.firstURL, this.icon, this.result, this.text);

  RelatedTopics.fromJson(Map<String, dynamic> json) {
    firstURL = json['FirstURL'];
    icon = json['Icon'] != null ? new Iconn.fromJson(json['Icon']) : null;
    result = json['Result'];
    text = json['Text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FirstURL'] = this.firstURL;
    if (this.icon != null) {
      data['Icon'] = this.icon!.toJson();
    }
    data['Result'] = this.result;
    data['Text'] = this.text;
    return data;
  }
}

class Iconn {
  String? height;
  String? uRL;
  String? width;

  Iconn(this.height, this.uRL, this.width);

  Iconn.fromJson(Map<String, dynamic> json) {
    height = json['Height'];
    uRL = json['URL'];
    width = json['Width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Height'] = this.height;
    data['URL'] = this.uRL;
    data['Width'] = this.width;
    return data;
  }
}