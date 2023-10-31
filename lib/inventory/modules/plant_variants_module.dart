import 'dart:ffi';
class PlantVariantsResponseModule {
  int? count;
  Null? prev;
  int? current;
  Null? next;
  int? totalPages;
  List<PlantVariants>? result;

  PlantVariantsResponseModule(
      {this.count,
        this.prev,
        this.current,
        this.next,
        this.totalPages,
        this.result});

  PlantVariantsResponseModule.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    prev = json['prev'];
    current = json['current'];
    next = json['next'];
    totalPages = json['total_pages'];
    if (json['result'] != null) {
      result = <PlantVariants>[];
      json['result'].forEach((v) {
        result!.add(new PlantVariants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['prev'] = this.prev;
    data['current'] = this.current;
    data['next'] = this.next;
    data['total_pages'] = this.totalPages;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlantVariants {
  int? id;
  String? name;
  double? baseUnitCount;
  int? productVariantCount;
  List<AttributeLineIds>? attributeLineIds;

  PlantVariants(
      {this.id,
        this.name,
        this.baseUnitCount,
        this.productVariantCount,
        this.attributeLineIds});

  PlantVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    baseUnitCount = json['base_unit_count'];
    productVariantCount = json['product_variant_count'];
    if (json['attribute_line_ids'] != null) {
      attributeLineIds = <AttributeLineIds>[];
      json['attribute_line_ids'].forEach((v) {
        attributeLineIds!.add(new AttributeLineIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['base_unit_count'] = this.baseUnitCount;
    data['product_variant_count'] = this.productVariantCount;

    if (this.attributeLineIds != null) {
      data['attribute_line_ids'] =
          this.attributeLineIds!.map((v) => v.toJson()).toList();
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
        valueIds!.add(new ValueIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_name'] = this.displayName;
    if (this.valueIds != null) {
      data['value_ids'] = this.valueIds!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}