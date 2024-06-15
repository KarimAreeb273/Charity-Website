Public Class Inbox
  Inherits System.Web.UI.Page
  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")

      If Not IsPostBack Then
        Using oDB As New zakatEntities

          'verify if the user is a reviewer or administrator otherwise redirect home
          If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And (USER_ROLE.ROLE.name = "Validator" OrElse USER_ROLE.ROLE.name = "Investigator" OrElse USER_ROLE.ROLE.name = "Qualifier" OrElse USER_ROLE.ROLE.name = "Financier" OrElse USER_ROLE.ROLE.name = "Administrator")).Any Then
            Response.Redirect("/")
          End If

          'populate the submission years dropdown filter with all the distinct years 
          Dim submissionYearList As New ArrayList
          If (From APPLICATION In oDB.APPLICATION Where APPLICATION.submittedOn IsNot Nothing).Any Then
            Dim oApplications As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.submittedOn IsNot Nothing Order By APPLICATION.submittedOn).ToList
            For Each item In oApplications
              Dim vDate As Date = item.submittedOn
              Dim vYear As Integer = vDate.Year
              Dim vIndex As Integer = submissionYearList.IndexOf(vYear)
              If vIndex = -1 Then
                submissionYearList.Add(item.submittedOn.Value.Year)
              End If
            Next
            drpSubmissionYear.Items.Clear()
            drpSubmissionYear.DataSource = submissionYearList
            drpSubmissionYear.DataBind()
          Else
            drpSubmissionYear.Items.Clear()
            submissionYearList.Add(CStr(Now.Date.Year))
            drpSubmissionYear.DataSource = submissionYearList
            drpSubmissionYear.DataBind()
          End If

          drpSubmissionYear.SelectedIndex = drpSubmissionYear.Items.IndexOf(drpSubmissionYear.Items.FindByValue(CStr(Now.Date.Year)))

          'set the dropdown based on the reviewer's roles in order of workflow (validate, investigate, qualify, finance)
          Dim oUserRoles As List(Of USER_ROLE) = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And (USER_ROLE.ROLE.name = "Validator" OrElse USER_ROLE.ROLE.name = "Investigator" OrElse USER_ROLE.ROLE.name = "Qualifier" OrElse USER_ROLE.ROLE.name = "Financier") Order By USER_ROLE.roleId).ToList
          For Each item In oUserRoles
            If item.ROLE.name = "Validator" Then
              drpWorkflow.SelectedValue = "Submitted"
              Exit For
            ElseIf item.ROLE.name = "Investigator" Then
              drpWorkflow.SelectedValue = "Validated"
              Exit For
            ElseIf item.ROLE.name = "Qualifier" Then
              drpWorkflow.SelectedValue = "Investigated"
              Exit For
            ElseIf item.ROLE.name = "Financier" Then
              drpWorkflow.SelectedValue = "Qualified"
              Exit For
            Else
              drpWorkflow.SelectedValue = "All"
              Exit For
            End If
          Next
        End Using
        filterWorkflow()
      End If

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Sub btnViewApplication_Click(sender As Object, e As System.EventArgs)
    Try
      Session("sApplicationId") = sender.CommandArgument
      Response.Redirect("application")
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Sub btnViewProfile_Click(sender As Object, e As System.EventArgs)
    Try
      Session("sUserId") = Session("sUserId")
      Session("sApplicantId") = sender.CommandArgument
      Response.Redirect("profile")
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Sub btnViewTimeline_Click(sender As Object, e As System.EventArgs)
    Try
      Session("sApplicationId") = sender.CommandArgument
      Response.Redirect("timeline")
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Sub btnViewRequests_Click(sender As Object, e As System.EventArgs)
    Try
      Session("sViewRequestsUserId") = sender.CommandArgument
      Dim vUserId As Int32 = sender.CommandArgument
      'load the inbox with an applicant filter
      Using oDB As New zakatEntities
        Dim oApplications As List(Of APPLICATION)

        oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId).ToList
        rptInbox.DataSource = oApplications
        rptInbox.DataBind()
      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Function GetFormattedNumber(ByVal pMemberId As Int32) As String
    Try
      GetFormattedNumber = Base.GetFormattedNumber(pMemberId)
    Catch ex As Exception
      Return Nothing
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Function

  Sub filterWorkflow()
    Try
      'load the inbox
      Using oDB As New zakatEntities
        Dim oApplications As List(Of APPLICATION)
        Dim vBeginDate As Date = CDate("01/01/" + drpSubmissionYear.SelectedItem.Text)
        Dim vEndDate As Date = CDate("12/31/" + drpSubmissionYear.SelectedItem.Text)
        If drpWorkflow.SelectedValue = "All" Then
          oApplications = (From APPLICATION In oDB.APPLICATION Where (APPLICATION.submittedOn >= vBeginDate And APPLICATION.submittedOn <= vEndDate) OrElse (APPLICATION.createdOn >= vBeginDate And APPLICATION.createdOn <= vEndDate)).ToList
        ElseIf drpWorkflow.SelectedValue = "Drafted" Then
          oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.createdOn >= vBeginDate And APPLICATION.createdOn <= vEndDate And APPLICATION.applicationStatus = "Drafted").ToList
        ElseIf drpWorkflow.SelectedValue = "Rejected" Then
          oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.submittedOn >= vBeginDate And APPLICATION.submittedOn <= vEndDate And APPLICATION.applicationStatus = "Rejected").ToList
        ElseIf drpWorkflow.SelectedValue = "Submitted" Then
          oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.submittedOn >= vBeginDate And APPLICATION.submittedOn <= vEndDate And APPLICATION.applicationStatus = "Submitted").ToList
        ElseIf drpWorkflow.SelectedValue = "Validated" Then
          oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.submittedOn >= vBeginDate And APPLICATION.submittedOn <= vEndDate And APPLICATION.applicationStatus = "Validated").ToList
        ElseIf drpWorkflow.SelectedValue = "Investigated" Then
          oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.submittedOn >= vBeginDate And APPLICATION.submittedOn <= vEndDate And (APPLICATION.applicationStatus = "Investigated" OrElse APPLICATION.applicationStatus = "Qualified (Initial)")).ToList
        ElseIf drpWorkflow.SelectedValue = "Qualified" Then
          oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.submittedOn >= vBeginDate And APPLICATION.submittedOn <= vEndDate And APPLICATION.applicationStatus = "Qualified (Final)").ToList
        ElseIf drpWorkflow.SelectedValue = "Dispersed" Then
          oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.submittedOn >= vBeginDate And APPLICATION.submittedOn <= vEndDate And APPLICATION.applicationStatus = "Dispersed").ToList
        Else
          oApplications = (From APPLICATION In oDB.APPLICATION Where (APPLICATION.submittedOn >= vBeginDate And APPLICATION.submittedOn <= vEndDate) OrElse (APPLICATION.createdOn >= vBeginDate And APPLICATION.createdOn <= vEndDate)).ToList
        End If
        rptInbox.DataSource = oApplications
        rptInbox.DataBind()
      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub drpSubmissionYear_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpSubmissionYear.SelectedIndexChanged
    Try
      filterWorkflow()
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub drpWorkflow_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpWorkflow.SelectedIndexChanged
    Try
      filterWorkflow()
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub
End Class