class ChangHolidayModel {
  String? nAME;
  String? eMPLOYEECODE;
  String? aBSENCESTATUS;
  String? aBSENCEDATEFROM;
  String? aBSENCEDATETO;
  String? aBSENCEDOCUMENT;
  String? aBSENCEDAY;
  String? aBSENCEHOUR;
  String? aBSENCEREVIEW;
  String? aBSENCEAPPROVE;
  String? sTATUSAPPROVE;
  String? cREATIONDATE;
  String? tOKEN;

  ChangHolidayModel(
      {this.nAME,
        this.eMPLOYEECODE,
        this.aBSENCESTATUS,
        this.aBSENCEDATEFROM,
        this.aBSENCEDATETO,
        this.aBSENCEDOCUMENT,
        this.aBSENCEDAY,
        this.aBSENCEHOUR,
        this.aBSENCEREVIEW,
        this.aBSENCEAPPROVE,
        this.sTATUSAPPROVE,
        this.cREATIONDATE,
        this.tOKEN});

  ChangHolidayModel.fromJson(Map<String, dynamic> json) {
    nAME = json['NAME'];
    eMPLOYEECODE = json['EMPLOYEE_CODE'];
    aBSENCESTATUS = json['ABSENCE_STATUS'];
    aBSENCEDATEFROM = json['ABSENCE_DATE_FROM'];
    aBSENCEDATETO = json['ABSENCE_DATE_TO'];
    aBSENCEDOCUMENT = json['ABSENCE_DOCUMENT'];
    aBSENCEDAY = json['ABSENCE_DAY'];
    aBSENCEHOUR = json['ABSENCE_HOUR'];
    aBSENCEREVIEW = json['ABSENCE_REVIEW'];
    aBSENCEAPPROVE = json['ABSENCE_APPROVE'];
    sTATUSAPPROVE = json['STATUS_APPROVE'];
    cREATIONDATE = json['CREATION_DATE'];
    tOKEN = json['ABSENCE_TOKEN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NAME'] = nAME;
    data['EMPLOYEE_CODE'] = eMPLOYEECODE;
    data['ABSENCE_STATUS'] = aBSENCESTATUS;
    data['ABSENCE_DATE_FROM'] = aBSENCEDATEFROM;
    data['ABSENCE_DATE_TO'] = aBSENCEDATETO;
    data['ABSENCE_DOCUMENT'] = aBSENCEDOCUMENT;
    data['ABSENCE_DAY'] = aBSENCEDAY;
    data['ABSENCE_HOUR'] = aBSENCEHOUR;
    data['ABSENCE_REVIEW'] = aBSENCEREVIEW;
    data['ABSENCE_APPROVE'] = aBSENCEAPPROVE;
    data['STATUS_APPROVE'] = sTATUSAPPROVE;
    data['CREATION_DATE'] = cREATIONDATE;
    data['ABSENCE_TOKEN'] = tOKEN;
    return data;
  }
}