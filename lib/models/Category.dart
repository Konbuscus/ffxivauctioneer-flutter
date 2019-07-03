class Category {
  int category;
  String classJobTarget;
  int classJobTargetID;
  int iD;
  String icon;
  int iconID;
  String name;
  String nameDe;
  String nameEn;
  String nameFr;
  String nameJa;
  int order;
  String url;

  Category(
      {this.category,
      this.classJobTarget,
      this.classJobTargetID,
      this.iD,
      this.icon,
      this.iconID,
      this.name,
      this.nameDe,
      this.nameEn,
      this.nameFr,
      this.nameJa,
      this.order,
      this.url});

  Category.fromJson(Map<String, dynamic> json) {
    category = json['Category'];
    classJobTarget = json['ClassJobTarget'];
    classJobTargetID = json['ClassJobTargetID'];
    iD = json['ID'];
    icon = json['Icon'];
    iconID = json['IconID'];
    name = json['Name'];
    nameDe = json['Name_de'];
    nameEn = json['Name_en'];
    nameFr = json['Name_fr'];
    nameJa = json['Name_ja'];
    order = json['Order'];
    url = json['Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Category'] = this.category;
    data['ClassJobTarget'] = this.classJobTarget;
    data['ClassJobTargetID'] = this.classJobTargetID;
    data['ID'] = this.iD;
    data['Icon'] = this.icon;
    data['IconID'] = this.iconID;
    data['Name'] = this.name;
    data['Name_de'] = this.nameDe;
    data['Name_en'] = this.nameEn;
    data['Name_fr'] = this.nameFr;
    data['Name_ja'] = this.nameJa;
    data['Order'] = this.order;
    data['Url'] = this.url;
    return data;
  }
}