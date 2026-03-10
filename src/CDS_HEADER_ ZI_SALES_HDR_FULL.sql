@AbapCatalog.sqlViewName: 'ZVSALESHDRFULL'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Header Full with Customer Info'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #FACT
@Analytics.dataExtraction.enabled: true

@Analytics.dataExtraction.delta.byElement.name: 'LastChangeDate'
@Analytics.dataExtraction.delta.byElement.maxDelayInSeconds: 300
@Analytics.dataExtraction.delta.byElement.detectDeletedRecords: true

define view ZI_SALES_HDR_FULL
as select from I_SalesDocument as SD
left outer join I_SalesDocumentItem as SI
    on SD.SalesDocument = SI.SalesDocument
left outer join I_CompanyCode as CC
    on SD.BillingCompanyCode = CC.CompanyCode
left outer join kna1 as K
    on SD.SoldToParty = K.kunnr
{
    key SD.SalesDocument,
    SD.SDDocumentCategory,
    SD.SalesDocumentType,
    CC.CompanyCode,
    SD.SoldToParty,
    SD.LastChangeDate,
    SD.SDDocumentReason,
    CC.FiscalYearVariant,
    SD.RequestedDeliveryDate,
    SD.CreationDate,
    SD.SalesOrganization,
    SD.OrganizationDivision,
    SD.DistributionChannel,
    SD.TransactionCurrency,
    SD.BindingPeriodValidityStartDate,

    cast(count(distinct SI.SalesDocument) as abap.int4) as NumberOfOrders,

    K.name1,
    K.land1
}
group by
    SD.SalesDocument,
    SD.SDDocumentCategory,
    SD.SalesDocumentType,
    CC.CompanyCode,
    SD.SoldToParty,
    SD.LastChangeDate,
    SD.SDDocumentReason,
    CC.FiscalYearVariant,
    SD.RequestedDeliveryDate,
    SD.CreationDate,
    SD.SalesOrganization,
    SD.OrganizationDivision,
    SD.DistributionChannel,
    SD.TransactionCurrency,
    SD.BindingPeriodValidityStartDate,
    K.name1,
    K.land1
