class TotalDurSearchResult {
  final String resultCode, resultMsg;
  final int numOfRows; // 한 페이지 결과 수
  final int pageNo; // 페이지 번호
  final int totalCount; // 전체 결과 수
  final List items;

  TotalDurSearchResult(
      {this.items,
      this.numOfRows,
      this.pageNo,
      this.resultCode,
      this.resultMsg,
      this.totalCount});

  // flag : 0 → 병용금기, 특정연령금기, 임부금기, 용량주의, 투여기간주의, 노인주의, 효능군 중복조회, ...
  // flag : 1 → DUR 품목조회
  factory TotalDurSearchResult.fromJson(
      Map<String, dynamic> parsedJson, int flag) {
    var itemList = parsedJson['items'] as List;
    var _itemList;
    if (itemList != null) {
      if (flag == 0) {
        _itemList = itemList.map((e) => DurSearchResult.fromJson(e)).toList();
      } else if (flag == 1) {
        _itemList =
            itemList.map((e) => DurPrdSearchResult.fromJson(e)).toList();
      }
    } else
      _itemList = [];

    return TotalDurSearchResult(
        resultCode: parsedJson['resultCode'],
        resultMsg: parsedJson['resultMsg'],
        numOfRows: parsedJson['numOfRows'],
        pageNo: parsedJson['pageNo'],
        totalCount: parsedJson['totalCount'],
        items: _itemList);
  }
}

String returnNonEmpty(final data) {
  return data != null ? data : '정보가 없습니다.';
}

class DurSearchResult {
  final String durSeq, // DUR 일련번호
      typeCode, // DUR 유형코드
      typeName, // DUR 유형
      mix, // 단일 / 복합
      ingrCode, // DUR 성분코드
      ingrKorName, // DUR 성분
      ingrEngName, // DUR 성분(영문)
      mixIngr, // 복합체
      itemSeq, // 품목기준코드
      itemName, // 품목명
      entpName, // 업체명
      chart, // 성상
      formCode, // 제형구분코드
      etcOtcCode, // 전문 / 일반 구분코드
      classCode, // 약효분류코드
      formName, // 제형
      etcOtcName, // 전문 / 일반
      className, // 약효 분류
      mainIngr, // 주성분
      mixtureDurSeq, // 병용금기 DUR 번호
      mixtureMix, // 병용금기복합체
      mixtureIngrCode, // 병용금기 DUR 성분코드
      mixtureIngrKorName, // 병용금기 DUR 성분
      mixtureIngrEngName, // 병용금기 DUR 성분 (영문)
      mixtureItemSeq, // 범용 금기 품목 기준 코드
      mixtureItemName, // 병용금기품목명
      mixtureEntpName, // 병용금기업체명
      mixtureFormCode, // 병용 금기 제형 구분 코드
      mixtureEtcOtcCode, // 병용 금기 전문 / 일반 구분 코드
      mixtureClassCode, // 병용 금기 약효 분류 코드
      mixtureFormName, // 병용 금기 제형
      mixtureEtcOtcName, // 병용 금기 전문 / 일반
      mixtureClassName, // 병용 금기 약효 분류
      mixtureMainIngr, // 병용 금기 주성분
      notificationDate, // 고시일자
      prohbtContent, // 금기 내용
      remark, // 비고
      itemPermitDate, // 품목 허가 일자
      mixtureItemPermitDate, // 범용 금기 품목 허가 일자
      mixtureChart, // 병용 금기 성상
      changeDate, // 변경일자
      mixtureChangeDate; // 병용 변경 일자

