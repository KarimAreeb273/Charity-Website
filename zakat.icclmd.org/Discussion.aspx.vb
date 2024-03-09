Public Class Discussion
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'update org repeater
      Using oDB As New zakatEntities
        rptPostCategories.DataSource = (From POST_CATEGORY In oDB.POST_CATEGORY Order By POST_CATEGORY.name).ToList
        rptPostCategories.DataBind()
      End Using
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnCollapse_Click(sender As Object, e As EventArgs) Handles btnCollapse.Click
    btnCollapse.Visible = False
    btnExpand.Visible = True

    pnlNavigateShow.Visible = False
    pnlNavigateHide.Visible = Visible

    pnlNavigateShow.Width = 170
    pnlNavigateHide.Width = 40
    pnlBody.Width = 1130
  End Sub

  Private Sub btnExpand_Click(sender As Object, e As EventArgs) Handles btnExpand.Click
    btnCollapse.Visible = True
    btnExpand.Visible = False

    pnlNavigateShow.Visible = True
    pnlNavigateHide.Visible = False

    pnlNavigateShow.Width = 170
    pnlNavigateHide.Width = 40
    pnlBody.Width = 1000
  End Sub

  Public Sub btnViewPostCategory_Click(sender As Object, e As System.EventArgs)
    Try

    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub
End Class