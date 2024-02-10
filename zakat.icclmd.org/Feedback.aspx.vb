Imports System.Drawing
Imports System.Globalization
Imports AjaxControlToolkit

Public Class Feedback
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    txtFirstName.Text = ""
    txtLastName.Text = ""
    txtEmail.Text = ""
    txtPhone.Text = ""
  End Sub

  Private Sub chkOtherMostLiked_CheckedChanged(sender As Object, e As EventArgs) Handles chkOtherMostLiked.CheckedChanged
    Try
      If sender.checked Then
        txtOtherMostLiked.BackColor = Drawing.Color.White
        txtOtherMostLiked.ReadOnly = False
      Else
        txtOtherMostLiked.BackColor = ColorTranslator.FromHtml("#f5f5f5")
        txtOtherMostLiked.ReadOnly = True
      End If
    Catch ex As Exception
      Response.Write(ex)
    End Try
  End Sub

  Private Sub chkOtherMostToImprove_CheckedChanged(sender As Object, e As EventArgs) Handles chkOtherMostToImprove.CheckedChanged
    Try
      If sender.checked Then
        txtOtherMostToImprove.BackColor = Drawing.Color.White
        txtOtherMostToImprove.ReadOnly = False
      Else
        txtOtherMostToImprove.BackColor = ColorTranslator.FromHtml("#f5f5f5")
        txtOtherMostToImprove.ReadOnly = True
      End If
    Catch ex As Exception
      Response.Write(ex)
    End Try
  End Sub
End Class