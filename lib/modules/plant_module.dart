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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  double? price;
  double? listPrice;
  double? standardPrice;
  String? name;
  dynamic description;
  dynamic image256;
  dynamic vegetationType;
  dynamic plantAverageLifeSpan;
  dynamic plantMaxHeight;
  dynamic economicImportance;
  dynamic plantTemperature;
  List<int>? plantHabitImage;
  List<int>? plantStemImage;
  List<int>? plantLeafImage;
  List<int>? plantInflorescenceImage;
  List<int>? plantFlowerImage;

  Plants(
      {this.id,
        this.price,
        this.listPrice,
        this.standardPrice,
        this.name,
        this.description,
        this.image256});

  Plants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    listPrice = json['list_price'];
    standardPrice = json['standard_price'];
    name = json['name'];
    description = json['description'];
    image256 = json['image_256'];
    vegetationType= json['vegetation_type'];
    plantAverageLifeSpan= json['plant_average_life_span'];
    plantMaxHeight= json['plant_max_height'];
    economicImportance= json['x_EconomicImportance'];
    plantTemperature= json['plant_temperature'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['list_price'] = listPrice;
    data['standard_price'] = standardPrice;
    data['name'] = name;
    data['description'] = description;
    data['image_256'] = image256;
    data['vegetation_type']=vegetationType;
    data['plant_average_life_span']=plantAverageLifeSpan;
    data['plant_max_height']=plantMaxHeight;
    data['x_EconomicImportance']=economicImportance;
    data['plant_temperature']=plantTemperature;
    data['plant_habit_image'] = plantHabitImage;
    data['plant_stem_image'] = plantStemImage;
    data['plant_leaf_image'] = plantLeafImage;
    data['plant_inflorescence_image'] =  plantInflorescenceImage;
    data['plant_flower_image'] = plantFlowerImage;
    return data;
  }
}