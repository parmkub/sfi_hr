class LoginModel {
  String? uSERID;
  String? uSERNAME;
  String? nAME;
  String? eMPCODE;
  String? pOSITIONGROUP;
  String? pOSITIONFGROUPNAME;
  String? sECTCODE;
  String? dIVICODE;
  String? dEPARTCODE;
  String? pASSWORDAUTHEN;

  LoginModel(
      { required this.uSERID,
        required this.uSERNAME,
        required this.nAME,
        required this.eMPCODE,
        required this.pOSITIONGROUP,
        required this.pOSITIONFGROUPNAME,
        required this.sECTCODE,
        required this.dEPARTCODE,
        required this.dIVICODE,
        required this.pASSWORDAUTHEN});

  LoginModel.fromJson(Map<String, dynamic> json) {
    uSERID = json['USERID'];
    uSERNAME = json['USERNAME'];
    nAME = json['NAME'];
    eMPCODE = json['EMPCODE'];
    pOSITIONGROUP = json['POSITIONGROUP'];
    pOSITIONFGROUPNAME = json['POSITIONGROUPNAME'];
    sECTCODE = json['SECTCODE'];
    dIVICODE = json['DIVICODE'];
    dEPARTCODE = json['DEPARTCODE'];
    pASSWORDAUTHEN = json['PASS_AUTHEN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USERID'] = this.uSERID;
    data['USERNAME'] = this.uSERNAME;
    data['NAME'] = this.nAME;
    data['EMPCODE'] = this.eMPCODE;
    data['POSITIONGROUP'] = this.pOSITIONGROUP;
    data['POSITIONGROUPNAME'] = this.pOSITIONFGROUPNAME;
    data['SECTCODE']=this.sECTCODE;
    data['DIVICODE'] = this.dIVICODE;
    data['dEPARTCODE'] = this.dEPARTCODE;
    data['PASSWORDAUTHEN'] = this.pASSWORDAUTHEN;
    return data;
  }
}