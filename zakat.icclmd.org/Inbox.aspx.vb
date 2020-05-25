Public Class Inbox
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")

      If Not IsPostBack Then
        txtNumber.Text = ""
        Using oDB As New zakatEntities
          'verify if the user is an administrator otherwise redirect home
          If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And (USER_ROLE.ROLE.name = "Validator" OrElse USER_ROLE.ROLE.name = "Investigator" OrElse USER_ROLE.ROLE.name = "Qualifier" OrElse USER_ROLE.ROLE.name = "Financier")).Any Then
            Response.Redirect("/")
          End If
          'set the dropdown based on the reviewer's roles in order of workflow (validate, investigate, qualify, finance)
          Dim oUserRoles As List(Of USER_ROLE) = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And (USER_ROLE.ROLE.name = "Validator" OrElse USER_ROLE.ROLE.name = "Investigator" OrElse USER_ROLE.ROLE.name = "Qualifier" OrElse USER_ROLE.ROLE.name = "Financier")).ToList
          For Each item In oUserRoles
            If item.ROLE.name = "Validator" Then
              drpWorkflow.SelectedValue = "Submitted"
            ElseIf item.ROLE.name = "Investigator" Then
              drpWorkflow.SelectedValue = "Validated"
            ElseIf item.ROLE.name = "Qualifier" Then
              drpWorkflow.SelectedValue = "Investigated"
            ElseIf item.ROLE.name = "Financier" Then
              drpWorkflow.SelectedValue = "Qualified (Final)"
            End If
          Next
        End Using
        filterWorkflow()
      End If

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Sub btnViewApplication_Click(sender As Object, e As System.EventArgs)
    Try
      Session("sApplicationId") = sender.CommandArgument
      Response.Redirect("application")
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Sub btnViewTimeline_Click(sender As Object, e As System.EventArgs)
    Try
      Session("sApplicationId") = sender.CommandArgument
      Response.Redirect("timeline")
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function GetFormattedNumber(ByVal pMemberId As Int32) As String
    Try
      GetFormattedNumber = Base.GetFormattedNumber(pMemberId)
    Catch ex As Exception
      Return Nothing
      Response.Write(ex.Message)
    End Try
  End Function

  Private Sub txtNumber_TextChanged(sender As Object, e As EventArgs) Handles txtNumber.TextChanged
    Try
      Dim vAppId As Int32 = IIf(IsNumeric(txtNumber.Text), CInt(txtNumber.Text), 0)
      If vAppId <> 0 Then
        drpWorkflow.SelectedValue = "All"
        Using oDB As New zakatEntities
          If (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vAppId).Any Then
            Dim oApplications As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vAppId).ToList
            rptInbox.DataSource = oApplications
            rptInbox.DataBind()
          End If
        End Using
      End If
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpWorkflow_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpWorkflow.SelectedIndexChanged
    filterWorkflow()
  End Sub

  Sub filterWorkflow()
    Try
      txtNumber.Text = ""
      'load the inbox
      Using oDB As New zakatEntities
        Dim oApplications As List(Of APPLICATION)
        If drpWorkflow.SelectedValue = "All" Then
          oApplications = (From APPLICATION In oDB.APPLICATION).ToList
        Else
          If drpWorkflow.SelectedValue = "Rejected" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationStatus = "Rejected").ToList
          ElseIf drpWorkflow.SelectedValue = "Drafted" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationStatus = "Drafted").ToList
          ElseIf drpWorkflow.SelectedValue = "Submitted" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationStatus = "Submitted").ToList
          ElseIf drpWorkflow.SelectedValue = "Validated" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationStatus = "Validated").ToList
          ElseIf drpWorkflow.SelectedValue = "Investigated" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationStatus = "Investigated").ToList
          ElseIf drpWorkflow.SelectedValue = "Qualified (Initial)" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationStatus = "Qualified (Initial)").ToList
          ElseIf drpWorkflow.SelectedValue = "Qualified (Final)" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationStatus = "Qualified (Final)").ToList
          ElseIf drpWorkflow.SelectedValue = "Dispersed" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationStatus = "Dispersed").ToList
          Else
            oApplications = (From APPLICATION In oDB.APPLICATION).ToList
          End If
        End If
        rptInbox.DataSource = oApplications
        rptInbox.DataBind()
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub
End Class