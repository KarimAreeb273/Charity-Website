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

Partial Public Class USER
    Public Property userId As Integer
    Public Property email As String
    Public Property passwordEncrypted As String
    Public Property socialSecurityNumberEncrypted As String
    Public Property firstName As String
    Public Property middleName As String
    Public Property lastName As String
    Public Property gender As String
    Public Property maritalStatus As String
    Public Property dob As Nullable(Of Date)
    Public Property nationalityId As Nullable(Of Integer)
    Public Property citizenshipStatus As String
    Public Property phone As String
    Public Property street As String
    Public Property city As String
    Public Property stateAbbr As String
    Public Property zip As String
    Public Property beganLivingDate As Nullable(Of Date)
    Public Property homeType As String
    Public Property homeTypeOther As String
    Public Property husbandFirstName As String
    Public Property husbandMiddleName As String
    Public Property husbandLastName As String
    Public Property husbandPhone As String
    Public Property husbandEmail As String
    Public Property highestEducationCompleted As String
    Public Property isInternationalSchool As Nullable(Of Boolean)
    Public Property schoolName As String
    Public Property schoolCountryId As Nullable(Of Integer)
    Public Property schoolStreet As String
    Public Property schoolCity As String
    Public Property schoolStateAbbr As String
    Public Property schoolZip As String
    Public Property primaryMasjidName As String
    Public Property primaryMasjidPhone As String
    Public Property createdOn As Nullable(Of Date)
    Public Property createdBy As Nullable(Of Integer)
    Public Property updatedOn As Nullable(Of Date)
    Public Property updatedBy As Nullable(Of Integer)

    Public Overridable Property CERTIFICATION_SKILL As ICollection(Of CERTIFICATION_SKILL) = New HashSet(Of CERTIFICATION_SKILL)
    Public Overridable Property COUNTRY As COUNTRY
    Public Overridable Property DEPENDENT As ICollection(Of DEPENDENT) = New HashSet(Of DEPENDENT)
    Public Overridable Property NATIONALITY As NATIONALITY
    Public Overridable Property REFERENCE As ICollection(Of REFERENCE) = New HashSet(Of REFERENCE)
    Public Overridable Property REVIEW As ICollection(Of REVIEW) = New HashSet(Of REVIEW)
    Public Overridable Property STATE As STATE
    Public Overridable Property STATE1 As STATE
    Public Overridable Property USER_LANGUAGE As ICollection(Of USER_LANGUAGE) = New HashSet(Of USER_LANGUAGE)
    Public Overridable Property USER_ROLE As ICollection(Of USER_ROLE) = New HashSet(Of USER_ROLE)
    Public Overridable Property APPLICATION As ICollection(Of APPLICATION) = New HashSet(Of APPLICATION)

End Class
