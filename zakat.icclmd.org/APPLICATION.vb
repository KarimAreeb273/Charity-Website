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
    Public Property isDrafted As Nullable(Of Boolean)
    Public Property isSubmitted As Nullable(Of Boolean)
    Public Property isValidated As Nullable(Of Boolean)
    Public Property isInvestigated As Nullable(Of Boolean)
    Public Property isQualified1 As Nullable(Of Boolean)
    Public Property isQualified2 As Nullable(Of Boolean)
    Public Property isDispersed As Nullable(Of Boolean)
    Public Property isRejected As Nullable(Of Boolean)
    Public Property applicationStatus As String
    Public Property husbandHasAppliedForZakat As String
    Public Property husbandZakatExplanation As String
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
    Public Property isNotEmployed As Nullable(Of Boolean)
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
    Public Property submittedOn As Nullable(Of Date)
    Public Property submittedBy As Nullable(Of Integer)
    Public Property validatedOn As Nullable(Of Date)
    Public Property validatedBy As Nullable(Of Integer)
    Public Property investigatedOn As Nullable(Of Date)
    Public Property investigatedBy As Nullable(Of Integer)
    Public Property qualified1On As Nullable(Of Date)
    Public Property qualified1By As Nullable(Of Integer)
    Public Property qualified2On As Nullable(Of Date)
    Public Property qualified2By As Nullable(Of Integer)
    Public Property dispersedAmount As Nullable(Of Decimal)
    Public Property dispersedOn As Nullable(Of Date)
    Public Property dispersedBy As Nullable(Of Integer)
    Public Property rejectedOn As Nullable(Of Date)
    Public Property rejectedBy As Nullable(Of Integer)
    Public Property createdOn As Nullable(Of Date)
    Public Property createdBy As Nullable(Of Integer)
    Public Property updatedOn As Nullable(Of Date)
    Public Property updatedBy As Nullable(Of Integer)
    Public Property draftedOn As Nullable(Of Date)
    Public Property draftedBy As Nullable(Of Integer)

    Public Overridable Property ORGANIZATION As ORGANIZATION
    Public Overridable Property STATE As STATE
    Public Overridable Property USER As USER
    Public Overridable Property ARTIFACT As ICollection(Of ARTIFACT) = New HashSet(Of ARTIFACT)
    Public Overridable Property REVIEW As ICollection(Of REVIEW) = New HashSet(Of REVIEW)

End Class
