Public Class Inbox
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")
      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And (USER_ROLE.ROLE.name = "Validator" OrElse USER_ROLE.ROLE.name = "Investigator" OrElse USER_ROLE.ROLE.name = "Qualifier" OrElse USER_ROLE.ROLE.name = "Financier")).Any Then
          Response.Redirect("/")
        End If

        'load the inbox
        Dim oApplications As List(Of APPLICATION)
        If drpWorkflow.SelectedValue = "All" Then
          oApplications = (From APPLICATION In oDB.APPLICATION).ToList
        Else
          If drpWorkflow.SelectedValue = "Drafted" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.isDrafted = True).ToList
          ElseIf drpWorkflow.SelectedValue = "Submitted" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.isSubmitted = True).ToList
          ElseIf drpWorkflow.SelectedValue = "Validated" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.isValidated = True).ToList
          ElseIf drpWorkflow.SelectedValue = "Investigated" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.isInvestigated = True).ToList
          ElseIf drpWorkflow.SelectedValue = "Qualified 1" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.isQualified1 = True).ToList
          ElseIf drpWorkflow.SelectedValue = "Qualified 2" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.isQualified2 = True).ToList
          ElseIf drpWorkflow.SelectedValue = "Dispersed" Then
            oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.IsDispersed = True).ToList
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

  Public Function getDate(ByVal month As Short, ByVal day As Short) As Date
    getDate = CDate(month.ToString + day.ToString + Today.Year.ToString)
  End Function

  Public Function getAge(ByVal dob As Date) As Int16
    getAge = Base.getAge(dob)
  End Function

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    getFormattedPhone = Base.getFormattedPhone(pPhone, Base.enumFormatPhone.Format)
  End Function

  Public Sub btnViewApplication_Click(sender As Object, e As System.EventArgs)
    Try
      Session("sApplicationId") = sender.CommandArgument
      Response.Redirect("application")
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
End Class