Public Class Activity
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")

      Using oDB As New zakatEntities
        Dim oApplications As List(Of APPLICATION)
        oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId And APPLICATION.isSubmitted = True).ToList
        rptInbox.DataSource = oApplications
        rptInbox.DataBind()
      End Using

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

  Public Function getFormattedNumber(ByVal pMemberId As Int32) As String
    Try
      getFormattedNumber = Base.getFormattedNumber(pMemberId)
    Catch ex As Exception
      Return Nothing
      Response.Write(ex.Message)
    End Try
  End Function

End Class