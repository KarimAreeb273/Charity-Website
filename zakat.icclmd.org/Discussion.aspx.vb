Imports System.Net.NetworkInformation

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
    Private Sub btnAddComment_Click(sender As Object, e As EventArgs) Handles btnAddComment.Click
        txtAnswer.Visible = True
        btnAddComment.Visible = False
        btnNoComment.Visible = True
        btnSubmit.Visible = True
    End Sub

    Private Sub btnNoComment_Click(sender As Object, e As EventArgs) Handles btnNoComment.Click
        txtAnswer.Visible = False
        btnAddComment.Visible = True
        btnNoComment.Visible = False
        btnSubmit.Visible = False
    End Sub

    Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        Try

            Using oDB As New zakatEntities
                'add organization
                Dim oPost As New POST

                'insert information about new org and save to db
                With oPost

                End With

                ' Add to Memory
                oDB.POST.Add(oPost)
                oDB.SaveChanges()

                'clear fields


            End Using
        Catch ex As Exception
            Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
            Response.Write(ex.Message)
        End Try
    End Sub
End Class