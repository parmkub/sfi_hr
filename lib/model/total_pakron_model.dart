class TotalPakronModel {
  String? cLAINPAKRON;
  String? uSEPAKRON;
  String? dIFFPAKRON;

  TotalPakronModel({this.cLAINPAKRON, this.uSEPAKRON, this.dIFFPAKRON});

  TotalPakronModel.fromJson(Map<String, dynamic> json) {
    cLAINPAKRON = json['CLAIN_PAKRON'];
    uSEPAKRON = json['USE_PAKRON'];
    dIFFPAKRON = json['DIFF_PAKRON'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CLAIN_PAKRON'] = this.cLAINPAKRON;
    data['USE_PAKRON'] = this.uSEPAKRON;
    data['DIFF_PAKRON'] = this.dIFFPAKRON;
    return data;
  }
}