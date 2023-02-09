class HolidayModel {
  String? pERIODNAME;
  String? pERIODDATE;
  String? fISCALYEAR;
  String? eMPLOYEECODE;
  String? eMPNAME;
  String? pOSITIONCODE;
  String? sECTNAME;
  String? dIVINAME;
  String? dEPARTNAME;
  String? sAI;
  String? sAIHRMN;
  String? lAGITJAY;
  String? lAPOUYJAY;
  String? aUBUTTIHAT;
  String? lACRODJAY;
  String? mATTAJIT;
  String? bOUD;
  String? pUKRONH;
  String? aA;
  String? lAGITNOTJAY;
  String? kADHANG;
  String? aD;
  String? aBROMJAY;
  String? lAPOUYNOTJAY;
  String? lACRODNETJAY;
  String? bE;
  String? sUMMER1;
  String? sUMMER2;
  String? n02;
  String? n11;
  String? n12;
  String? n14;
  String? n23;
  String? n25;
  String? n29;
  String? nAA;
  String? nAB;
  String? nAC;
  String? nAD;
  String? nAE;
  String? nBA;
  String? nBD;
  String? nBE;
  String? nSUMMER1;
  String? nSUMMER2;
  String? n0211;
  String? wORKINGDAY;
  String? sUMMERDATE;
  String? sUMMERDAY;
  String? eMPLOYEEGROUP;
  String? rESIGNFLAG;
  String? pERDEPART;
  String? dEPARTCODE;
  String? dIVICODE;
  String? hOLIDAYDAY;
  String? hOLIDAYNUM;
  String? hOLIDAY2NUM;
  String? hOLIDAYSTARTDATE;
  String? hOLIDAYENDDATE;
  String? hOLIDAY2STARTDATE;
  String? hOLIDAY2ENDDATE;
  String? gROUPEMPLOYEE;
  String? pOSITIONFGROUPNAME;

  HolidayModel(
      {this.pERIODNAME,
        this.pERIODDATE,
        this.fISCALYEAR,
        this.eMPLOYEECODE,
        this.eMPNAME,
        this.pOSITIONCODE,
        this.sECTNAME,
        this.dIVINAME,
        this.dEPARTNAME,
        this.sAI,
        this.sAIHRMN,
        this.lAGITJAY,
        this.lAPOUYJAY,
        this.aUBUTTIHAT,
        this.lACRODJAY,
        this.mATTAJIT,
        this.bOUD,
        this.pUKRONH,
        this.aA,
        this.lAGITNOTJAY,
        this.kADHANG,
        this.aD,
        this.aBROMJAY,
        this.lAPOUYNOTJAY,
        this.lACRODNETJAY,
        this.bE,
        this.sUMMER1,
        this.sUMMER2,
        this.n02,
        this.n11,
        this.n12,
        this.n14,
        this.n23,
        this.n25,
        this.n29,
        this.nAA,
        this.nAB,
        this.nAC,
        this.nAD,
        this.nAE,
        this.nBA,
        this.nBD,
        this.nBE,
        this.nSUMMER1,
        this.nSUMMER2,
        this.n0211,
        this.wORKINGDAY,
        this.sUMMERDATE,
        this.sUMMERDAY,
        this.eMPLOYEEGROUP,
        this.rESIGNFLAG,
        this.pERDEPART,
        this.dEPARTCODE,
        this.dIVICODE,
        this.hOLIDAYDAY,
        this.hOLIDAYNUM,
        this.hOLIDAY2NUM,
        this.hOLIDAYSTARTDATE,
        this.hOLIDAYENDDATE,
        this.hOLIDAY2STARTDATE,
        this.hOLIDAY2ENDDATE,
        this.gROUPEMPLOYEE,
        this.pOSITIONFGROUPNAME});

  HolidayModel.fromJson(Map<String, dynamic> json) {
    pERIODNAME = json['PERIOD_NAME'];
    pERIODDATE = json['PERIODDATE'];
    fISCALYEAR = json['FISCAL_YEAR'];
    eMPLOYEECODE = json['EMPLOYEE_CODE'];
    eMPNAME = json['EMPNAME'];
    pOSITIONCODE = json['POSITION_CODE'];
    sECTNAME = json['SECT_NAME'];
    dIVINAME = json['DIVI_NAME'];
    dEPARTNAME = json['DEPART_NAME'];
    sAI = json['SAI'];
    sAIHRMN = json['SAI_HRMN'];
    lAGITJAY = json['LAGIT_JAY'];
    lAPOUYJAY = json['LAPOUY_JAY'];
    aUBUTTIHAT = json['AUBUTTIHAT'];
    lACRODJAY = json['LACROD_JAY'];
    mATTAJIT = json['MATTAJIT'];
    bOUD = json['BOUD'];
    pUKRONH = json['PUKRONH'];
    aA = json['AA'];
    lAGITNOTJAY = json['LAGIT_NOT_JAY'];
    kADHANG = json['KADHANG'];
    aD = json['AD'];
    aBROMJAY = json['ABROM_JAY'];
    lAPOUYNOTJAY = json['LAPOUY_NOT_JAY'];
    lACRODNETJAY = json['LACROD_NET_JAY'];
    bE = json['BE'];
    sUMMER1 = json['SUMMER1'];
    sUMMER2 = json['SUMMER2'];
    n02 = json['N02'];
    n11 = json['N11'];
    n12 = json['N12'];
    n14 = json['N14'];
    n23 = json['N23'];
    n25 = json['N25'];
    n29 = json['N29'];
    nAA = json['NAA'];
    nAB = json['NAB'];
    nAC = json['NAC'];
    nAD = json['NAD'];
    nAE = json['NAE'];
    nBA = json['NBA'];
    nBD = json['NBD'];
    nBE = json['NBE'];
    nSUMMER1 = json['NSUMMER1'];
    nSUMMER2 = json['NSUMMER2'];
    n0211 = json['N02_11'];
    wORKINGDAY = json['WORKING_DAY'];
    sUMMERDATE = json['SUMMER_DATE'];
    sUMMERDAY = json['SUMMER_DAY'];
    eMPLOYEEGROUP = json['EMPLOYEE_GROUP'];
    rESIGNFLAG = json['RESIGN_FLAG'];
    pERDEPART = json['PER_DEPART'];
    dEPARTCODE = json['DEPART_CODE'];
    dIVICODE = json['DIVI_CODE'];
    hOLIDAYDAY = json['HOLIDAY_DAY'];
    hOLIDAYNUM = json['HOLIDAY_NUM'];
    hOLIDAY2NUM = json['HOLIDAY_2NUM'];
    hOLIDAYSTARTDATE = json['HOLIDAY_START_DATE'];
    hOLIDAYENDDATE = json['HOLIDAY_END_DATE'];
    hOLIDAY2STARTDATE = json['HOLIDAY_2START_DATE'];
    hOLIDAY2ENDDATE = json['HOLIDAY_2END_DATE'];
    gROUPEMPLOYEE = json['GROUP_EMPLOYEE'];
    pOSITIONFGROUPNAME = json['POSITION_F_GROUP_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PERIOD_NAME'] = pERIODNAME;
    data['PERIODDATE'] = pERIODDATE;
    data['FISCAL_YEAR'] = fISCALYEAR;
    data['EMPLOYEE_CODE'] = eMPLOYEECODE;
    data['EMPNAME'] = eMPNAME;
    data['POSITION_CODE'] = pOSITIONCODE;
    data['SECT_NAME'] = sECTNAME;
    data['DIVI_NAME'] = dIVINAME;
    data['DEPART_NAME'] = dEPARTNAME;
    data['SAI'] = sAI;
    data['SAI_HRMN'] = sAIHRMN;
    data['LAGIT_JAY'] = lAGITJAY;
    data['LAPOUY_JAY'] = lAPOUYJAY;
    data['AUBUTTIHAT'] = aUBUTTIHAT;
    data['LACROD_JAY'] = lACRODJAY;
    data['MATTAJIT'] = mATTAJIT;
    data['BOUD'] = bOUD;
    data['PUKRONH'] = pUKRONH;
    data['AA'] = aA;
    data['LAGIT_NOT_JAY'] = lAGITNOTJAY;
    data['KADHANG'] = kADHANG;
    data['AD'] = aD;
    data['ABROM_JAY'] = aBROMJAY;
    data['LAPOUY_NOT_JAY'] = lAPOUYNOTJAY;
    data['LACROD_NET_JAY'] = lACRODNETJAY;
    data['BE'] = bE;
    data['SUMMER1'] = sUMMER1;
    data['SUMMER2'] = sUMMER2;
    data['N02'] = n02;
    data['N11'] = n11;
    data['N12'] = n12;
    data['N14'] = n14;
    data['N23'] = n23;
    data['N25'] = n25;
    data['N29'] = n29;
    data['NAA'] = nAA;
    data['NAB'] = nAB;
    data['NAC'] = nAC;
    data['NAD'] = nAD;
    data['NAE'] = nAE;
    data['NBA'] = nBA;
    data['NBD'] = nBD;
    data['NBE'] = nBE;
    data['NSUMMER1'] = nSUMMER1;
    data['NSUMMER2'] = nSUMMER2;
    data['N02_11'] = n0211;
    data['WORKING_DAY'] = wORKINGDAY;
    data['SUMMER_DATE'] = sUMMERDATE;
    data['SUMMER_DAY'] = sUMMERDAY;
    data['EMPLOYEE_GROUP'] = eMPLOYEEGROUP;
    data['RESIGN_FLAG'] = rESIGNFLAG;
    data['PER_DEPART'] = pERDEPART;
    data['DEPART_CODE'] = dEPARTCODE;
    data['DIVI_CODE'] = dIVICODE;
    data['HOLIDAY_DAY'] = hOLIDAYDAY;
    data['HOLIDAY_NUM'] = hOLIDAYNUM;
    data['HOLIDAY_2NUM'] = hOLIDAY2NUM;
    data['HOLIDAY_START_DATE'] = hOLIDAYSTARTDATE;
    data['HOLIDAY_END_DATE'] = hOLIDAYENDDATE;
    data['HOLIDAY_2START_DATE'] = hOLIDAY2STARTDATE;
    data['HOLIDAY_2END_DATE'] = hOLIDAY2ENDDATE;
    data['GROUP_EMPLOYEE'] = gROUPEMPLOYEE;
    data['POSITION_F_GROUP_NAME'] = pOSITIONFGROUPNAME;
    return data;
  }
}