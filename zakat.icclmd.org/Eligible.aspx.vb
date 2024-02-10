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

    Private Sub txtValue_TextChanged(sender As Object, e As EventArgs) Handles txtValue.TextChanged
        txtNet.Text = (CDec(txtSavings.Text) + CDec(txtJewelry.Text) + CDec(txtValue.Text) + CDec(txtLoans.Text)) - CDec(txtDebt.Text)
    End Sub

    Private Sub txtLoans_TextChanged(sender As Object, e As EventArgs) Handles txtLoans.TextChanged
        txtNet.Text = (CDec(txtSavings.Text) + CDec(txtJewelry.Text) + CDec(txtValue.Text) + CDec(txtLoans.Text)) - CDec(txtDebt.Text)
    End Sub

    Private Sub txtDebt_TextChanged(sender As Object, e As EventArgs) Handles txtDebt.TextChanged
        txtNet.Text = (CDec(txtSavings.Text) + CDec(txtJewelry.Text) + CDec(txtValue.Text) + CDec(txtLoans.Text)) - CDec(txtDebt.Text)
    End Sub

    Private Sub btnDonation_Click(sender As Object, e As EventArgs) Handles btnDonation.Click
        iconEligible.Visible = False
        iconNotEligible.Visible = False

        If CDec(txtNet.Text) < 400 Then
            iconEligible.Visible = True
        Else
            iconNotEligible.Visible = True
        End If
    End Sub

    Private Sub btnReset_Click(sender As Object, e As EventArgs) Handles btnReset.Click
        txtSavings.Text = "$ 0.00"
        txtJewelry.Text = "$ 0.00"
        txtValue.Text = "$ 0.00"
        txtLoans.Text = "$ 0.00"
        txtDebt.Text = "$ 0.00"
        txtNet.Text = 0.00
        iconEligible.Visible = False
        iconNotEligible.Visible = False
    End Sub
End Class