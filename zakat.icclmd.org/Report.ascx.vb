Imports System.Data.Entity.Migrations
Imports System.Web.Configuration

Public Class Report
  Inherits System.Web.UI.UserControl

#Region "Control Enumerations"
  Enum eMode As Short
    Area = 1
    Bar = 2
    Column = 3
    Grid = 4
    Line = 5
    Map = 6
    Pie = 7
    Table = 8
  End Enum
#End Region

#Region "Control Members"
  Private _ucMode As eMode
  Private _ucTitle As String
  Private _ucTitleVisible As Boolean
  Private _ucJscript As String

#End Region

#Region "Control Properties"
  Public Property ucMode() As String
    Get
      Return _ucMode
    End Get
    Set(ByVal value As String)
      _ucMode = value
    End Set
  End Property

  Public Property ucTitle() As String
    Get
      Return _ucTitle
    End Get
    Set(ByVal value As String)
      _ucTitle = value
    End Set
  End Property

  Public Property ucTitleVisible() As Boolean
    Get
      Return _ucTitleVisible
    End Get
    Set(ByVal value As Boolean)
      _ucTitleVisible = value
    End Set
  End Property

  Public Property ucJscript() As String
    Get
      Return _ucJscript
    End Get
    Set(ByVal value As String)
      _ucJscript = value
    End Set
  End Property

#End Region
  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      lblTitle.Text = ucTitle
      divTitle.Visible = ucTitleVisible
      Dim x As String = ucJscript
      Dim vDivID As String = "div" & Me.ID
      If ucMode <> eMode.Table Then
        'create a div control
        Dim cDiv As New HtmlGenericControl
        cDiv.TagName = "div"
        cDiv.Attributes.Add("id", vDivID)
        cDiv.Attributes.Add("style", "width: 100%; height: 375px; font-family: Verdana;")
        phScript.Controls.Add(cDiv)
      End If
      Select Case ucMode
        Case eMode.Area
          'setAreaChart(vDivID)
        Case eMode.Bar
          setBarChart(vDivID)
        Case eMode.Column
          setColumnChart(vDivID)
        Case eMode.Line
          setLineChart(vDivID)
        Case eMode.Map
          'setMapChart(vDivID)
        Case eMode.Pie
          setPieChart(vDivID)
        Case eMode.Table
          'setTableChart()
        Case eMode.Grid
          'setGridChart(vDivID)
      End Select
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setBarChart(pDiv As String)
    Try
      Dim cScript As New HtmlGenericControl
      cScript.TagName = "script"
      cScript.Attributes.Add("type", "text/javascript")
      cScript.InnerHtml = ucJscript.ToString
      phScript.Controls.Add(cScript)
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setColumnChart(pDiv As String)
    Try
      Dim cScript As New HtmlGenericControl
      cScript.TagName = "script"
      cScript.Attributes.Add("type", "text/javascript")
      cScript.InnerHtml = ucJscript.ToString
      phScript.Controls.Add(cScript)
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setPieChart(pDiv As String)
    Try
      Dim cScript As New HtmlGenericControl
      cScript.TagName = "script"
      cScript.Attributes.Add("type", "text/javascript")
      cScript.InnerHtml = ucJscript.ToString
      phScript.Controls.Add(cScript)
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setLineChart(pDiv As String)
    Try
      Dim cScript As New HtmlGenericControl
      cScript.TagName = "script"
      cScript.Attributes.Add("type", "text/javascript")
      cScript.InnerHtml = ucJscript.ToString
      phScript.Controls.Add(cScript)
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

End Class