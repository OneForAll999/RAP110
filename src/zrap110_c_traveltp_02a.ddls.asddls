@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forTravel'
@ObjectModel.semanticKey: [ 'TravelID' ]
@Search.searchable: true
define root view entity ZRAP110_C_TRAVELTP_02A
  provider contract transactional_query
  as projection on ZRAP110_R_TRAVELTP_02A as Travel
{
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.90
  key     TravelID,
          @Consumption.valueHelpDefinition: [ {
            entity: {
              name: '/DMO/I_Agency_StdVH',
              element: 'AgencyID'
            }
          } ]
          @Search.defaultSearchElement: true
          @ObjectModel.text.element: ['AgencyName'] //associated text element specified
          AgencyID,
          _Agency.Name              as AgencyName, //element added
          @Consumption.valueHelpDefinition: [ {
            entity: {
              name: '/DMO/I_Customer_StdVH',
              element: 'CustomerID'
            }
          } ]
          @Search.defaultSearchElement: true
          @ObjectModel.text.element: ['CustomerName'] //associated text element specified
          CustomerID,
          _Customer.LastName        as CustomerName, //element added
          BeginDate,
          EndDate,
          @Semantics.amount.currencyCode: 'CurrencyCode'
          BookingFee,
          @Semantics.amount.currencyCode: 'CurrencyCode'
          TotalPrice,
          @Consumption.valueHelpDefinition: [ {
            entity: {
              name: 'I_CurrencyStdVH',
              element: 'Currency'
            }, useForValidation: true
          } ]
          CurrencyCode,
          Description,
          @Consumption.valueHelpDefinition: [ {
            entity: {
              name: '/DMO/I_Overall_Status_VH',
              element: 'OverallStatus'
            }
          } ]
          @ObjectModel.text.element: ['OverallStatusText'] //associated text element specified
          OverallStatus,
          _OverallStatus._Text.Text as OverallStatusText : localized, //element added
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZRAP110_CALC_TRAV_ELEM_02A'
          @EndUserText.label: 'Overall Status Indicator'
  virtual OverallStatusIndicator : abap.int2,
          @Semantics.largeObject: { mimeType: 'MimeType',    //case-sensitive
                                   fileName: 'FileName',    //case-sensitive
                                   //acceptableMimeTypes: ['image/png', 'image/jpeg'],
                                   contentDispositionPreference: #ATTACHMENT }
          Attachment,
          @Semantics.mimeType: true
          MimeType,
          FileName,
          CreatedAt,
          LocalLastChangedAt,
          _Booking : redirected to composition child ZRAP110_C_BOOKINGTP_02A,
          _Agency,
          _Customer,
          _OverallStatus,
          _Currency

}
