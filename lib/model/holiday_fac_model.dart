class HolidayFacModel {
  String? hOLIDAYDAY;
  String? hOLIDAYDESC;

  HolidayFacModel({this.hOLIDAYDAY, this.hOLIDAYDESC});

  HolidayFacModel.fromJson(Map<String, dynamic> json) {
    hOLIDAYDAY = json['HOLIDAY_DAY'];
    hOLIDAYDESC = json['HOLIDAY_DESC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['HOLIDAY_DAY'] = hOLIDAYDAY;
    data['HOLIDAY_DESC'] = hOLIDAYDESC;
    return data;
  }
}