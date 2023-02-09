class LoginModel {
  String? uSERID;
  String? uSERNAME;
  String? eMPCODE;
  String? pOSITIONGROUP;
  String? pOSITIONFGROUPNAME;
  String? sECTCODE;
  String? dIVICODE;
  String? dEPARTCODE;

  LoginModel(
      { required this.uSERID,
        required this.uSERNAME,
        required this.eMPCODE,
        required this.pOSITIONGROUP,
        required this.pOSITIONFGROUPNAME,
        required this.sECTCODE,
        required this.dEPARTCODE,
        required this.dIVICODE});

  LoginModel.fromJson(Map<String, dynamic> json) {
    uSERID = json['USERID'];
    uSERNAME = json['USERNAME'];
    eMPCODE = json['EMPCODE'];
    pOSITIONGROUP = json['POSITIONGROUP'];
    pOSITIONFGROUPNAME = json['POSITIONGROUPNAME'];
    sECTCODE = json['SECTCODE'];
    dIVICODE = json['DIVICODE'];
    dEPARTCODE = json['DEPARTCODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USERID'] = this.uSERID;
    data['USERNAME'] = this.uSERNAME;
    data['EMPCODE'] = this.eMPCODE;
    data['POSITIONGROUP'] = this.pOSITIONGROUP;
    data['POSITIONGROUPNAME'] = this.pOSITIONFGROUPNAME;
    data['SECTCODE']=this.sECTCODE;
    data['DIVICODE'] = this.dIVICODE;
    data['dEPARTCODE'] = this.dEPARTCODE;
    return data;
  }
}