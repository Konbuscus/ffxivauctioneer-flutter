class FFXIVItem {
  int iD;
  String icon;
  String name;
  String url;
  String urlType;
  String s;
  int iScore;

  FFXIVItem(
      {this.iD,
      this.icon,
      this.name,
      this.url,
      this.urlType,
      this.s,
      this.iScore});

  FFXIVItem.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    icon = json['Icon'];
    name = json['Name'];
    url = json['Url'];
    urlType = json['UrlType'];
    s = json['_'];
    iScore = json['_Score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Icon'] = this.icon;
    data['Name'] = this.name;
    data['Url'] = this.url;
    data['UrlType'] = this.urlType;
    data['_'] = this.s;
    data['_Score'] = this.iScore;
    return data;
  }
}