  // init
  DurSearchResult(
      {this.durSeq,
      this.typeCode,
      this.typeName,
      this.mix,
      this.changeDate,
      this.chart,
      this.classCode,
      this.className,
      this.entpName,
      this.etcOtcCode,
      this.etcOtcName,
      this.formCode,
      this.formName,
      this.ingrCode,
      this.ingrEngName,
      this.ingrKorName,
      this.itemName,
      this.itemPermitDate,
      this.itemSeq,
      this.mainIngr,
      this.mixIngr,
      this.mixtureChangeDate,
      this.mixtureChart,
      this.mixtureClassCode,
      this.mixtureClassName,
      this.mixtureDurSeq,
      this.mixtureEntpName,
      this.mixtureEtcOtcCode,
      this.mixtureEtcOtcName,
      this.mixtureFormCode,
      this.mixtureFormName,
      this.mixtureIngrCode,
      this.mixtureIngrEngName,
      this.mixtureIngrKorName,
      this.mixtureItemName,
      this.mixtureItemPermitDate,
      this.mixtureMainIngr,
      this.mixtureMix,
      this.mixtureItemSeq,
      this.notificationDate,
      this.prohbtContent,
      this.remark});

  factory DurSearchResult.fromJson(Map<String, dynamic> json) {
    
    return DurSearchResult(
        // DUR info
        durSeq: returnNonEmpty(json['DUR_SEQ']),
        typeCode: returnNonEmpty(json['TYPE_CODE']),
        typeName: returnNonEmpty(json['TYPE_NAME']),
        ingrCode: returnNonEmpty(json['INGR_CODE']),
        ingrKorName: returnNonEmpty(json['INGR_KOR_NAME']),
        ingrEngName: returnNonEmpty(json['INGR_ENG_NAME']),
        // about pill
        mix: returnNonEmpty(json['MIX']),
        mixIngr: returnNonEmpty(json['MIX_INGR']),
        itemSeq: returnNonEmpty(json['ITEM_SEQ']),
        itemName: returnNonEmpty(json['ITEM_NAME']),
        entpName: returnNonEmpty(json['ENTP_NAME']),
        chart: returnNonEmpty(json['CHART']),
        formCode: returnNonEmpty(json['FORM_CODE']),
        formName: returnNonEmpty(json['FORM_NAME']),
        etcOtcCode: returnNonEmpty(json['ETC_OTC_CODE']),
        etcOtcName: returnNonEmpty(json['ETC_OTC_NAME']),
        classCode: returnNonEmpty(json['CLASS_CODE']),
        className: returnNonEmpty(json['CLASS_NAME']),
        mainIngr: returnNonEmpty(json['MAIN_INGR']),
        notificationDate: returnNonEmpty(json['NOTIFICATION_DATE']),
        prohbtContent: returnNonEmpty(json['PROHBT_CONTENT']),
        itemPermitDate: returnNonEmpty(json['ITEM_PERMIT_DATE']),
        remark: returnNonEmpty(json['REMARK']),
        changeDate: returnNonEmpty(json['CHANGE_DATE']),
        // only for 병용금기 사항
        mixtureDurSeq: returnNonEmpty(json['MIXTURE_DUR_SEQ']),
        mixtureMix: returnNonEmpty(json['MIXTURE_MIX']),
        mixtureIngrCode: returnNonEmpty(json['MIXTURE_INGR_CODE']),
        mixtureIngrKorName: returnNonEmpty(json['MIXTURE_INGR_KOR_NAME']),
        mixtureIngrEngName: returnNonEmpty(json['MIXTURE_INGR_ENG_NAME']),
        mixtureItemSeq: returnNonEmpty(json['MIXTURE_ITEM_SEQ']),
        mixtureItemName: returnNonEmpty(json['MIXTURE_ITEM_NAME']),
        mixtureItemPermitDate: returnNonEmpty(json['MIXTURE_ITEM_PERMIT_DATE']),
        mixtureEntpName: returnNonEmpty(json['MIXTURE_ENTP_NAME']),
        mixtureMainIngr: returnNonEmpty(json['MIXTURE_MAIN_INGR']),
        mixtureEtcOtcCode: returnNonEmpty(json['MIXTURE_ETC_OTC_CODE']),
        mixtureEtcOtcName: returnNonEmpty(json['MIXTURE_ETC_OTC_NAME']),
        mixtureFormCode: returnNonEmpty(json['MIXTURE_FORM_CODE']),
        mixtureFormName: returnNonEmpty(json['MIXTURE_FORM_NAME']),
        mixtureClassCode: returnNonEmpty(json['MIXTURE_CLASS_CODE']),
        mixtureClassName: returnNonEmpty(json['MIXTURE_CLASS_NAME']),
        mixtureChart: returnNonEmpty(json['MIXTURE_CHART']),
        mixtureChangeDate: returnNonEmpty(json['MIXTURE_CHANGE_DATE']));
  }
}

