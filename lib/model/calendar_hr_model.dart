class CarlendarHrModel {
  String? sTARTDAY;
  String? eNDDAY;
  String? dETAIL;
  String? aCTIVITYTYPE;
  String? cOLORTYPE;

  CarlendarHrModel(
      {this.sTARTDAY,
        this.eNDDAY,
        this.dETAIL,
        this.aCTIVITYTYPE,
        this.cOLORTYPE});

  CarlendarHrModel.fromJson(Map<String, dynamic> json) {
    sTARTDAY = json['START_DAY'];
    eNDDAY = json['END_DAY'];
    dETAIL = json['DETAIL'];
    aCTIVITYTYPE = json['ACTIVITY_TYPE'];
    cOLORTYPE = json['COLOR_TYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['START_DAY'] = sTARTDAY;
    data['END_DAY'] = eNDDAY;
    data['DETAIL'] = dETAIL;
    data['ACTIVITY_TYPE'] = aCTIVITYTYPE;
    data['COLOR_TYPE'] = cOLORTYPE;
    return data;
  }
}