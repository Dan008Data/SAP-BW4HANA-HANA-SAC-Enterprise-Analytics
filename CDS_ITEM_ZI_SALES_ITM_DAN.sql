   @AbapCatalog.sqlViewName: 'ZVSALESITMDAN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Tran: Sales Item'
@Analytics.dataCategory: #FACT
@Analytics.dataExtraction.enabled: true
// 1. USE BYDATE WITH MATCHING FIELD NAME
@Analytics.dataExtraction.delta.byElement.name: 'LastChangeDate'
@Analytics.dataExtraction.delta.byElement.maxDelayInSeconds: 300
@Analytics.dataExtraction.delta.byElement.detectDeletedRecords: true

define view ZI_SALES_ITM_DAN as 
select from vbap as p
left outer join vbak as k on p.vbeln = k.vbeln
left outer join t001 as t on k.bukrs_vf = t.bukrs
{
    // Key fields
    key p.vbeln,
    key p.posnr,
    
    // Header data from VBAK
    k.auart,
    k.bukrs_vf,
    k.aedat,  // Note: Using aedat directly, not as LastChangeDate here
    k.vbtyp,
    k.audat,
    k.vdatu,
    k.augru,
    k.vkorg,
    k.vtweg,
    k.spart,
    t.periv,
    k.kunnr,
    k.kokrs,
    
    // Item data from VBAP
    p.matnr,
    p.matkl,
    p.werks,
    
    @Semantics.unitOfMeasure: true
    p.vrkme as SalesUnit,
    
    @Semantics.unitOfMeasure: true
    p.meins as BaseUnit,
    
    @Semantics.currencyCode: true
    k.waerk as SDDocumentCurrency,
    
    // 2. DEFINE THE DELTA FIELD SEPARATELY WITH CORRECT SEMANTICS
    // This is the field that drives delta - use aedat as the source
   @Semantics.systemDate.lastChangedAt: true
    k.aedat as LastChangeDate,  // This name MUST match the annotation above
    
    p.umvkz,                    //Numerator
    p.umvkn,                    //Denominator
    
    @Semantics.quantity.unitOfMeasure: 'SalesUnit'
    p.kwmeng,                   //Cumulative Order Qty in Sales Unit
    
    @Semantics.quantity.unitOfMeasure: 'SalesUnit'
    p.kbmeng,                   //Cummlative Confirmed Qty in Sales Unit
    
    p.netpr,
    
    @Semantics.amount.currencyCode: 'SDDocumentCurrency'
    p.netwr
}
