Public Class Logout
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    'end the session
    Session.Abandon()
    Response.Redirect("/")
  End Sub

End Class