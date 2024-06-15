Public Class Organizations
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'load the org repeater
      setOrganizations()
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
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
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    Try
      getFormattedPhone = Base.getFormattedPhone(pPhone, Base.enumFormatPhone.Format)
    Catch ex As Exception
      Return Nothing
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Function

  Sub setOrganizations()
    Try
      'update org repeater
      Using oDB As New zakatEntities
        rptOrganizations.DataSource = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.name <> "Placeholder").ToList
        rptOrganizations.DataBind()
      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

End Class