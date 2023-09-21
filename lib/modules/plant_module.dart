class PlantsResponseModule {
  int? count;
  int? prev;
  int? current;
  int? next;
  int? totalPages;
  List<Plants>? result;

  PlantsResponseModule(
      {this.count,
        this.prev,
        this.current,
        this.next,
        this.totalPages,
        this.result});

  PlantsResponseModule.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    prev = json['prev'];
    current = json['current'];
    next = json['next'];
    totalPages = json['total_pages'];
    if (json['result'] != null) {
      result = <Plants>[];
      json['result'].forEach((v) {
        result!.add(Plants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['prev'] = prev;
    data['current'] = current;
    data['next'] = next;
    data['total_pages'] = totalPages;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plants {
  int? id;
  String? name;
  Category? category;
  // dynamic description;
  dynamic vegetationType;
  dynamic origin;
  dynamic canopyType;
  dynamic economicImportance;
  dynamic waterFrequency;
  List<int>? plantHabitImage;
  List<int>? plantStemImage;
  List<int>? plantLeafImage;
  List<int>? plantInflorescenceImage;
  List<int>? plantFlowerImage;
  List<AttributeLineIds>? attributeLineIds;

  Plants(
      {this.id,
        this.name,
        this.category});

  Plants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['categ_id'] != null
        ? Category.fromJson(json['categ_id'])
        : null;
    origin = json["origin"];
    canopyType = json["x_CanopyType"];
    vegetationType= json['vegetation_type'];
    economicImportance= json['x_EconomicValue'];
    waterFrequency= json['x_Waterfrequency'];
    if(json['plant_habit_image']!=null){
      plantHabitImage = json['plant_habit_image'].cast<int>();
    }

    if(json['plant_stem_image']!=null){
      plantStemImage = json['plant_stem_image'].cast<int>();
    }

    if(json['plant_leaf_image']!=null){
      plantLeafImage = json['plant_leaf_image'].cast<int>();
    }

    if(json['plant_inflorescence_image']!=null){
      plantLeafImage = json['plant_inflorescence_image'].cast<int>();
    }

    if(json['plant_flower_image']!=null){
      plantLeafImage = json['plant_flower_image'].cast<int>();
    }
    if (json['attribute_line_ids'] != null) {
      attributeLineIds = <AttributeLineIds>[];
      json['attribute_line_ids'].forEach((v) {
        attributeLineIds!.add(AttributeLineIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if(data['categ_id']!=null){
      data['categ_id'] = category!.toJson();
    }
    data['vegetation_type']=vegetationType;
    data['x_EconomicImportance']=economicImportance;
    data['plant_habit_image'] = plantHabitImage;
    data['plant_stem_image'] = plantStemImage;
    data['plant_leaf_image'] = plantLeafImage;
    data['plant_inflorescence_image'] =  plantInflorescenceImage;
    data['x_Waterfrequency'] = waterFrequency;
    data['plant_flower_image'] = plantFlowerImage;
    if (attributeLineIds != null) {
      data['attribute_line_ids'] =
          attributeLineIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttributeLineIds {
  String? displayName;
  List<ValueIds>? valueIds;

  AttributeLineIds({this.displayName, this.valueIds});

  AttributeLineIds.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    if (json['value_ids'] != null) {
      valueIds = <ValueIds>[];
      json['value_ids'].forEach((v) {
        valueIds!.add(ValueIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['display_name'] = displayName;
    if (valueIds != null) {
      data['value_ids'] = valueIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ValueIds {
  String? name;

  ValueIds({this.name});

  ValueIds.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Category {
  String? name;

  Category({this.name});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}