/**
 *  의약품 정보를 얻어올 수 있는 방법은 현재 2가지입니다.
 *  
 *  1) 공공데이터포털 REST API를 사용하는 방법
 *  2) csv 파일을 만들어서 데이터베이스에 올린 후, 데이터베이스에 있는 정보를 얻는 방법
 * 
 *  1)번 과 같은 경우, 
 *      - 장점 : 새롭게 수정되는 정보를 바로 얻을 수 있음
 *      - 단점 : '식품의약품안전처_의약품개요정보(e약은요)' <- 해당 API로는 제공할 수 있는 정보가 부족, 
 *              'DUR품목정보' <- 이 API를 추가해서 제공해야함
 *  2)번 과 같은 경우,
 *      - 장점 : 두개의 API를 사용할 필요 X, 추후 (사진검색)모델 검색을 통해서 결과를 반환했을 때 delay가 줄어들 거 같음
 *      - 단점 : 새롭게 수정되는 정보를 update 해야함
 * 
 *  우선, 제공할 정보에서는 같은 모델(Model)을 사용해야하기 때문에 모델을 먼저 만들도록 하겠습니다. 
 *  
 *  Author. seunghwanly / 03.09.21
 */

const checkNull = (input) => input !== null ? input : '정보가 없습니다.';

