class CustomerListDataModel {
  int idCustomer;
  String name;
  String address;
  String? phone;
  String driverName;
  // String state;
  // int reservedBags;
  List<String> bags;

  CustomerListDataModel({
    required this.idCustomer,
    required this.name,
    required this.address,
    required this.phone,
    required this.driverName,
    // required this.state,
    // required this.reservedBags,
    required this.bags,
  });

  factory CustomerListDataModel.fromJson(Map<String, dynamic> json) {
    return CustomerListDataModel(
      idCustomer: json['id_customer'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String?,
      driverName: json['driverName'] as String,
      // state: json['state'] as String,
      // reservedBags: json['reserved_bags'] as int,
      bags: List<String>.from(json['bags'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_customer': idCustomer,
      'name': name,
      'address': address,
      'phone': phone,
      'driverName': driverName,
      // 'state': state,
      // 'reserved_bags': reservedBags,
      'bags': bags,
    };
  }
}
