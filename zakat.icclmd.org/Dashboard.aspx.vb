Public Class Dashboard
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'check permissions for this page
      If Not (Base.CheckPermission(Session("sUserID"), Base.enumRole.Administrator)) Then
        Response.Redirect("/")
      End If

      If Not IsPostBack Then
        'populate year dropdowns for various charts
        drpApplicationsByGenderByYear.Items.Add(New ListItem("All Years", "All"))
        drpApplicationsByGenderByNationalityByYear.Items.Add(New ListItem("All Years", "All"))
        For i = 2020 To Now.Year
          drpApplicationsByGenderByYear.Items.Add(New ListItem(i, i))
          drpApplicationsByGenderByNationalityByYear.Items.Add(New ListItem(i, i))
        Next
      End If
      setApplicationsOverThreeYears()
      setApplicationsSubmittedByGender()
      setApplicationsSubmittedByNationality()
      setApplicationsSubmittedByAgeGroup()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setApplicationsOverThreeYears()
    Try
      Dim vCurrentYear As Integer = Date.Now.Year
      Dim vLastYear As Integer = Date.Now.Year - 1
      Dim vTwoYearsAgo As Integer = Date.Now.Year - 2
      Dim Year1SubmittedCount As Integer
      Dim Year2SubmittedCount As Integer
      Dim Year3SubmittedCount As Integer
      Dim Year1ValidatedCount As Integer
      Dim Year2ValidatedCount As Integer
      Dim Year3ValidatedCount As Integer
      Dim Year1InvestigatedCount As Integer
      Dim Year2InvestigatedCount As Integer
      Dim Year3InvestigatedCount As Integer
      Dim Year1QualifiedCount As Integer
      Dim Year2QualifiedCount As Integer
      Dim Year3QualifiedCount As Integer
      Dim Year1DispersedCount As Integer
      Dim Year2DispersedCount As Integer
      Dim Year3DispersedCount As Integer
      Dim Year1RejectedCount As Integer
      Dim Year2RejectedCount As Integer
      Dim Year3RejectedCount As Integer

      Using oDB As New zakatEntities
        Year1SubmittedCount = (From VW_APPLICATIONS_SUBMITTED_BY_YEAR In oDB.VW_APPLICATIONS_SUBMITTED_BY_YEAR Where VW_APPLICATIONS_SUBMITTED_BY_YEAR.applicationYear = vTwoYearsAgo).Count
        Year2SubmittedCount = (From VW_APPLICATIONS_SUBMITTED_BY_YEAR In oDB.VW_APPLICATIONS_SUBMITTED_BY_YEAR Where VW_APPLICATIONS_SUBMITTED_BY_YEAR.applicationYear = vLastYear).Count
        Year3SubmittedCount = (From VW_APPLICATIONS_SUBMITTED_BY_YEAR In oDB.VW_APPLICATIONS_SUBMITTED_BY_YEAR Where VW_APPLICATIONS_SUBMITTED_BY_YEAR.applicationYear = vCurrentYear).Count
        Year1ValidatedCount = (From VW_APPLICATIONS_VALIDATED_BY_YEAR In oDB.VW_APPLICATIONS_VALIDATED_BY_YEAR Where VW_APPLICATIONS_VALIDATED_BY_YEAR.applicationYear = vTwoYearsAgo).Count
        Year2ValidatedCount = (From VW_APPLICATIONS_VALIDATED_BY_YEAR In oDB.VW_APPLICATIONS_VALIDATED_BY_YEAR Where VW_APPLICATIONS_VALIDATED_BY_YEAR.applicationYear = vLastYear).Count
        Year3ValidatedCount = (From VW_APPLICATIONS_VALIDATED_BY_YEAR In oDB.VW_APPLICATIONS_VALIDATED_BY_YEAR Where VW_APPLICATIONS_VALIDATED_BY_YEAR.applicationYear = vCurrentYear).Count
        Year1InvestigatedCount = (From VW_APPLICATIONS_INVESTIGATED_BY_YEAR In oDB.VW_APPLICATIONS_INVESTIGATED_BY_YEAR Where VW_APPLICATIONS_INVESTIGATED_BY_YEAR.applicationYear = vTwoYearsAgo).Count
        Year2InvestigatedCount = (From VW_APPLICATIONS_INVESTIGATED_BY_YEAR In oDB.VW_APPLICATIONS_INVESTIGATED_BY_YEAR Where VW_APPLICATIONS_INVESTIGATED_BY_YEAR.applicationYear = vLastYear).Count
        Year3InvestigatedCount = (From VW_APPLICATIONS_INVESTIGATED_BY_YEAR In oDB.VW_APPLICATIONS_INVESTIGATED_BY_YEAR Where VW_APPLICATIONS_INVESTIGATED_BY_YEAR.applicationYear = vCurrentYear).Count
        Year1QualifiedCount = (From VW_APPLICATIONS_QUALIFIED_BY_YEAR In oDB.VW_APPLICATIONS_QUALIFIED_BY_YEAR Where VW_APPLICATIONS_QUALIFIED_BY_YEAR.applicationYear = vTwoYearsAgo).Count
        Year2QualifiedCount = (From VW_APPLICATIONS_QUALIFIED_BY_YEAR In oDB.VW_APPLICATIONS_QUALIFIED_BY_YEAR Where VW_APPLICATIONS_QUALIFIED_BY_YEAR.applicationYear = vLastYear).Count
        Year3QualifiedCount = (From VW_APPLICATIONS_QUALIFIED_BY_YEAR In oDB.VW_APPLICATIONS_QUALIFIED_BY_YEAR Where VW_APPLICATIONS_QUALIFIED_BY_YEAR.applicationYear = vCurrentYear).Count
        Year1DispersedCount = (From VW_APPLICATIONS_DISPERSED_BY_YEAR In oDB.VW_APPLICATIONS_DISPERSED_BY_YEAR Where VW_APPLICATIONS_DISPERSED_BY_YEAR.applicationYear = vTwoYearsAgo).Count
        Year2DispersedCount = (From VW_APPLICATIONS_DISPERSED_BY_YEAR In oDB.VW_APPLICATIONS_DISPERSED_BY_YEAR Where VW_APPLICATIONS_DISPERSED_BY_YEAR.applicationYear = vLastYear).Count
        Year3DispersedCount = (From VW_APPLICATIONS_DISPERSED_BY_YEAR In oDB.VW_APPLICATIONS_DISPERSED_BY_YEAR Where VW_APPLICATIONS_DISPERSED_BY_YEAR.applicationYear = vCurrentYear).Count
        Year1RejectedCount = (From VW_APPLICATIONS_REJECTED_BY_YEAR In oDB.VW_APPLICATIONS_REJECTED_BY_YEAR Where VW_APPLICATIONS_REJECTED_BY_YEAR.applicationYear = vTwoYearsAgo).Count
        Year2RejectedCount = (From VW_APPLICATIONS_REJECTED_BY_YEAR In oDB.VW_APPLICATIONS_REJECTED_BY_YEAR Where VW_APPLICATIONS_REJECTED_BY_YEAR.applicationYear = vLastYear).Count
        Year3RejectedCount = (From VW_APPLICATIONS_REJECTED_BY_YEAR In oDB.VW_APPLICATIONS_REJECTED_BY_YEAR Where VW_APPLICATIONS_REJECTED_BY_YEAR.applicationYear = vCurrentYear).Count
      End Using

      Dim vJscript As New StringBuilder
      vJscript.Append("google.charts.load('current', {packages: ['corechart', 'bar']});")
      vJscript.Append("google.charts.setOnLoadCallback(drawMaterial);")
      vJscript.Append("function drawMaterial() {")
      vJscript.Append("var data = google.visualization.arrayToDataTable([")
      vJscript.Append("['Year', 'Submitted', 'Validated', 'Investigated', 'Qualified', 'Dispersed', 'Rejected'],")
      vJscript.Append("['" & CStr(vTwoYearsAgo) & "'," & Year1SubmittedCount & "," & Year1ValidatedCount & "," & Year1InvestigatedCount & "," & Year1QualifiedCount & "," & Year1DispersedCount & "," & Year1RejectedCount & ",],")
      vJscript.Append("['" & CStr(vLastYear) & "'," & Year2SubmittedCount & "," & Year2ValidatedCount & "," & Year2InvestigatedCount & "," & Year2QualifiedCount & "," & Year2DispersedCount & "," & Year2RejectedCount & ",],")
      vJscript.Append("['" & CStr(vCurrentYear) & "'," & Year3SubmittedCount & "," & Year3ValidatedCount & "," & Year3InvestigatedCount & "," & Year3QualifiedCount & "," & Year3DispersedCount & "," & Year3RejectedCount & ",],")
      vJscript.Append("]);")
      vJscript.Append("var materialOptions = {")
      vJscript.Append("width: 750,")
      vJscript.Append("bars: 'horizontal',")
      vJscript.Append("colors: ['#FFA500', '#FFFF00', '#800080', '#00008B', '#008000', '#FF0000']")
      vJscript.Append("};")
      vJscript.Append("var materialChart = new google.charts.Bar(document.getElementById('divucChartApplicationsOverThreeYears'));")
      vJscript.Append("materialChart.draw(data, materialOptions);")
      vJscript.Append("}")

      Dim ucChartApplicationsOverThreeYears As New Report
      ucChartApplicationsOverThreeYears = LoadControl("Report.ascx")
      With ucChartApplicationsOverThreeYears
        .ID = "ucChartApplicationsOverThreeYears"
        .ucMode = Report.eMode.Bar
        .ucTitle = "Applications Over The Last Three (3) Years"
        .ucTitleVisible = True
        .ucJscript = vJscript.ToString
      End With
      phChartTopLeft.Controls.Add(ucChartApplicationsOverThreeYears)
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setApplicationsSubmittedByGender()
    Try
      Dim vYear As Integer
      Dim vMaleCount As Integer
      Dim vFemaleCount As Integer

      Using oDB As New zakatEntities
        If drpApplicationsByGenderByYear.SelectedItem.Value = "All" Then
          vMaleCount = (From APPLICATION In oDB.APPLICATION Where APPLICATION.isSubmitted = True AndAlso APPLICATION.USER.gender = "Male").Count
          vFemaleCount = (From APPLICATION In oDB.APPLICATION Where APPLICATION.isSubmitted = True AndAlso APPLICATION.USER.gender = "Female").Count
        Else
          vYear = drpApplicationsByGenderByYear.SelectedItem.Value
          vMaleCount = (From APPLICATION In oDB.APPLICATION Where APPLICATION.isSubmitted = True AndAlso Year(APPLICATION.submittedOn) = vYear AndAlso APPLICATION.USER.gender = "Male").Count
          vFemaleCount = (From APPLICATION In oDB.APPLICATION Where APPLICATION.isSubmitted = True AndAlso Year(APPLICATION.submittedOn) = vYear AndAlso APPLICATION.USER.gender = "Female").Count
        End If
      End Using

      Dim vJscript As New StringBuilder
      vJscript.Append("google.charts.load('current', {'packages':['corechart']});")
      vJscript.Append("google.charts.setOnLoadCallback(drawChart);")
      vJscript.Append("function drawChart() {")
      vJscript.Append("var data = google.visualization.arrayToDataTable([")
      vJscript.Append("['Gender', 'Applications'],")
      vJscript.Append("['Male'," & vMaleCount & "],")
      vJscript.Append("['Female'," & vFemaleCount & "]")
      vJscript.Append("]);")
      vJscript.Append("var options = {")
      vJscript.Append("title: 'Applications Submitted By Gender',")
      'vJscript.Append("pieHole: 0.4,")
      vJscript.Append("is3D: true,")
      vJscript.Append("legend: 'none',")
      vJscript.Append("pieSliceText: 'label'")
      vJscript.Append("};")
      vJscript.Append("var chart = new google.visualization.PieChart(document.getElementById('divucChartApplicationsSubmittedByGender'));")
      vJscript.Append("chart.draw(data, options);")
      vJscript.Append("}")

      Dim ucChartApplicationsSubmittedByGender As New Report
      ucChartApplicationsSubmittedByGender = LoadControl("Report.ascx")
      With ucChartApplicationsSubmittedByGender
        .ID = "ucChartApplicationsSubmittedByGender"
        .ucMode = Report.eMode.Pie
        .ucTitle = "Applications Submitted By Gender"
        .ucTitleVisible = False
        .ucJscript = vJscript.ToString
      End With
      phChartTopRight.Controls.Add(ucChartApplicationsSubmittedByGender)
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setApplicationsSubmittedByNationality()
    Try
      Dim vYear As Integer
      Dim vIsUsingYear As Boolean = False
      Dim arrNationality

      Using oDB As New zakatEntities
        If drpApplicationsByGenderByNationalityByYear.SelectedItem.Value = "All" Then
          arrNationality = (From APPLICATION In oDB.APPLICATION
                            Where APPLICATION.isSubmitted = True
                            Select New With {
                                  Key .nationalityId = APPLICATION.USER.NATIONALITY.nationalityId,
                                  Key .name = APPLICATION.USER.NATIONALITY.name}).Distinct.ToList
        Else
          vIsUsingYear = True
          vYear = drpApplicationsByGenderByNationalityByYear.SelectedItem.Value
          arrNationality = (From APPLICATION In oDB.APPLICATION
                            Where APPLICATION.isSubmitted = True AndAlso
                                  Year(APPLICATION.submittedOn) = vYear
                            Select New With {
                                  Key .nationalityId = APPLICATION.USER.NATIONALITY.nationalityId,
                                  Key .name = APPLICATION.USER.NATIONALITY.name}).Distinct.ToList
        End If

        Dim vJscript As New StringBuilder
        vJscript.Append("google.charts.load('current', {'packages':['corechart']});")
        vJscript.Append("google.charts.setOnLoadCallback(drawChart);")
        vJscript.Append("function drawChart() {")
        vJscript.Append("var data = google.visualization.arrayToDataTable([")
        vJscript.Append("['Nationality', 'Applications'],")
        'create a variable to store the total records processed
        Dim vTotalRecordCount As Integer = 0
        For Each item In arrNationality
          vTotalRecordCount += 1
          If vIsUsingYear Then
            vJscript.Append("['" & item.name & "'," & GetApplicationCountByNationality(item.nationalityId, vYear) & "]")
          Else
            vJscript.Append("['" & item.name & "'," & GetApplicationCountByNationality(item.nationalityId) & "]")
          End If

          'only add a comma in the string if the total record count is not equal to the nationality array count
          If vTotalRecordCount <> arrNationality.Count Then
            vJscript.Append(",")
          End If
        Next
        vJscript.Append("]);")
        vJscript.Append("var options = {")
        vJscript.Append("title: 'Applications Submitted By Nationality',")
        'vJscript.Append("pieHole: 0.4,")
        vJscript.Append("legend: 'none',")
        vJscript.Append("pieSliceText: 'label'")
        vJscript.Append("};")
        vJscript.Append("var chart = new google.visualization.PieChart(document.getElementById('divucChartApplicationsSubmittedByNationality'));")
        vJscript.Append("chart.draw(data, options);")
        vJscript.Append("}")

        Dim ucChartApplicationsSubmittedByNationality As New Report
        ucChartApplicationsSubmittedByNationality = LoadControl("Report.ascx")
        With ucChartApplicationsSubmittedByNationality
          .ID = "ucChartApplicationsSubmittedByNationality"
          .ucMode = Report.eMode.Pie
          .ucTitle = "Applications Submitted By Nationality"
          .ucTitleVisible = False
          .ucJscript = vJscript.ToString
        End With
        phChartBottomLeft.Controls.Add(ucChartApplicationsSubmittedByNationality)
      End Using
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setApplicationsSubmittedByAgeGroup()
    Try
      Dim vGroup1SubmittedCount As Integer
      Dim vGroup1DispersedCount As Integer
      Dim vGroup1RejectedCount As Integer
      Dim vGroup2SubmittedCount As Integer
      Dim vGroup2DispersedCount As Integer
      Dim vGroup2RejectedCount As Integer
      Dim vGroup3SubmittedCount As Integer
      Dim vGroup3DispersedCount As Integer
      Dim vGroup3RejectedCount As Integer
      Dim vGroup4SubmittedCount As Integer
      Dim vGroup4DispersedCount As Integer
      Dim vGroup4RejectedCount As Integer
      Dim vGroup5SubmittedCount As Integer
      Dim vGroup5DispersedCount As Integer
      Dim vGroup5RejectedCount As Integer

      Using oDB As New zakatEntities
        vGroup1SubmittedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isSubmitted = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 20).Count
        vGroup1DispersedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isDispersed = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 20).Count
        vGroup1RejectedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isRejected = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 20).Count
        vGroup2SubmittedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isSubmitted = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 20 AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 35).Count
        vGroup2DispersedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isDispersed = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 20 AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 35).Count
        vGroup2RejectedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isRejected = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 20 AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 35).Count
        vGroup3SubmittedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isSubmitted = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 35 AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 50).Count
        vGroup3DispersedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isDispersed = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 35 AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 50).Count
        vGroup3RejectedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isRejected = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 35 AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 50).Count
        vGroup4SubmittedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isSubmitted = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 50 AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 65).Count
        vGroup4DispersedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isDispersed = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 50 AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 65).Count
        vGroup4RejectedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isRejected = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 50 AndAlso VW_APPLICATIONS_BY_USER_AGE.Age <= 65).Count
        vGroup5SubmittedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isSubmitted = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 65).Count
        vGroup5DispersedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isDispersed = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 65).Count
        vGroup5RejectedCount = (From VW_APPLICATIONS_BY_USER_AGE In oDB.VW_APPLICATIONS_BY_USER_AGE Where VW_APPLICATIONS_BY_USER_AGE.isRejected = True AndAlso VW_APPLICATIONS_BY_USER_AGE.Age > 65).Count
      End Using

      Dim vJscript As New StringBuilder

      vJscript.Append("google.charts.load('current', {'packages':['bar']});")
      vJscript.Append("google.charts.setOnLoadCallback(drawChart);")
      vJscript.Append("function drawChart() {")
      vJscript.Append("var data = google.visualization.arrayToDataTable([")
      vJscript.Append("['Age Group', 'Submitted', 'Dispersed', 'Rejected'],")
      vJscript.Append("['<= 20'," & vGroup1SubmittedCount & "," & vGroup1DispersedCount & "," & vGroup1RejectedCount & "],")
      vJscript.Append("['21 - 35'," & vGroup2SubmittedCount & "," & vGroup2DispersedCount & "," & vGroup2RejectedCount & "],")
      vJscript.Append("['36 - 50'," & vGroup3SubmittedCount & "," & vGroup3DispersedCount & "," & vGroup3RejectedCount & "],")
      vJscript.Append("['51 - 65'," & vGroup4SubmittedCount & "," & vGroup4DispersedCount & "," & vGroup4RejectedCount & "],")
      vJscript.Append("['> 65'," & vGroup5SubmittedCount & "," & vGroup5DispersedCount & "," & vGroup5RejectedCount & "]")
      vJscript.Append("]);")
      vJscript.Append("var options = {")
      vJscript.Append("chart: {")
      vJscript.Append("title: 'Applications By Age Group',")
      vJscript.Append("subtitle: 'Submissions, Disbursements, and Rejections',")
      vJscript.Append("},")
      vJscript.Append("bars: 'vertical',")
      vJscript.Append("width: 750,")
      vJscript.Append("height: 375,")
      vJscript.Append("colors: ['#FFA500', '#008000', '#FF0000']")
      vJscript.Append("};")
      vJscript.Append("var chart = new google.charts.Bar(document.getElementById('divucChartApplicationsSubmittedByAgeGroup'));")
      vJscript.Append("chart.draw(data, google.charts.Bar.convertOptions(options));")
      vJscript.Append("}")

      Dim ucChartApplicationsSubmittedByAgeGroup As New Report
      ucChartApplicationsSubmittedByAgeGroup = LoadControl("Report.ascx")
      With ucChartApplicationsSubmittedByAgeGroup
        .ID = "ucChartApplicationsSubmittedByAgeGroup"
        .ucMode = Report.eMode.Column
        .ucTitle = "Applications By Age Group"
        .ucTitleVisible = True
        .ucJscript = vJscript.ToString
      End With
      phChartBottomRight.Controls.Add(ucChartApplicationsSubmittedByAgeGroup)
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Function GetApplicationCountByNationality(pNationalityId As Integer, Optional pYear As Integer = 0) As Integer
    Try
      Using oDB As New zakatEntities
        If pYear = 0 Then
          Return (From APPLICATION In oDB.APPLICATION Where APPLICATION.isSubmitted = True AndAlso APPLICATION.USER.nationalityId = pNationalityId).Count
        Else
          Return (From APPLICATION In oDB.APPLICATION Where APPLICATION.isSubmitted = True AndAlso Year(APPLICATION.submittedOn) = pYear AndAlso APPLICATION.USER.nationalityId = pNationalityId).Count
        End If
      End Using
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
      Return 0
    End Try
  End Function
End Class