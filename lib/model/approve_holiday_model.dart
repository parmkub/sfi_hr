
class ApproveHoliday {
  String? mAX;
  String? mIN;
  String? dAY;
  String? eMPLOYEECODE;
  String? aBSENCECODE;
  String? nAME;
  String? pOSITIONGROUPCODE;
  String? aBSENCEDAY;
  String? aBSENCEHOUR;
  String? dELETEMARK;
  String? aBSENCEPERIOD;
  String? aBSENCESTATUS;
  String? aBSENCETOKEN;
  String? aBSENCEDETAIL;
  String? aBSENCEDOCUMENT;
  String? cREATIONDATE;
  String? aBSENCEREVIWE;
  String? aBSENCEAPPROVE;

  ApproveHoliday(
      {this.mAX,
        this.mIN,
        this.dAY,
        this.eMPLOYEECODE,
        this.aBSENCECODE,
        this.nAME,
        this.pOSITIONGROUPCODE,
        this.aBSENCEDAY,
        this.aBSENCEHOUR,
        this.dELETEMARK,
        this.aBSENCEPERIOD,
        this.aBSENCESTATUS,
        this.aBSENCETOKEN,
        this.aBSENCEDETAIL,
        this.aBSENCEDOCUMENT,
        this.cREATIONDATE,this.aBSENCEREVIWE,this.aBSENCEAPPROVE});

  ApproveHoliday.fromJson(Map<String, dynamic> json) {
    mAX = json['MAX'];
    mIN = json['MIN'];
    dAY = json['DAY'];
    eMPLOYEECODE = json['EMPLOYEE_CODE'];
    aBSENCECODE = json['ABSENCE_CODE'];
    nAME = json['NAME'];
    pOSITIONGROUPCODE = json['POSITION_GROUP_CODE'];
    aBSENCEDAY = json['ABSENCE_DAY'];
    aBSENCEHOUR = json['ABSENCE_HOUR'];
    dELETEMARK = json['DELETE_MARK'];
    aBSENCEPERIOD = json['ABSENCE_PERIOD'];
    aBSENCESTATUS = json['ABSENCE_STATUS'];
    aBSENCETOKEN = json['ABSENCE_TOKEN'];
    aBSENCEDETAIL = json['ABSENCE_DETAIL'];
    aBSENCEDOCUMENT = json['ABSENCE_DOCUMENT'];
    cREATIONDATE = json['CREATION_DATE'];
    aBSENCEREVIWE = json['ABSENCE_REVIEW'];
    aBSENCEAPPROVE = json['ABSENCE_APPROVE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MAX'] = mAX;
    data['MIN'] = mIN;
    data['DAY'] = dAY;
    data['EMPLOYEE_CODE'] = eMPLOYEECODE;
    data['ABSENCE_CODE'] = aBSENCECODE;
    data['NAME'] = nAME;
    data['POSITION_GROUP_CODE'] = pOSITIONGROUPCODE;
    data['ABSENCE_DAY'] = aBSENCEDAY;
    data['ABSENCE_HOUR'] = aBSENCEHOUR;
    data['DELETE_MARK'] = dELETEMARK;
    data['ABSENCE_PERIOD'] = aBSENCEPERIOD;
    data['ABSENCE_STATUS'] = aBSENCESTATUS;
    data['ABSENCE_TOKEN'] = aBSENCETOKEN;
    data['ABSENCE_DETAIL'] = aBSENCEDETAIL;
    data['ABSENCE_DOCUMENT'] = aBSENCEDOCUMENT;
    data['CREATION_DATE'] = cREATIONDATE;
    data['ABSENCE_REVIEW'] = aBSENCEREVIWE;
    data['ABSENCE_APPROVE'] = aBSENCEAPPROVE;
    return data;
  }
}