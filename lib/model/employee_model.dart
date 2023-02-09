class EmployeeModel {
  String? nAME;
  String? gENDER;
  String? hIREDATE;
  String? eMPLOYEECODE;
  String? sECTCODE;
  String? sECTNAME;
  String? dIVICODE;
  String? dIVINAME;
  String? dEPARTCODE;
  String? dEPARTNAME;
  String? pOSITIONNAME;
  String? pOSITIONGROUPNAME;
  String? nATIONALITYCODE;
  String? nATIONALITY;
  String? cOMPANYNAME;

  EmployeeModel(
      {this.nAME,
        this.gENDER,
        this.hIREDATE,
        this.eMPLOYEECODE,
        this.sECTCODE,
        this.sECTNAME,
        this.dIVICODE,
        this.dIVINAME,
        this.dEPARTCODE,
        this.dEPARTNAME,
        this.pOSITIONNAME,
        this.pOSITIONGROUPNAME,
        this.nATIONALITYCODE,
        this.nATIONALITY,
        this.cOMPANYNAME});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    nAME = json['NAME'];
    gENDER = json['GENDER'];
    hIREDATE = json['HIRE_DATE'];
    eMPLOYEECODE = json['EMPLOYEE_CODE'];
    sECTCODE = json['SECT_CODE'];
    sECTNAME = json['SECT_NAME'];
    dIVICODE = json['DIVI_CODE'];
    dIVINAME = json['DIVI_NAME'];
    dEPARTCODE = json['DEPART_CODE'];
    dEPARTNAME = json['DEPART_NAME'];
    pOSITIONNAME = json['POSITION_NAME'];
    pOSITIONGROUPNAME = json['POSITION_GROUP_NAME'];
    nATIONALITYCODE = json['NATIONALITY_CODE'];
    nATIONALITY = json['NATIONALITY'];
    cOMPANYNAME = json['COMPANY_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NAME'] = nAME;
    data['GENDER'] = gENDER;
    data['HIRE_DATE'] = hIREDATE;
    data['EMPLOYEE_CODE'] = eMPLOYEECODE;
    data['SECT_CODE'] = sECTCODE;
    data['SECT_NAME'] = sECTNAME;
    data['DIVI_CODE'] = dIVICODE;
    data['DIVI_NAME'] = dIVINAME;
    data['DEPART_CODE'] = dEPARTCODE;
    data['DEPART_NAME'] = dEPARTNAME;
    data['POSITION_NAME'] = pOSITIONNAME;
    data['POSITION_GROUP_NAME'] = pOSITIONGROUPNAME;
    data['NATIONALITY_CODE'] = nATIONALITYCODE;
    data['NATIONALITY'] = nATIONALITY;
    data['COMPANY_NAME'] = cOMPANYNAME;
    return data;
  }
}