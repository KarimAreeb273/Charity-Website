Public Class Eligible
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

  End Sub

    Private Sub txtSavings_TextChanged(sender As Object, e As EventArgs) Handles txtSavings.TextChanged
        txtNet.Text = CInt(txtSavings.Text) ' + CInt(txtJewelry.Text) + CInt(txtValue.Text) + CInt(txtLoans.Text) - CInt(txtDebt.Text)
    End Sub

End Class