Public Class Eligible
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

  End Sub

  Private Sub txtSavings_TextChanged(sender As Object, e As EventArgs) Handles txtSavings.TextChanged
    txtNet.Text = (CDec(txtSavings.Text) + CDec(txtJewelry.Text) + CDec(txtValue.Text) + CDec(txtLoans.Text)) - CDec(txtDebt.Text)
  End Sub

  Private Sub txtJewelry_TextChanged(sender As Object, e As EventArgs) Handles txtJewelry.TextChanged
    txtNet.Text = (CDec(txtSavings.Text) + CDec(txtJewelry.Text) + CDec(txtValue.Text) + CDec(txtLoans.Text)) - CDec(txtDebt.Text)
  End Sub

End Class