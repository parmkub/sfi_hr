class TeamModel {
  String? nAME;
  String? eMPCODE;
  String? pOSITION;
  String? sECTCODE;
  String? sECTNAME;
  String? dIVINAME;
  String? dEPARTNAME;
  String? gROUPCODE;
  String? pOSITIONGROUPNAME;

  TeamModel(
      {this.nAME,
        this.eMPCODE,
        this.pOSITION,
        this.sECTCODE,
        this.sECTNAME,
        this.dIVINAME,
        this.dEPARTNAME,
        this.gROUPCODE,
        this.pOSITIONGROUPNAME});

  TeamModel.fromJson(Map<String, dynamic> json) {
    nAME = json['NAME'];
    eMPCODE = json['EMP_CODE'];
    pOSITION = json['POSITION'];
    sECTCODE = json['SECT_CODE'];
    sECTNAME = json['SECT_NAME'];
    dIVINAME = json['DIVI_NAME'];
    dEPARTNAME = json['DEPART_NAME'];
    gROUPCODE = json['GROUPCODE'];
    pOSITIONGROUPNAME = json['POSITION_GROUP_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NAME'] = this.nAME;
    data['EMP_CODE'] = this.eMPCODE;
    data['POSITION'] = this.pOSITION;
    data['SECT_CODE'] = this.sECTCODE;
    data['SECT_NAME'] = this.sECTNAME;
    data['DIVI_NAME'] = this.dIVINAME;
    data['DEPART_NAME'] = this.dEPARTNAME;
    data['GROUPCODE'] = this.gROUPCODE;
    data['POSITION_GROUP_NAME'] = this.pOSITIONGROUPNAME;
    return data;
  }
}