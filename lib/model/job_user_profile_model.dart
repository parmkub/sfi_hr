class JobUserProfileModel {
  String? iD;
  String? eMAIL;
  String? pASSWORD;
  String? pHONE;
  String? fIRSTNAME;
  String? lASTNAME;
  String? aDDRESS;
  String? cREATEDATE;
  String? uPDATEDATE;

  JobUserProfileModel(
      {iD,
        eMAIL,
        pASSWORD,
        pHONE,
        fIRSTNAME,
        lASTNAME,
        aDDRESS,
        cREATEDATE,
        uPDATEDATE});

  JobUserProfileModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    eMAIL = json['EMAIL'];
    pASSWORD = json['PASSWORD'];
    pHONE = json['PHONE'];
    fIRSTNAME = json['FIRST_NAME'];
    lASTNAME = json['LAST_NAME'];
    aDDRESS = json['ADDRESS'];
    cREATEDATE = json['CREATE_DATE'];
    uPDATEDATE = json['UPDATE_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = iD;
    data['EMAIL'] = eMAIL;
    data['PASSWORD'] = pASSWORD;
    data['PHONE'] = pHONE;
    data['FIRST_NAME'] = fIRSTNAME;
    data['LAST_NAME'] = lASTNAME;
    data['ADDRESS'] = aDDRESS;
    data['CREATE_DATE'] = cREATEDATE;
    data['UPDATE_DATE'] = uPDATEDATE;
    return data;
  }
}