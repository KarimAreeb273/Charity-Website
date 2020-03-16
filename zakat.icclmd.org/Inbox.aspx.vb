Public Class Inbox
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")
      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And (USER_ROLE.ROLE.name = "Validator" OrElse USER_ROLE.ROLE.name = "Investigator" OrElse USER_ROLE.ROLE.name = "Qualifier")).Any Then
          Response.Redirect("/")
        End If

        If Not IsPostBack Then
          'load the state dropdown
          Dim oApplications As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION).ToList
          rptInbox.DataSource = oApplications
          rptInbox.DataBind()
        End If

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
End Class