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

Partial Public Class DONATION
    Public Property donationId As Integer
    Public Property userId As Nullable(Of Integer)
    Public Property organizationId As Nullable(Of Integer)
    Public Property amount As Nullable(Of Decimal)
    Public Property donationDate As Nullable(Of Date)
    Public Property isConfirmed As Boolean
    Public Property paypalPdtIsSuccessful As Nullable(Of Boolean)
    Public Property paypalPdtConfirmDate As Nullable(Of Date)
    Public Property paypalPdtTransactionId As String
    Public Property paypalPdtResponse As String
    Public Property paypalIpnIsSuccessful As Nullable(Of Boolean)
    Public Property paypalIpnConfirmDate As Nullable(Of Date)
    Public Property paypalIpnTransactionId As String
    Public Property paypalIpnResponse As String

    Public Overridable Property ORGANIZATION As ORGANIZATION
    Public Overridable Property USER As USER

End Class
