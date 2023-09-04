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
  bool? image256;

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
    return data;
  }
}