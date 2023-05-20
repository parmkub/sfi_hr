class LeavingCard {
  String? sTARTDATE;
  String? eNDDATE;
  String? cOUNTDATE;
  String? eMPLOYEECODE;
  String? aBSENCECODE;
  String? aBSENCEDAY;
  String? aBSENCEHOUR;
  String? dELETEMARK;
  String? rEVIEW;
  String? aPPROVE;
  String? aBSENCEPERIOD;
  String? aBSENCESTATUS;
  String? aBSENCETOKEN;
  String? aBSENCEDETAIL;
  String? aBSENCEDOCUMENT;
  String? cREATIONDATE;
  String? sTATUSAPPROVE;

  LeavingCard(
      {
        this.sTARTDATE,
        this.eNDDATE,
        this.cOUNTDATE,
        this.eMPLOYEECODE,
        this.aBSENCECODE,
        this.aBSENCEDAY,
        this.aBSENCEHOUR,
        this.dELETEMARK,
        this.rEVIEW,
        this.aPPROVE,
        this.aBSENCEPERIOD,
        this.aBSENCESTATUS,
        this.aBSENCETOKEN,
        this.aBSENCEDETAIL,
        this.aBSENCEDOCUMENT,
        this.cREATIONDATE,
        this.sTATUSAPPROVE,});

  LeavingCard.fromJson(Map<String, dynamic> json) {
    sTARTDATE = json['START_DATE'];
    eNDDATE = json['END_DATE'];
    cOUNTDATE = json['COUNT_DATE'];
    eMPLOYEECODE = json['EMPLOYEE_CODE'];
    aBSENCECODE = json['ABSENCE_CODE'];
    aBSENCEDAY = json['ABSENCE_DAY'];
    aBSENCEHOUR = json['ABSENCE_HOUR'];
    dELETEMARK = json['DELETE_MARK'];
    rEVIEW = json['REVIEW'];
    aPPROVE = json['APPROVE'];
    aBSENCEPERIOD = json['ABSENCE_PERIOD'];
    aBSENCESTATUS = json['ABSENCE_STATUS'];
    aBSENCETOKEN = json['ABSENCE_TOKEN'];
    aBSENCEDETAIL = json['ABSENCE_DETAIL'];
    aBSENCEDOCUMENT = json['ABSENCE_DOCUMENT'];
    cREATIONDATE = json['CREATION_DATE'];
    sTATUSAPPROVE = json['STATUS_APPROVE'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['START_DATE'] = sTARTDATE;
    data['END_DATE']= eNDDATE;
    data['COUNT_DATE'] = cOUNTDATE;
    data['EMPLOYEE_CODE'] = eMPLOYEECODE;
    data['ABSENCE_CODE'] = aBSENCECODE;
    data['ABSENCE_DAY'] = aBSENCEDAY;
    data['ABSENCE_HOUR'] = aBSENCEHOUR;
    data['DELETE_MARK'] = dELETEMARK;
    data['REVIEW'] = rEVIEW;
    data['APPROVE'] = aPPROVE;
    data['ABSENCE_PERIOD'] = aBSENCEPERIOD;
    data['ABSENCE_STATUS'] = aBSENCESTATUS;
    data['ABSENCE_TOKEN'] = aBSENCETOKEN;
    data['ABSENCE_DETAIL'] = aBSENCEDETAIL;
    data['ABSENCE_DOCUMENT'] = aBSENCEDOCUMENT;
    data['CREATION_DATE'] = cREATIONDATE;
    data['STATUS_APPROVE'] = sTATUSAPPROVE;
    return data;
  }
}
