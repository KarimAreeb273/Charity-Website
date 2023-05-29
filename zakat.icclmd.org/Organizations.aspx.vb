Public Class Organizations
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'load the org repeater
      setOrganizations()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Protected Sub btnView_Click(sender As Object, e As System.EventArgs) Handles btnView.Click
    Try
      'go home if no session/user
      Dim vOrganizationId As Int32 = sender.CommandArgument
      If vOrganizationId = 0 Then Response.Redirect("/")
      'redirect to org edit
      Response.Redirect("organizationprofile?o=" + vOrganizationId.ToString)
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    getFormattedPhone = Base.getFormattedPhone(pPhone, Base.enumFormatPhone.Format)
  End Function

  Sub setOrganizations()
    Try
      'update org repeater
      Using oDB As New zakatEntities
        rptOrganizations.DataSource = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.name <> "Placeholder").ToList
        rptOrganizations.DataBind()
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

End Class