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

Partial Public Class STATE
    Public Property stateAbbr As String
    Public Property stateName As String

    Public Overridable Property APPLICATION As ICollection(Of APPLICATION) = New HashSet(Of APPLICATION)
    Public Overridable Property ORGANIZATION As ICollection(Of ORGANIZATION) = New HashSet(Of ORGANIZATION)
    Public Overridable Property REFERENCE As ICollection(Of REFERENCE) = New HashSet(Of REFERENCE)
    Public Overridable Property USER As ICollection(Of USER) = New HashSet(Of USER)
    Public Overridable Property USER1 As ICollection(Of USER) = New HashSet(Of USER)

End Class
