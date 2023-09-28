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
          drpAverageProcessingDaysByMonth.Items.Add(New ListItem(i, i))
          drpTotalDispersedByMonth.Items.Add(New ListItem(i, i))
        Next
      End If
      setApplicationsOverThreeYears()
      setApplicationsSubmittedByGender()
      setApplicationsSubmittedByNationality()
      setApplicationsSubmittedByAgeGroup()
      setAverageProcessingDaysByMonth()
      setTotalDispersedByMonth()
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
      phChartRow1Left.Controls.Add(ucChartApplicationsOverThreeYears)
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
      phChartRow1Right.Controls.Add(ucChartApplicationsSubmittedByGender)
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
        phChartRow2Left.Controls.Add(ucChartApplicationsSubmittedByNationality)
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
      phChartRow2Right.Controls.Add(ucChartApplicationsSubmittedByAgeGroup)
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setAverageProcessingDaysByMonth()
    Try
      Dim vSelectedYear As Integer = drpAverageProcessingDaysByMonth.SelectedValue
      Dim Month01Duration As Decimal
      Dim Month02Duration As Decimal
      Dim Month03Duration As Decimal
      Dim Month04Duration As Decimal
      Dim Month05Duration As Decimal
      Dim Month06Duration As Decimal
      Dim Month07Duration As Decimal
      Dim Month08Duration As Decimal
      Dim Month09Duration As Decimal
      Dim Month10Duration As Decimal
      Dim Month11Duration As Decimal
      Dim Month12Duration As Decimal
      Dim Month01Average As Decimal
      Dim Month02Average As Decimal
      Dim Month03Average As Decimal
      Dim Month04Average As Decimal
      Dim Month05Average As Decimal
      Dim Month06Average As Decimal
      Dim Month07Average As Decimal
      Dim Month08Average As Decimal
      Dim Month09Average As Decimal
      Dim Month10Average As Decimal
      Dim Month11Average As Decimal
      Dim Month12Average As Decimal
      Dim Month01Submissions As Integer
      Dim Month02Submissions As Integer
      Dim Month03Submissions As Integer
      Dim Month04Submissions As Integer
      Dim Month05Submissions As Integer
      Dim Month06Submissions As Integer
      Dim Month07Submissions As Integer
      Dim Month08Submissions As Integer
      Dim Month09Submissions As Integer
      Dim Month10Submissions As Integer
      Dim Month11Submissions As Integer
      Dim Month12Submissions As Integer

      Using oDB As New zakatEntities
        Dim oAverageProcessing As List(Of VW_APPLICATIONS_AVG_PROCESSING_DAYS)
        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 1).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 1).ToList
          For Each item In oAverageProcessing
            Month01Duration = Month01Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month01Average = Month01Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month01Average = 0
          Month01Duration = 0
        End If
        Month01Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 1).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 2).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 2).ToList
          For Each item In oAverageProcessing
            Month02Duration = Month02Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month02Average = Month02Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month02Average = 0
          Month02Duration = 0
        End If
        Month02Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 2).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 3).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 3).ToList
          For Each item In oAverageProcessing
            Month03Duration = Month03Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month03Average = Month03Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month03Average = 0
          Month03Duration = 0
        End If
        Month03Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 3).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 4).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 4).ToList
          For Each item In oAverageProcessing
            Month04Duration = Month04Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month04Average = Month04Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month04Average = 0
          Month04Duration = 0
        End If
        Month04Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 4).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 5).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 5).ToList
          For Each item In oAverageProcessing
            Month05Duration = Month05Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month05Average = Month05Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month05Average = 0
          Month05Duration = 0
        End If
        Month05Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 5).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 6).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 6).ToList
          For Each item In oAverageProcessing
            Month06Duration = Month06Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month06Average = Month06Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month06Average = 0
          Month06Duration = 0
        End If
        Month06Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 6).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 7).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 7).ToList
          For Each item In oAverageProcessing
            Month07Duration = Month07Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month07Average = Month07Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month07Average = 0
          Month07Duration = 0
        End If
        Month07Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 7).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 8).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 8).ToList
          For Each item In oAverageProcessing
            Month08Duration = Month08Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month08Average = Month08Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month08Average = 0
          Month08Duration = 0
        End If
        Month08Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 8).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 9).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 9).ToList
          For Each item In oAverageProcessing
            Month09Duration = Month09Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month09Average = Month09Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month09Average = 0
          Month09Duration = 0
        End If
        Month09Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 9).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 10).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 10).ToList
          For Each item In oAverageProcessing
            Month10Duration = Month10Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month10Average = Month10Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month10Average = 0
          Month10Duration = 0
        End If
        Month10Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 10).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 11).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 11).ToList
          For Each item In oAverageProcessing
            Month11Duration = Month11Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month11Average = Month11Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month11Average = 0
          Month11Duration = 0
        End If
        Month11Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 11).Count

        If (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 12).Any Then
          'given some records exist, populate report variables with actual values
          oAverageProcessing = (From VW_APPLICATIONS_AVG_PROCESSING_DAYS In oDB.VW_APPLICATIONS_AVG_PROCESSING_DAYS Where VW_APPLICATIONS_AVG_PROCESSING_DAYS.year = vSelectedYear AndAlso VW_APPLICATIONS_AVG_PROCESSING_DAYS.month = 12).ToList
          For Each item In oAverageProcessing
            Month12Duration = Month12Duration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          Month12Average = Month12Duration / oAverageProcessing.Count
        Else
          'given no records exist, populate report variables with placeholder values
          Month12Average = 0
          Month12Duration = 0
        End If
        Month12Submissions = (From APPLICATION In oDB.APPLICATION Where Year(APPLICATION.submittedOn) = vSelectedYear AndAlso Month(APPLICATION.submittedOn) = 12).Count
      End Using

      Dim vJscript As New StringBuilder
      vJscript.Append("google.charts.load('current', {'packages':['corechart']});")
      vJscript.Append("google.charts.setOnLoadCallback(drawChart);")
      vJscript.Append("function drawChart() {")
      vJscript.Append("var data = google.visualization.arrayToDataTable([")
      vJscript.Append("['Month', 'Average Processing Days','Submitted Applications'],")
      vJscript.Append("['Jan'," & FormatNumber(Month01Average, 1).ToString & "," & Month01Submissions.ToString & "],")
      vJscript.Append("['Feb'," & FormatNumber(Month02Average, 1).ToString & "," & Month02Submissions.ToString & "],")
      vJscript.Append("['Mar'," & FormatNumber(Month03Average, 1).ToString & "," & Month03Submissions.ToString & "],")
      vJscript.Append("['Apr'," & FormatNumber(Month04Average, 1).ToString & "," & Month04Submissions.ToString & "],")
      vJscript.Append("['May'," & FormatNumber(Month05Average, 1).ToString & "," & Month05Submissions.ToString & "],")
      vJscript.Append("['Jun'," & FormatNumber(Month06Average, 1).ToString & "," & Month06Submissions.ToString & "],")
      vJscript.Append("['Jul'," & FormatNumber(Month07Average, 1).ToString & "," & Month07Submissions.ToString & "],")
      vJscript.Append("['Aug'," & FormatNumber(Month08Average, 1).ToString & "," & Month08Submissions.ToString & "],")
      vJscript.Append("['Sep'," & FormatNumber(Month09Average, 1).ToString & "," & Month09Submissions.ToString & "],")
      vJscript.Append("['Oct'," & FormatNumber(Month10Average, 1).ToString & "," & Month10Submissions.ToString & "],")
      vJscript.Append("['Nov'," & FormatNumber(Month11Average, 1).ToString & "," & Month11Submissions.ToString & "],")
      vJscript.Append("['Dec'," & FormatNumber(Month12Average, 1).ToString & "," & Month12Submissions.ToString & "]")
      vJscript.Append("]);")
      vJscript.Append("var options = {")
      vJscript.Append("title: 'Submitted Applications / Average Processing Days By Year and Month',")
      vJscript.Append("curveType: 'function',")
      vJscript.Append("pointSize: 5,")
      vJscript.Append("legend: { position: 'bottom' },")
      'vJscript.Append("vAxis: {")
      'vJscript.Append("title: 'Days'")
      'vJscript.Append("},")
      vJscript.Append("colors: ['blue', 'orange']")
      vJscript.Append("};")
      vJscript.Append("var chart = new google.visualization.LineChart(document.getElementById('divucChartApplicationsAverageProcessingDaysByMonth'));")
      vJscript.Append("chart.draw(data, options);")
      vJscript.Append("}")

      Dim ucChartApplicationsAverageProcessingDaysByMonth As New Report
      ucChartApplicationsAverageProcessingDaysByMonth = LoadControl("Report.ascx")
      With ucChartApplicationsAverageProcessingDaysByMonth
        .ID = "ucChartApplicationsAverageProcessingDaysByMonth"
        .ucMode = Report.eMode.Line
        .ucTitle = "Average Processing Days By Year and Month"
        .ucTitleVisible = False
        .ucJscript = vJscript.ToString
      End With
      phChartRow3Left.Controls.Add(ucChartApplicationsAverageProcessingDaysByMonth)
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setTotalDispersedByMonth()
    Try
      Dim vSelectedYear As Integer = drpTotalDispersedByMonth.SelectedValue
      Dim Month01Total As Decimal
      Dim Month02Total As Decimal
      Dim Month03Total As Decimal
      Dim Month04Total As Decimal
      Dim Month05Total As Decimal
      Dim Month06Total As Decimal
      Dim Month07Total As Decimal
      Dim Month08Total As Decimal
      Dim Month09Total As Decimal
      Dim Month10Total As Decimal
      Dim Month11Total As Decimal
      Dim Month12Total As Decimal

      Using oDB As New zakatEntities
        Dim oApplication As List(Of VW_APPLICATIONS_TOTAL_DISPERSED)
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 1).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 1).ToList
          For Each item In oApplication
            Month01Total = Month01Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month01Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 2).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 2).ToList
          For Each item In oApplication
            Month02Total = Month02Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month02Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 3).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 3).ToList
          For Each item In oApplication
            Month03Total = Month03Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month03Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 4).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 4).ToList
          For Each item In oApplication
            Month04Total = Month04Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month04Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 5).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 5).ToList
          For Each item In oApplication
            Month05Total = Month05Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month05Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 6).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 6).ToList
          For Each item In oApplication
            Month06Total = Month06Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month06Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 7).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 7).ToList
          For Each item In oApplication
            Month07Total = Month07Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month07Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 8).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 8).ToList
          For Each item In oApplication
            Month08Total = Month08Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month08Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 9).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 9).ToList
          For Each item In oApplication
            Month09Total = Month09Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month09Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 10).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 10).ToList
          For Each item In oApplication
            Month10Total = Month10Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month10Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 11).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 11).ToList
          For Each item In oApplication
            Month11Total = Month11Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month11Total = 0
        End If
        If (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 12).Any Then
          'given some records exist, populate report variables with actual values
          oApplication = (From VW_APPLICATIONS_TOTAL_DISPERSED In oDB.VW_APPLICATIONS_TOTAL_DISPERSED Where VW_APPLICATIONS_TOTAL_DISPERSED.year = vSelectedYear AndAlso VW_APPLICATIONS_TOTAL_DISPERSED.month = 12).ToList
          For Each item In oApplication
            Month12Total = Month12Total + (item.dispersedAmount)
          Next
        Else
          'given no records exist, populate report variables with placeholder value(s)
          Month12Total = 0
        End If
      End Using

      Dim vJscript As New StringBuilder
      vJscript.Append("google.charts.load('current', {'packages':['corechart']});")
      vJscript.Append("google.charts.setOnLoadCallback(drawChart);")
      vJscript.Append("function drawChart() {")
      vJscript.Append("var data = google.visualization.arrayToDataTable([")
      vJscript.Append("['Month', 'Total Dollar Amount Dispersed'],")
      vJscript.Append("['Jan'," & CStr(Month01Total) & "],")
      vJscript.Append("['Feb'," & CStr(Month02Total) & "],")
      vJscript.Append("['Mar'," & CStr(Month03Total) & "],")
      vJscript.Append("['Apr'," & CStr(Month04Total) & "],")
      vJscript.Append("['May'," & CStr(Month05Total) & "],")
      vJscript.Append("['Jun'," & CStr(Month06Total) & "],")
      vJscript.Append("['Jul'," & CStr(Month07Total) & "],")
      vJscript.Append("['Aug'," & CStr(Month08Total) & "],")
      vJscript.Append("['Sep'," & CStr(Month09Total) & "],")
      vJscript.Append("['Oct'," & CStr(Month10Total) & "],")
      vJscript.Append("['Nov'," & CStr(Month11Total) & "],")
      vJscript.Append("['Dec'," & CStr(Month12Total) & "],")
      vJscript.Append("]);")
      vJscript.Append("var options = {")
      vJscript.Append("title: 'Total Amount Dispersed By Year and Month',")
      vJscript.Append("curveType: 'function',")
      vJscript.Append("pointSize: 5,")
      vJscript.Append("legend: { position: 'bottom' },")
      vJscript.Append("vAxis: {")
      vJscript.Append("title: 'Dollar Amount'")
      vJscript.Append("},")
      vJscript.Append("colors: ['#008000']")
      vJscript.Append("};")
      vJscript.Append("var chart = new google.visualization.LineChart(document.getElementById('divucChartApplicationsTotalDispersedByMonth'));")
      vJscript.Append("chart.draw(data, options);")
      vJscript.Append("}")

      Dim ucChartApplicationsTotalDispersedByMonth As New Report
      ucChartApplicationsTotalDispersedByMonth = LoadControl("Report.ascx")
      With ucChartApplicationsTotalDispersedByMonth
        .ID = "ucChartApplicationsTotalDispersedByMonth"
        .ucMode = Report.eMode.Line
        .ucTitle = "Average Processing Days By Year and Month"
        .ucTitleVisible = False
        .ucJscript = vJscript.ToString
      End With
      phChartRow4Left.Controls.Add(ucChartApplicationsTotalDispersedByMonth)
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