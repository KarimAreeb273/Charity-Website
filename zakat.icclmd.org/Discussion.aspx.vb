Public Class Discussion
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

  End Sub

  Private Sub btnCollapse_Click(sender As Object, e As EventArgs) Handles btnCollapse.Click
    btnCollapse.Visible = False
    btnExpand.Visible = True

    pnlNavigate.Visible = False
    pnlBody.Width = 1170
  End Sub

  Private Sub btnExpand_Click(sender As Object, e As EventArgs) Handles btnExpand.Click
    btnCollapse.Visible = True
    btnExpand.Visible = False

    pnlNavigate.Visible = True
    pnlBody.Width = 1000
  End Sub
End Class