class HomeStay {
  String? homestayId;
  String? userId;
  String? homestayName;
  String? homestayDesc;
  String? homestayPrice;
  String? homestaySleeps;
  String? homestayAvailable;
  String? homestayState;
  String? homestayLocal;
  String? homestayLat;
  String? homestayLng;
  String? homestayDate;

  HomeStay(
      {this.homestayId,
      this.userId,
      this.homestayName,
      this.homestayDesc,
      this.homestayPrice,
      this.homestaySleeps,
      this.homestayAvailable,
      this.homestayState,
      this.homestayLocal,
      this.homestayLat,
      this.homestayLng,
      this.homestayDate});

  HomeStay.fromJson(Map<String, dynamic> json) {
    homestayId = json['homestay_id'];
    userId = json['user_id'];
    homestayName = json['homestay_name'];
    homestayDesc = json['homestay_desc'];
    homestayPrice = json['homestay_price'];
    homestaySleeps = json['homestay_sleeps'];
    homestayAvailable = json['homestay_available'];
    homestayState = json['homestay_state'];
    homestayLocal = json['homestay_local'];
    homestayLat = json['homestay_lat'];
    homestayLng = json['homestay_lng'];
    homestayDate = json['homestay_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['homestay_id'] = homestayId;
    data['user_id'] = userId;
    data['homestay_name'] = homestayName;
    data['homestay_desc'] = homestayDesc;
    data['homestay_price'] = homestayPrice;
    data['homestay_sleeps'] = homestaySleeps;
    data['homestay_available'] = homestayAvailable;
    data['homestay_state'] = homestayState;
    data['homestay_local'] = homestayLocal;
    data['homestay_lat'] = homestayLat;
    data['homestay_lng'] = homestayLng;
    data['homestay_date'] = homestayDate;
    return data;
  }
}
