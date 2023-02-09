class PublicizeModel {
  String? iD;
  String? pUBLICIZETITLE;
  String? tHUMNAIL;

  PublicizeModel({this.iD, this.pUBLICIZETITLE, this.tHUMNAIL});

  PublicizeModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    pUBLICIZETITLE = json['PUBLICIZE_TITLE'];
    tHUMNAIL = json['THUMNAIL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['PUBLICIZE_TITLE'] = pUBLICIZETITLE;
    data['THUMNAIL'] = tHUMNAIL;
    return data;
  }
}