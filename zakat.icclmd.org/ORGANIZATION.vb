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

Partial Public Class ORGANIZATION
    Public Property organizationId As Integer
    Public Property name As String
    Public Property abbreviation As String
    Public Property street As String
    Public Property city As String
    Public Property stateAbbr As String
    Public Property zip As String
    Public Property email As String
    Public Property phone As String
    Public Property website As String
    Public Property isDonationAccepted As Nullable(Of Boolean)
    Public Property payPalImageURL As String
    Public Property payPalIdentityToken As String
    Public Property missionStatement As String

    Public Overridable Property APPLICATION As ICollection(Of APPLICATION) = New HashSet(Of APPLICATION)
    Public Overridable Property DONATION As ICollection(Of DONATION) = New HashSet(Of DONATION)
    Public Overridable Property STATE As STATE
    Public Overridable Property USER_ROLE As ICollection(Of USER_ROLE) = New HashSet(Of USER_ROLE)

End Class
