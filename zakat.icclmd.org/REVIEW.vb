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

Partial Public Class REVIEW
    Public Property reviewId As Integer
    Public Property userId As Nullable(Of Integer)
    Public Property applicationId As Nullable(Of Integer)
    Public Property reviewAction As String
    Public Property reviewComment As String
    Public Property reviewDate As Nullable(Of Date)

    Public Overridable Property APPLICATION As APPLICATION
    Public Overridable Property USER As USER

End Class
