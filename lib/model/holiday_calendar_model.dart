class HolidayCalendar {
  String? aBSENCEDATE;
  String? eMPLOYEECODE;
  String? aBSENCECODE;
  String? aBSENCEDAY;
  String? aBSENCEHOUR;
  String? aBSENCECOMMENT;
  String? dELETEMARK;

  HolidayCalendar(
      {this.aBSENCEDATE,
        this.eMPLOYEECODE,
        this.aBSENCECODE,
        this.aBSENCEDAY,
        this.aBSENCEHOUR,
        this.aBSENCECOMMENT,
        this.dELETEMARK});

  HolidayCalendar.fromJson(Map<String, dynamic> json) {
    aBSENCEDATE = json['ABSENCE_DATE'];
    eMPLOYEECODE = json['EMPLOYEE_CODE'];
    aBSENCECODE = json['ABSENCE_CODE'];
    aBSENCEDAY = json['ABSENCE_DAY'];
    aBSENCEHOUR = json['ABSENCE_HOUR'];
    aBSENCECOMMENT = json['ABSENCE_COMMENT'];
    dELETEMARK = json['DELETE_MARK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ABSENCE_DATE'] = aBSENCEDATE;
    data['EMPLOYEE_CODE'] = eMPLOYEECODE;
    data['ABSENCE_CODE'] = aBSENCECODE;
    data['ABSENCE_DAY'] = aBSENCEDAY;
    data['ABSENCE_HOUR'] = aBSENCEHOUR;
    data['ABSENCE_COMMENT'] = aBSENCECOMMENT;
    data['DELETE_MARK'] = dELETEMARK;
    return data;
  }
}