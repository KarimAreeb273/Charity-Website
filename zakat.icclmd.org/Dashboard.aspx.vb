Public Class Dashboard
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'check permissions for this page
      If Not (Base.CheckPermission(Session("sUserID"), Base.enumRole.Administrator)) Then
        Response.Redirect("/")
      End If

      setApplicationsOverThreeYears()

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setApplicationsOverThreeYears()
    Try
      'Dim vTop As Integer = 7
      Dim vCurrentYear As Integer = Date.Now.Year
      Dim vLastYear As Integer = Date.Now.Year - 1
      Dim vTwoYearsAgo As Integer = Date.Now.Year - 2
      Dim Year1SubmittedCount As Integer
      Dim Year2SubmittedCount As Integer
      Dim Year3SubmittedCount As Integer
      Dim Year1InvestigatedCount As Integer
      Dim Year2InvestigatedCount As Integer
      Dim Year3InvestigatedCount As Integer
      Dim Year1QualifiedCount As Integer
      Dim Year2QualifiedCount As Integer
      Dim Year3QualifiedCount As Integer
      Dim Year1DispersedCount As Integer
      Dim Year2DispersedCount As Integer
      Dim Year3DispersedCount As Integer

      Using oDB As New zakatEntities
        Year1SubmittedCount = (From VW_APPLICATIONS_SUBMITTED_BY_YEAR In oDB.VW_APPLICATIONS_SUBMITTED_BY_YEAR Where VW_APPLICATIONS_SUBMITTED_BY_YEAR.applicationYear = vTwoYearsAgo).Count
        Year2SubmittedCount = (From VW_APPLICATIONS_SUBMITTED_BY_YEAR In oDB.VW_APPLICATIONS_SUBMITTED_BY_YEAR Where VW_APPLICATIONS_SUBMITTED_BY_YEAR.applicationYear = vLastYear).Count
        Year3SubmittedCount = (From VW_APPLICATIONS_SUBMITTED_BY_YEAR In oDB.VW_APPLICATIONS_SUBMITTED_BY_YEAR Where VW_APPLICATIONS_SUBMITTED_BY_YEAR.applicationYear = vCurrentYear).Count
        Year1InvestigatedCount = (From VW_APPLICATIONS_INVESTIGATED_BY_YEAR In oDB.VW_APPLICATIONS_INVESTIGATED_BY_YEAR Where VW_APPLICATIONS_INVESTIGATED_BY_YEAR.applicationYear = vTwoYearsAgo).Count
        Year2InvestigatedCount = (From VW_APPLICATIONS_INVESTIGATED_BY_YEAR In oDB.VW_APPLICATIONS_INVESTIGATED_BY_YEAR Where VW_APPLICATIONS_INVESTIGATED_BY_YEAR.applicationYear = vLastYear).Count
        Year3InvestigatedCount = (From VW_APPLICATIONS_INVESTIGATED_BY_YEAR In oDB.VW_APPLICATIONS_INVESTIGATED_BY_YEAR Where VW_APPLICATIONS_INVESTIGATED_BY_YEAR.applicationYear = vCurrentYear).Count
        Year1QualifiedCount = (From VW_APPLICATIONS_QUALIFIED_BY_YEAR In oDB.VW_APPLICATIONS_QUALIFIED_BY_YEAR Where VW_APPLICATIONS_QUALIFIED_BY_YEAR.applicationYear = vTwoYearsAgo).Count
        Year2QualifiedCount = (From VW_APPLICATIONS_QUALIFIED_BY_YEAR In oDB.VW_APPLICATIONS_QUALIFIED_BY_YEAR Where VW_APPLICATIONS_QUALIFIED_BY_YEAR.applicationYear = vLastYear).Count
        Year3QualifiedCount = (From VW_APPLICATIONS_QUALIFIED_BY_YEAR In oDB.VW_APPLICATIONS_QUALIFIED_BY_YEAR Where VW_APPLICATIONS_QUALIFIED_BY_YEAR.applicationYear = vCurrentYear).Count
        Year1DispersedCount = (From VW_APPLICATIONS_DISPERSED_BY_YEAR In oDB.VW_APPLICATIONS_DISPERSED_BY_YEAR Where VW_APPLICATIONS_DISPERSED_BY_YEAR.applicationYear = vTwoYearsAgo).Count
        Year2DispersedCount = (From VW_APPLICATIONS_DISPERSED_BY_YEAR In oDB.VW_APPLICATIONS_DISPERSED_BY_YEAR Where VW_APPLICATIONS_DISPERSED_BY_YEAR.applicationYear = vLastYear).Count
        Year3DispersedCount = (From VW_APPLICATIONS_DISPERSED_BY_YEAR In oDB.VW_APPLICATIONS_DISPERSED_BY_YEAR Where VW_APPLICATIONS_DISPERSED_BY_YEAR.applicationYear = vCurrentYear).Count
      End Using

      Dim vJscript As New StringBuilder
      vJscript.Append("google.charts.load('current', {packages: ['corechart', 'bar']});")
      vJscript.Append("google.charts.setOnLoadCallback(drawMaterial);")
      vJscript.Append("function drawMaterial() {")
      vJscript.Append("var data = google.visualization.arrayToDataTable([")
      vJscript.Append("['Year', 'Submitted', 'Investigated', 'Qualified', 'Dispersed'],")
      vJscript.Append("['" & CStr(vTwoYearsAgo) & "'," & Year1SubmittedCount & "," & Year1InvestigatedCount & "," & Year1QualifiedCount & "," & Year1DispersedCount & ",],")
      vJscript.Append("['" & CStr(vLastYear) & "'," & Year2SubmittedCount & "," & Year2InvestigatedCount & "," & Year2QualifiedCount & "," & Year2DispersedCount & ",],")
      vJscript.Append("['" & CStr(vCurrentYear) & "'," & Year3SubmittedCount & "," & Year3InvestigatedCount & "," & Year3QualifiedCount & "," & Year3DispersedCount & ",],")
      vJscript.Append("]);")
      vJscript.Append("var materialOptions = {")
      'vJscript.Append("chart: {")
      'vJscript.Append("title: 'Applications Over The Last 3 Years'")
      'vJscript.Append("},")
      vJscript.Append("bars: 'horizontal'")
      vJscript.Append("};")
      vJscript.Append("var materialChart = new google.charts.Bar(document.getElementById('divucChartApplicationsOverThreeYears'));")
      vJscript.Append("materialChart.draw(data, materialOptions);")
      vJscript.Append("}")

      Dim ucChartApplicationsOverThreeYears As New Report
      ucChartApplicationsOverThreeYears = LoadControl("Report.ascx")
      With ucChartApplicationsOverThreeYears
        .ID = "ucChartApplicationsOverThreeYears"
        .ucMode = Report.eMode.Bar
        .ucTitle = "Applications Over The Last 3 Years"
        .ucJscript = vJscript.ToString
      End With
      phChartTopLeft.Controls.Add(ucChartApplicationsOverThreeYears)
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

End Class