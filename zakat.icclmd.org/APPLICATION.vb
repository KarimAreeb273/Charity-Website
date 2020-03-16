'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated from a template.
'
'     Manual changes to this file may cause unexpected behavior in your application.
'     Manual changes to this file will be overwritten if the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Imports System
Imports System.Collections.Generic

Partial Public Class APPLICATION
    Public Property applicationId As Integer
    Public Property userId As Integer
    Public Property organizationId As Integer
    Public Property isSaved As Nullable(Of Boolean)
    Public Property isSubmitted As Nullable(Of Boolean)
    Public Property isValidated As Nullable(Of Boolean)
    Public Property isInvestigated As Nullable(Of Boolean)
    Public Property isQualified As Nullable(Of Boolean)
    Public Property approvalStatus As String
    Public Property totalValueCash As Nullable(Of Decimal)
    Public Property totalValueGold As Nullable(Of Decimal)
    Public Property totalValueSilver As Nullable(Of Decimal)
    Public Property totalValueInvestment As Nullable(Of Decimal)
    Public Property hasRetirement As Nullable(Of Boolean)
    Public Property totalValueRetirement As Nullable(Of Decimal)
    Public Property hasOutstandingDebts As Nullable(Of Boolean)
    Public Property totalValueOutstandingDebts As Nullable(Of Decimal)
    Public Property hasHealthInsurance As String
    Public Property medicaidNumber As String
    Public Property medicareNumber As String
    Public Property healthInsuranceProviderName As String
    Public Property healthInsuranceProviderPolicyNumber As String
    Public Property hasLifeInsurance As Nullable(Of Boolean)
    Public Property totalValueLifeInsurance As Nullable(Of Decimal)
    Public Property hasChildSupport As Nullable(Of Boolean)
    Public Property totalChildSupport As Nullable(Of Decimal)
    Public Property frequencyChildSupport As String
    Public Property hasFoodStamps As Nullable(Of Boolean)
    Public Property totalFoodStamps As Nullable(Of Decimal)
    Public Property frequencyFoodStamps As String
    Public Property hasTemporaryCashAssistance As Nullable(Of Boolean)
    Public Property sourceTemporaryCashAssistance As String
    Public Property totalTemporaryCashAssistance As Nullable(Of Decimal)
    Public Property isEmployerCurrent As Nullable(Of Boolean)
    Public Property employerName As String
    Public Property positionTitle As String
    Public Property totalMonthlyGrossSalary As Nullable(Of Decimal)
    Public Property employmentStartDate As Nullable(Of Date)
    Public Property employmentEndtDate As Nullable(Of Date)
    Public Property employerStreet As String
    Public Property employerCity As String
    Public Property employerStateAbbr As String
    Public Property employerZip As String
    Public Property employerPhone As String
    Public Property personalNeedStatement As String
    Public Property submittedDate As Nullable(Of Date)

    Public Overridable Property ORGANIZATION As ORGANIZATION
    Public Overridable Property STATE As STATE
    Public Overridable Property USER As USER

End Class