class Search {
    constructor({
        // ==============================================[식품의약품안전처_의약품개요정보(e약은요)]
        entpName,                   // 제조회사 이름 
        itemName,                   // 의약품 이름
        itemEngName,                // 의약품 영어 이름
        itemSeq,                    // 품목기준코드
        efcyQesitm,                 // 효능
        useMethodQesitm,            // 사용법
        atpnWarnQesitm,             // 주의사항 경고
        atpnQesitm,                 // 주의사항
        intrcQesitm,                // 상호작용
        seQesitm,                   // 부작용
        depositMethodQesitm,        // 보관법
        openDe,                     // 공개 일자
        updateDe,                   // 수정일자
        itemImage,                   // 낱알 이미지
        // ==============================================[DUR품목정보]
        // ===================1. 병용금기 정보조회 ~ 8.서방정분할주의 정보조회
        durSeq,                     // DUR 일련번호
        typeCode,                   // DUR 유형코드
        typeName,                   // DUR 유형
        mix,                        // 단일 or 복합
        ingrCode,                   // DUR 성분코드
        ingrKorName,                // DUR 성분이름
        ingrEngName,                // DUR 성분 영문 이름
        mixIngr,                    // 복합체
        //itemSeq,                    // 품목기준코드             --> 중복
        //itemName,                   // 품목명                 --> 중복
        // entpName,                   // 업체명                --> 중복
        chart,                      // 성상
        formCode,                   // 제형구분코드
        etcOtcCode,                 // 전문 / 일반 구분코드
        classCode,                  // 약효분류코드
        formName,                   // 제형
        etcOtcName,                 // 전문 / 일반
        className,                  // 약효 분류
        mainIngr,                   // 주성분
        // =================================1. 병용금기 정보조회 에만 해당
        mixtureDurSeq,              // 병용금기 DUR 번호
        mixtureMix,                 // 병용금기복합체
        mixtureIngrCode,            // 병용금기 DUR 성분코드
        mixtureIngrKorName,         // 병용금기 DUR 성분
        mixtureIngrEngName,         // 병용금기 DUR 성분 (영문)
        mixtureItemSeq,             // 범용 금기 품목 기준 코드
        mixtureItemName,            // 병용금기품목명
        mixtureEntpName,            // 병용금기업체명
        mixtureFormCode,            // 병용 금기 제형 구분 코드
        mixtureEtcOtcCode,          // 병용 금기 전문 / 일반 구분 코드
        mixtureClassCode,           // 병용 금기 약효 분류 코드
        mixtureFormName,            // 병용 금기 제형
        mixtureEtcOtcName,          // 병용 금기 전문 / 일반
        mixtureClassName,           // 병용 금기 약효 분류
        mixtureMainIngr,            // 병용 금기 주성분
        notificationDate,           // 고시일자
        prohbtContent,              // 금기 내용
        remark,                     // 비고
        // ========================================9. DUR 품목정보조회
        itemPermitDate,             // 품목 허가 일자
        mixtureItemPermitDate,      // 범용 금기 품목 허가 일자
        mixtureChart,               // 병용 금기 성상
        changeDate,                 // 변경일자
        mixtureChangeDate,           // 병용 변경 일자
        classNo,                     // 분류
        barCode,                    // 표준코드
        materialName,               // 원료성분
        eeDocId,                    // 제조방법 : url
        udDocId,                    // 용법용량 : url
        nbDocId,                    // 주의사항 : url
        insertFile,                 // 첨부문서 : url
        storageMethod,              // 저장방법
        validTerm,                  // 유효기간
        reexamTarget,               // 재심사대상
        reexamDate,                 // 재심사기간
        packUnit,                   // 포장단위
        ediCode,                    // 보험코드
        cancelDate,                 // 취소일자
        cancelName,                 // 상태
    }) {
        this.entpName = checkNull(entpName);
        this.itemName = checkNull(itemName);
        this.itemEngName = checkNull(itemEngName);
        this.itemSeq = checkNull(itemSeq);
        this.efcyQesitm = checkNull(efcyQesitm);
        this.useMethodQesitm = checkNull(useMethodQesitm);
        this.atpnWarnQesitm = checkNull(atpnWarnQesitm);
        this.atpnQesitm = checkNull(atpnQesitm);
        this.intrcQesitm = checkNull(intrcQesitm);
        this.seQesitm = checkNull(seQesitm);
        this.depositMethodQesitm = checkNull(depositMethodQesitm);
        this.openDe = checkNull(openDe);
        this.updateDe = checkNull(updateDe);
        this.itemImage = checkNull(itemImage);
        this.durSeq = checkNull(durSeq);
        this.typeCode = checkNull(typeCode);
        this.typeName = checkNull(typeName);
        this.mix = checkNull(mix);
        this.ingrCode = checkNull(ingrCode);
        this.ingrKorName = checkNull(ingrKorName);
        this.ingrEngName = checkNull(ingrEngName);
        this.mixIngr = checkNull(mixIngr);
        this.chart = checkNull(chart);
        this.formCode = checkNull(formCode);
        this.etcOtcCode = checkNull(etcOtcCode);
        this.classCode = checkNull(classCode);
        this.formName = checkNull(formName);
        this.etcOtcName = checkNull(etcOtcName);
        this.className = checkNull(className);
        this.mainIngr = checkNull(mainIngr);
        this.mixtureDurSeq = checkNull(mixtureDurSeq);
        this.mixtureMix = checkNull(mixtureMix);
        this.mixtureIngrCode = checkNull(mixtureIngrCode);
        this.mixtureIngrKorName = checkNull(mixtureIngrKorName);
        this.mixtureIngrEngName = checkNull(mixtureIngrEngName);
        this.mixtureItemSeq = checkNull(mixtureItemSeq);
        this.mixtureItemName = checkNull(mixtureItemName);
        this.mixtureEntpName = checkNull(mixtureEntpName);
        this.mixtureFormCode = checkNull(mixtureFormCode);
        this.mixtureEtcOtcCode = checkNull(mixtureEtcOtcCode);
        this.mixtureClassCode = checkNull(mixtureClassCode);
        this.mixtureFormName = checkNull(mixtureFormName);
        this.mixtureEtcOtcName = checkNull(mixtureEtcOtcName);
        this.mixtureClassName = checkNull(mixtureClassName);
        this.mixtureMainIngr = checkNull(mixtureMainIngr);
        this.notificationDate = checkNull(notificationDate);
        this.prohbtContent = checkNull(prohbtContent);
        this.remark = checkNull(remark);
        this.itemPermitDate = checkNull(itemPermitDate);
        this.mixtureItemPermitDate = checkNull(mixtureItemPermitDate);
        this.mixtureChart = checkNull(mixtureChart);
        this.changeDate = checkNull(changeDate);
        this.mixtureChangeDate = checkNull(mixtureChangeDate);
        this.classNo = checkNull(classNo);
        this.barCode = checkNull(barCode);
        this.materialName = checkNull(materialName);
        this.eeDocId = checkNull(eeDocId);
        this.udDocId = checkNull(udDocId);
        this.nbDocId = checkNull(nbDocId);
        this.insertFile = checkNull(insertFile);
        this.storageMethod = checkNull(storageMethod);
        this.validTerm = checkNull(validTerm);
        this.reexamTarget = checkNull(reexamTarget);
        this.reexamDate = checkNull(reexamDate);
        this.packUnit = checkNull(packUnit);
        this.ediCode = checkNull(ediCode);
        this.cancelDate = checkNull(cancelDate);
        this.cancelName = checkNull(cancelName);
    }
}