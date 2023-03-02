class PublicizeModel {
  String? iD;
  String? pUBLICIZETITLE;
  String? tHUMNAIL;
  String? wEBVIEWTYPE;
  String? dETAIL;

  PublicizeModel({this.iD, this.pUBLICIZETITLE, this.tHUMNAIL,this.wEBVIEWTYPE,this.dETAIL});

  PublicizeModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    pUBLICIZETITLE = json['PUBLICIZE_TITLE'];
    tHUMNAIL = json['THUMNAIL'];
    wEBVIEWTYPE = json['WEBVIEWTYPE'];
    dETAIL = json['PUBLICIZE_DETAIL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['PUBLICIZE_TITLE'] = pUBLICIZETITLE;
    data['THUMNAIL'] = tHUMNAIL;
    data['WEBVIEWTYPE'] = wEBVIEWTYPE;
    data['PUBLICIZE_DETAIL'] = dETAIL;
    return data;
  }
}