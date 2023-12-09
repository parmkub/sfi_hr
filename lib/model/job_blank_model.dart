class JobBlankModel {
  String? jOBID;
  String? jOBNAME;
  String? jOBTYPE;
  String? jOBDETAIL;
  String? jOBQUATITIY;
  String? jOBPRICE;
  String? jOBLOCATION;
  String? jOBWORKTIME;
  String? jOBGENDER;
  String? jOBWELFARE;
  String? jOBSTATUS;
  String? cREATEDATE;
  String? jOBMAJOR;
  String? jOBMAJORSECOUND;
  String? jOBPOSITION;
  String? jOBAGE;
  String? jOBEXP;
  String? jOBHOLIDAY;
  String? jOBOTHER;
  String? uSERCREATE;
  String? dATEDIFF;
  String? fACTORYNAME;
  String? dEGREE;
  String? myJOBSTATUS;
  String? bUSINESSTYPE;
  String? bUSINESSABOUT;

  JobBlankModel(
      {jOBID,
        jOBNAME,
        jOBTYPE,
        jOBDETAIL,
        jOBQUATITIY,
        jOBPRICE,
        jOBLOCATION,
        jOBWORKTIME,
        jOBGENDER,
        jOBWELFARE,
        jOBSTATUS,
        cREATEDATE,
        jOBMAJOR,
        jOBMAJORSECOUND,
        jOBPOSITION,
        jOBAGE,
        jOBEXP,
        jOBHOLIDAY,
        jOBOTHER,
        uSERCREATE,
        dATEDIFF,
        fACTORYNAME,
        dEGREE,
        myJOBSTATUS,
        bUSINESSTYPE,
        bUSINESSABOUT});

  JobBlankModel.fromJson(Map<String, dynamic> json) {
    jOBID = json['JOB_ID'];
    jOBNAME = json['JOB_NAME'];
    jOBTYPE = json['JOB_TYPE'];
    jOBDETAIL = json['JOB_DETAIL'];
    jOBQUATITIY = json['JOB_QUATITIY'];
    jOBPRICE = json['JOB_PRICE'];
    jOBLOCATION = json['JOB_LOCATION'];
    jOBWORKTIME = json['JOB_WORK_TIME'];
    jOBGENDER = json['JOB_GENDER'];
    jOBWELFARE = json['JOB_WELFARE'];
    jOBSTATUS = json['JOB_STATUS'];
    cREATEDATE = json['CREATE_DATE'];
    jOBMAJOR = json['JOB_MAJOR'];
    jOBMAJORSECOUND = json['JOB_MAJOR_SECOUND'];
    jOBPOSITION = json['JOB_POSITION'];
    jOBAGE = json['JOB_AGE'];
    jOBEXP = json['JOB_EXP'];
    jOBHOLIDAY = json['JOB_HOLIDAY'];
    jOBOTHER = json['JOB_OTHER'];
    uSERCREATE = json['USER_CREATE'];
    dATEDIFF = json['DATE_DIFF'];
    fACTORYNAME = json['FACTORY_NAME'];
    dEGREE = json['DEGREE'];
    myJOBSTATUS = json['MY_JOB_STATUS'];
    bUSINESSTYPE = json['BUSINESS_TYPE'];
    bUSINESSABOUT = json['BUSINESS_ABOUT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['JOB_ID'] = jOBID;
    data['JOB_NAME'] = jOBNAME;
    data['JOB_TYPE'] = jOBTYPE;
    data['JOB_DETAIL'] = jOBDETAIL;
    data['JOB_QUATITIY'] = jOBQUATITIY;
    data['JOB_PRICE'] = jOBPRICE;
    data['JOB_LOCATION'] = jOBLOCATION;
    data['JOB_WORK_TIME'] = jOBWORKTIME;
    data['JOB_GENDER'] = jOBGENDER;
    data['JOB_WELFARE'] = jOBWELFARE;
    data['JOB_STATUS'] = jOBSTATUS;
    data['CREATE_DATE'] = cREATEDATE;
    data['JOB_MAJOR'] = jOBMAJOR;
    data['JOB_MAJOR_SECOUND'] = jOBMAJORSECOUND;
    data['JOB_POSITION'] = jOBPOSITION;
    data['JOB_AGE'] = jOBAGE;
    data['JOB_EXP'] = jOBEXP;
    data['JOB_HOLIDAY'] = jOBHOLIDAY;
    data['JOB_OTHER'] = jOBOTHER;
    data['USER_CREATE'] = uSERCREATE;
    data['DATE_DIFF'] = dATEDIFF;
    data['FACTORY_NAME'] = fACTORYNAME;
    data['DEGREE'] = dEGREE;
    data['MY_JOB_STATUS'] = myJOBSTATUS;
    data['BUSINESS_TYPE'] = bUSINESSTYPE;
    data['BUSINESS_ABOUT'] = bUSINESSABOUT;
    return data;
  }
}