// DUR 품목 조회
class DurPrdSearchResult {
  final String itemSeq, // 품목기준코드
      itemName, // 품목명
      entpName, // 업체명
      itemPermitDate, // 허가일자
      etcOtcCode, // 전문 / 일반
      classNo, // 분류
      chart, // 성상
      barCode, // 표준코드
      materialName, // 원료성분
      eeDocId, // 제조방법 : url
      udDocId, // 용법용량 : url
      nbDocId, // 주의사항 : url
      insertFile, // 첨부문서 : url
      storageMethod, // 저장방법
      validTerm, // 유효기간
      reexamTarget, // 재심사대상
      reexamDate, // 재심사기간
      packUnit, // 포장단위
      ediCode, // 보험코드
      cancelDate, // 취소일자
      cancelName, // 상태
      changeDate; // 변경일자
  DurPrdSearchResult(
      {this.barCode,
      this.cancelDate,
      this.cancelName,
      this.changeDate,
      this.chart,
      this.classNo,
      this.ediCode,
      this.eeDocId,
      this.entpName,
      this.etcOtcCode,
      this.insertFile,
      this.itemName,
      this.itemPermitDate,
      this.itemSeq,
      this.materialName,
      this.nbDocId,
      this.packUnit,
      this.reexamDate,
      this.reexamTarget,
      this.storageMethod,
      this.udDocId,
      this.validTerm});

  factory DurPrdSearchResult.fromJson(Map<String, dynamic> json) {
    return DurPrdSearchResult(
      itemSeq: returnNonEmpty(json['ITEM_SEQ']),
      itemName: returnNonEmpty(json['ITEM_NAME']),
      entpName: returnNonEmpty(json['ENTP_NAME']),
      itemPermitDate: returnNonEmpty(json['ITEM_PERMIT_DATE']),
      etcOtcCode: returnNonEmpty(json['ETC_OTC_CODE']),
      classNo: returnNonEmpty(json['CLASS_NO']),
      chart: returnNonEmpty(json['CHART']),
      barCode: returnNonEmpty(json['BAR_CODE']),
      materialName: returnNonEmpty(json['MATERIAL_NAME']),
      eeDocId: returnNonEmpty(json['EE_DOC_ID']),
      udDocId: returnNonEmpty(json['UD_DOC_ID']),
      nbDocId: returnNonEmpty(json['NB_DOC_ID']),
      insertFile: returnNonEmpty(json['INSERT_FILE']),
      storageMethod: returnNonEmpty(json['STORAGE_METHOD']),
      validTerm: returnNonEmpty(json['VALID_TERM']),
      reexamTarget: returnNonEmpty(json['REEXAM_TARGET']),
      reexamDate: returnNonEmpty(json['REEXAM_DATE']),
      packUnit: returnNonEmpty(json['PACK_UNIT']),
      ediCode: returnNonEmpty(json['EDI_CODE']),
      cancelDate: returnNonEmpty(json['CANCEL_DATE']),
      cancelName: returnNonEmpty(json['CANCEL_NAME']),
      changeDate: returnNonEmpty(json['CHANGE_DATE']),
    );
  }
}
