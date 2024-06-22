Public Class Timeline
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/", False)

      Dim vApplicationId As Int32 = Session("sApplicationId")
      If vApplicationId = 0 Then Response.Redirect("/", False)

      Using oDB As New zakatEntities
        'add review history to the page
        Dim oReviews As List(Of REVIEW) = (From REVIEW In oDB.REVIEW Where REVIEW.applicationId = vApplicationId).ToList
        rptReviewHistory.DataSource = oReviews
        rptReviewHistory.DataBind()

        Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First

        'obtain aggregates
        Dim vDraftedStartDate As DateTime
        Dim vDraftedEndDate As DateTime
        Dim vSubmittedStartDate As DateTime
        Dim vSubmittedEndDate As DateTime
        Dim vValidatedStartDate As DateTime
        Dim vValidatedEndDate As DateTime
        Dim vInvestigatedStartDate As DateTime
        Dim vInvestigatedEndDate As DateTime
        Dim vQualified1StartDate As DateTime
        Dim vQualified1EndDate As DateTime
        Dim vQualified2StartDate As DateTime
        Dim vQualified2EndDate As DateTime
        Dim vDispersedStartDate As DateTime
        Dim vDispersedEndDate As DateTime
        Dim vRejectedStartDate As DateTime
        Dim vRejectedEndDate As DateTime

        With oApplication
          If .isDispersed = True Then
            vDispersedStartDate = oApplication.qualified2On
            vDispersedEndDate = oApplication.dispersedOn
          End If
          If .isQualified2 = True Then
            vQualified2StartDate = oApplication.qualified1On
            vQualified2EndDate = oApplication.qualified2On
          End If
          If .isQualified1 = True Then
            vQualified1StartDate = oApplication.investigatedOn
            vQualified1EndDate = oApplication.qualified1On
          End If
          If .isInvestigated = True Then
            vInvestigatedStartDate = oApplication.validatedOn
            vInvestigatedEndDate = oApplication.investigatedOn
          End If
          If .isValidated = True Then
            vValidatedStartDate = oApplication.submittedOn
            vValidatedEndDate = oApplication.validatedOn
          End If
          If .isSubmitted = True Then
            vSubmittedStartDate = oApplication.draftedOn
            vSubmittedEndDate = oApplication.submittedOn
          End If
          If .isDrafted = True Then
            vDraftedStartDate = oApplication.createdOn
            vDraftedEndDate = oApplication.draftedOn
          End If
          If .isRejected = True Then
            If .isQualified2 Then
              vRejectedStartDate = oApplication.qualified2On
            ElseIf .isQualified1 Then
              vRejectedStartDate = oApplication.qualified1On
            ElseIf .isInvestigated Then
              vRejectedStartDate = oApplication.investigatedOn
            ElseIf .isValidated Then
              vRejectedStartDate = oApplication.validatedOn
            ElseIf .isSubmitted Then
              vRejectedStartDate = oApplication.submittedOn
            End If
            vRejectedEndDate = oApplication.rejectedOn
          End If

          Dim vJscript As New StringBuilder
          vJscript.Append("google.charts.load('current', {packages:['timeline']});")
          vJscript.Append("google.charts.setOnLoadCallback(drawChart);")
          vJscript.Append("function drawChart() {")
          vJscript.Append("var container = document.getElementById('timeline');")
          vJscript.Append("var chart = new google.visualization.Timeline(container);")
          vJscript.Append("var dataTable = new google.visualization.DataTable();")
          vJscript.Append("dataTable.addColumn({ type: 'string', id: 'Action' });")
          vJscript.Append("dataTable.addColumn({ type: 'date', id: 'Start' });")
          vJscript.Append("dataTable.addColumn({ type: 'date', id: 'End' });")
          vJscript.Append("dataTable.addRows([")
          'add data rows
          If .isDrafted Then
            vJscript.Append("['Drafted', new Date(" & vDraftedStartDate.Year.ToString & ", " & (vDraftedStartDate.Month - 1).ToString & ", " & vDraftedStartDate.Day.ToString & "), new Date(" & vDraftedEndDate.Year.ToString & ", " & (vDraftedEndDate.Month - 1).ToString & ", " & vDraftedEndDate.Day.ToString & ")]")
          End If
          If .isSubmitted Then
            vJscript.Append(",['Submitted', new Date(" & vSubmittedStartDate.Year.ToString & ", " & (vSubmittedStartDate.Month - 1).ToString & ", " & vSubmittedStartDate.Day.ToString & "), new Date(" & vSubmittedEndDate.Year.ToString & ", " & (vSubmittedEndDate.Month - 1).ToString & ", " & vSubmittedEndDate.Day.ToString & ")]")
          End If
          If .isValidated Then
            vJscript.Append(",['Validated', new Date(" & vValidatedStartDate.Year.ToString & ", " & (vValidatedStartDate.Month - 1).ToString & ", " & vValidatedStartDate.Day.ToString & "), new Date(" & vValidatedEndDate.Year.ToString & ", " & (vValidatedEndDate.Month - 1).ToString & ", " & vValidatedEndDate.Day.ToString & ")]")
          End If
          If .isInvestigated Then
            vJscript.Append(",['Investigated', new Date(" & vInvestigatedStartDate.Year.ToString & ", " & (vInvestigatedStartDate.Month - 1).ToString & ", " & vInvestigatedStartDate.Day.ToString & "), new Date(" & vInvestigatedEndDate.Year.ToString & ", " & (vInvestigatedEndDate.Month - 1).ToString & ", " & vInvestigatedEndDate.Day.ToString & ")]")
          End If
          If .isQualified1 Then
            vJscript.Append(",['Qualified (Initial)', new Date(" & vQualified1StartDate.Year.ToString & ", " & (vQualified1StartDate.Month - 1).ToString & ", " & vQualified1StartDate.Day.ToString & "), new Date(" & vQualified1EndDate.Year.ToString & ", " & (vQualified1EndDate.Month - 1).ToString & ", " & vQualified1EndDate.Day.ToString & ")]")
          End If
          If .isQualified2 Then
            vJscript.Append(",['Qualified (Final)', new Date(" & vQualified2StartDate.Year.ToString & ", " & (vQualified2StartDate.Month - 1).ToString & ", " & vQualified2StartDate.Day.ToString & "), new Date(" & vQualified2EndDate.Year.ToString & ", " & (vQualified2EndDate.Month - 1).ToString & ", " & vQualified2EndDate.Day.ToString & ")]")
          End If
          If .isDispersed Then
            vJscript.Append(",['Dispersed', new Date(" & vDispersedStartDate.Year.ToString & ", " & (vDispersedStartDate.Month - 1).ToString & ", " & vDispersedStartDate.Day.ToString & "), new Date(" & vDispersedEndDate.Year.ToString & ", " & (vDispersedEndDate.Month - 1).ToString & ", " & vDispersedEndDate.Day.ToString & ")]")
          End If
          If .isRejected Then
            vJscript.Append(",['Rejected', new Date(" & vRejectedStartDate.Year.ToString & ", " & (vRejectedStartDate.Month - 1).ToString & ", " & vRejectedStartDate.Day.ToString & "), new Date(" & vRejectedEndDate.Year.ToString & ", " & (vRejectedEndDate.Month - 1).ToString & ", " & vRejectedEndDate.Day.ToString & ")]")
          End If
          vJscript.Append("]);")
          vJscript.Append("var options = {")
          vJscript.Append("colors:  ['#C0C0C0', '#FFA500', '#FFFF00', '#800080', '#0000FF' ,'#00008B', '#008000', '#FF0000']")
          vJscript.Append("};")
          vJscript.Append("chart.draw(dataTable, options);")
          vJscript.Append("}")
          lblReportName.Text = oApplication.USER.firstName & " " & oApplication.USER.middleName & " " & oApplication.USER.lastName & " (Application #: " & Base.GetFormattedNumber(oApplication.applicationId) & ") - Interval Timeline Between Actions"
          'begin load values from the list
          Dim cScript As New HtmlGenericControl
          cScript.TagName = "script"
          cScript.Attributes.Add("type", "text/javascript")
          cScript.InnerHtml = vJscript.ToString
          phReport.Controls.Add(cScript)
        End With
      End Using

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

End Class