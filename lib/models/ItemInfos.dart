class ItemInfos {
  List<History> history;
  String iD;
  bool isTracked;
  Item item;
  int itemID;
  String lodestoneID;
  List<Prices> prices;
  int server;
  int updatePriority;
  int updated;
  String currServer;

  ItemInfos(
      {this.history,
      this.iD,
      this.isTracked,
      this.item,
      this.itemID,
      this.lodestoneID,
      this.prices,
      this.server,
      this.updatePriority,
      this.updated,
      this.currServer});

  ItemInfos.fromJson(Map<String, dynamic> json) {
    if (json['History'] != null) {
      history = new List<History>();
      json['History'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
    iD = json['ID'];
    isTracked = json['IsTracked'];
    item = json['Item'] != null ? new Item.fromJson(json['Item']) : null;
    itemID = json['ItemID'];
    lodestoneID = json['LodestoneID'];
    if (json['Prices'] != null) {
      prices = new List<Prices>();
      json['Prices'].forEach((v) {
        prices.add(new Prices.fromJson(v));
      });
    }
    server = json['Server'];
    updatePriority = json['UpdatePriority'];
    updated = json['Updated'];
    currServer = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.history != null) {
      data['History'] = this.history.map((v) => v.toJson()).toList();
    }
    data['ID'] = this.iD;
    data['IsTracked'] = this.isTracked;
    if (this.item != null) {
      data['Item'] = this.item.toJson();
    }
    data['ItemID'] = this.itemID;
    data['LodestoneID'] = this.lodestoneID;
    if (this.prices != null) {
      data['Prices'] = this.prices.map((v) => v.toJson()).toList();
    }
    data['Server'] = this.server;
    data['UpdatePriority'] = this.updatePriority;
    data['Updated'] = this.updated;
    return data;
  }
}

class History {
  int added;
  String characterID;
  String characterName;
  String iD;
  bool isHQ;
  int pricePerUnit;
  int priceTotal;
  int purchaseDate;
  String purchaseDateMS;
  int quantity;

  History(
      {this.added,
      this.characterID,
      this.characterName,
      this.iD,
      this.isHQ,
      this.pricePerUnit,
      this.priceTotal,
      this.purchaseDate,
      this.purchaseDateMS,
      this.quantity});

  History.fromJson(Map<String, dynamic> json) {
    added = json['Added'];
    characterID = json['CharacterID'];
    characterName = json['CharacterName'];
    iD = json['ID'];
    isHQ = json['IsHQ'];
    pricePerUnit = json['PricePerUnit'];
    priceTotal = json['PriceTotal'];
    purchaseDate = json['PurchaseDate'];
    purchaseDateMS = json['PurchaseDateMS'];
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Added'] = this.added;
    data['CharacterID'] = this.characterID;
    data['CharacterName'] = this.characterName;
    data['ID'] = this.iD;
    data['IsHQ'] = this.isHQ;
    data['PricePerUnit'] = this.pricePerUnit;
    data['PriceTotal'] = this.priceTotal;
    data['PurchaseDate'] = this.purchaseDate;
    data['PurchaseDateMS'] = this.purchaseDateMS;
    data['Quantity'] = this.quantity;
    return data;
  }
}

class Item {
  int iD;
  String icon;
  int levelItem;
  String name;
  String nameDe;
  String nameEn;
  String nameFr;
  String nameJa;
  int rarity;

  Item(
      {this.iD,
      this.icon,
      this.levelItem,
      this.name,
      this.nameDe,
      this.nameEn,
      this.nameFr,
      this.nameJa,
      this.rarity});

  Item.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    icon = json['Icon'];
    levelItem = json['LevelItem'];
    name = json['Name'];
    nameDe = json['Name_de'];
    nameEn = json['Name_en'];
    nameFr = json['Name_fr'];
    nameJa = json['Name_ja'];
    rarity = json['Rarity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Icon'] = this.icon;
    data['LevelItem'] = this.levelItem;
    data['Name'] = this.name;
    data['Name_de'] = this.nameDe;
    data['Name_en'] = this.nameEn;
    data['Name_fr'] = this.nameFr;
    data['Name_ja'] = this.nameJa;
    data['Rarity'] = this.rarity;
    return data;
  }
}

class Prices {
  int added;
  String creatorSignatureID;
  String creatorSignatureName;
  String iD;
  bool isCrafted;
  bool isHQ;
  List<Null> materia;
  int pricePerUnit;
  int priceTotal;
  int quantity;
  String retainerID;
  String retainerName;
  int stainID;
  int townID;

  Prices(
      {this.added,
      this.creatorSignatureID,
      this.creatorSignatureName,
      this.iD,
      this.isCrafted,
      this.isHQ,
      this.materia,
      this.pricePerUnit,
      this.priceTotal,
      this.quantity,
      this.retainerID,
      this.retainerName,
      this.stainID,
      this.townID});

  Prices.fromJson(Map<String, dynamic> json) {
    added = json['Added'];
    creatorSignatureID = json['CreatorSignatureID'];
    creatorSignatureName = json['CreatorSignatureName'];
    iD = json['ID'];
    isCrafted = json['IsCrafted'];
    isHQ = json['IsHQ'];
    // if (json['Materia'] != null) {
    //   materia = new List<Null>();
    //   json['Materia'].forEach((v) {
    //     materia.add(new Null.fromJson(v));
    //   });
    // }
    pricePerUnit = json['PricePerUnit'];
    priceTotal = json['PriceTotal'];
    quantity = json['Quantity'];
    retainerID = json['RetainerID'];
    retainerName = json['RetainerName'];
    stainID = json['StainID'];
    townID = json['TownID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Added'] = this.added;
    data['CreatorSignatureID'] = this.creatorSignatureID;
    data['CreatorSignatureName'] = this.creatorSignatureName;
    data['ID'] = this.iD;
    data['IsCrafted'] = this.isCrafted;
    data['IsHQ'] = this.isHQ;
    // if (this.materia != null) {
    //   data['Materia'] = this.materia.map((v) => v.toJson()).toList();
    // }
    data['PricePerUnit'] = this.pricePerUnit;
    data['PriceTotal'] = this.priceTotal;
    data['Quantity'] = this.quantity;
    data['RetainerID'] = this.retainerID;
    data['RetainerName'] = this.retainerName;
    data['StainID'] = this.stainID;
    data['TownID'] = this.townID;
    return data;
  }
}