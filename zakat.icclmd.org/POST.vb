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

Partial Public Class POST
    Public Property postId As Integer
    Public Property postParentId As Nullable(Of Integer)
    Public Property postCategoryId As Integer
    Public Property postTitle As String
    Public Property postContent As String
    Public Property hasPosts As Boolean
    Public Property postCreatedOn As Date
    Public Property postUpdatedOn As Nullable(Of Date)
    Public Property postCreatedBy As Integer

    Public Overridable Property POST_CATEGORY As POST_CATEGORY

End Class