﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated from a template.
'
'     Manual changes to this file may cause unexpected behavior in your application.
'     Manual changes to this file will be overwritten if the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Imports System
Imports System.Data.Entity
Imports System.Data.Entity.Infrastructure

Partial Public Class zakatEntities
    Inherits DbContext

    Public Sub New()
        MyBase.New("name=zakatEntities")
    End Sub

    Protected Overrides Sub OnModelCreating(modelBuilder As DbModelBuilder)
        Throw New UnintentionalCodeFirstException()
    End Sub

    Public Overridable Property CERTIFICATION_SKILL() As DbSet(Of CERTIFICATION_SKILL)
    Public Overridable Property LANGUAGE() As DbSet(Of LANGUAGE)
    Public Overridable Property NATIONALITY() As DbSet(Of NATIONALITY)
    Public Overridable Property ORGANIZATION() As DbSet(Of ORGANIZATION)
    Public Overridable Property REFERENCE() As DbSet(Of REFERENCE)
    Public Overridable Property ROLE() As DbSet(Of ROLE)
    Public Overridable Property STATE() As DbSet(Of STATE)
    Public Overridable Property USER_LANGUAGE() As DbSet(Of USER_LANGUAGE)
    Public Overridable Property DEPENDENT() As DbSet(Of DEPENDENT)
    Public Overridable Property USER_ROLE() As DbSet(Of USER_ROLE)
    Public Overridable Property REVIEW() As DbSet(Of REVIEW)
    Public Overridable Property APPLICATION() As DbSet(Of APPLICATION)
    Public Overridable Property USER() As DbSet(Of USER)
    Public Overridable Property ARTIFACT() As DbSet(Of ARTIFACT)
    Public Overridable Property ARTIFACT_TYPE() As DbSet(Of ARTIFACT_TYPE)

End Class
