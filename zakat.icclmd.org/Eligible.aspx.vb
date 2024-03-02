Imports System.Web.UI.WebControls.Expressions

Public Class Eligible
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub txtSavings_TextChanged(sender As Object, e As EventArgs) Handles txtSavings.TextChanged
        If txtSavings.Text = "" Then
            txtSavings.Text = 0.00
        End If

        If txtJewelry.Text = "" Then
            txtJewelry.Text = 0.00
        End If

        If txtValue.Text = "" Then
            txtValue.Text = 0.00
        End If

        If txtLoans.Text = "" Then
            txtLoans.Text = 0.00
        End If

        If txtDebt.Text = "" Then
            txtDebt.Text = 0.00
        End If

        'If txtSavings.Text = "" & txtJewelry.Text = "" & txtValue.Text = "" & txtLoans.Text = "" & txtDebt.Text = "" Then
        '    txtSavings.Text = 0.00
        '    txtJewelry.Text = 0.00
        '    txtValue.Text = 0.00
        '    txtLoans.Text = 0.00
        '    txtDebt.Text = 0.00
        'End If

        txtNet.Text = (CDec(txtSavings.Text) + CDec(txtJewelry.Text) + CDec(txtValue.Text) + CDec(txtLoans.Text)) - CDec(txtDebt.Text)
    End Sub

    Private Sub txtJewelry_TextChanged(sender As Object, e As EventArgs) Handles txtJewelry.TextChanged
        If txtSavings.Text = "" Then
            txtSavings.Text = 0.00
        End If

        If txtJewelry.Text = "" Then
            txtJewelry.Text = 0.00
        End If

        If txtValue.Text = "" Then
            txtValue.Text = 0.00
        End If

        If txtLoans.Text = "" Then
            txtLoans.Text = 0.00
        End If

        If txtDebt.Text = "" Then
            txtDebt.Text = 0.00
        End If

        'If txtSavings.Text = "" & txtJewelry.Text = "" & txtValue.Text = "" & txtLoans.Text = "" & txtDebt.Text = "" Then
        '    txtSavings.Text = 0.00
        '    txtJewelry.Text = 0.00
        '    txtValue.Text = 0.00
        '    txtLoans.Text = 0.00
        '    txtDebt.Text = 0.00
        'End If

        txtNet.Text = (CDec(txtSavings.Text) + CDec(txtJewelry.Text) + CDec(txtValue.Text) + CDec(txtLoans.Text)) - CDec(txtDebt.Text)
    End Sub

    Private Sub txtValue_TextChanged(sender As Object, e As EventArgs) Handles txtValue.TextChanged
        If txtSavings.Text = "" Then
            txtSavings.Text = 0.00
        End If

        If txtJewelry.Text = "" Then
            txtJewelry.Text = 0.00
        End If

        If txtValue.Text = "" Then
            txtValue.Text = 0.00
        End If

        If txtLoans.Text = "" Then
            txtLoans.Text = 0.00
        End If

        If txtDebt.Text = "" Then
            txtDebt.Text = 0.00
        End If

        'If txtSavings.Text = "" & txtJewelry.Text = "" & txtValue.Text = "" & txtLoans.Text = "" & txtDebt.Text = "" Then
        '    txtSavings.Text = 0.00
        '    txtJewelry.Text = 0.00
        '    txtValue.Text = 0.00
        '    txtLoans.Text = 0.00
        '    txtDebt.Text = 0.00
        'End If

        txtNet.Text = (CDec(txtSavings.Text) + CDec(txtJewelry.Text) + CDec(txtValue.Text) + CDec(txtLoans.Text)) - CDec(txtDebt.Text)
    End Sub

    Private Sub txtLoans_TextChanged(sender As Object, e As EventArgs) Handles txtLoans.TextChanged
        If txtSavings.Text = "" Then
            txtSavings.Text = 0.00
        End If

        If txtJewelry.Text = "" Then
            txtJewelry.Text = 0.00
        End If

        If txtValue.Text = "" Then
            txtValue.Text = 0.00
        End If

        If txtLoans.Text = "" Then
            txtLoans.Text = 0.00
        End If

        If txtDebt.Text = "" Then
            txtDebt.Text = 0.00
        End If

        'If txtSavings.Text = "" & txtJewelry.Text = "" & txtValue.Text = "" & txtLoans.Text = "" & txtDebt.Text = "" Then
        '    txtSavings.Text = 0.00
        '    txtJewelry.Text = 0.00
        '    txtValue.Text = 0.00
        '    txtLoans.Text = 0.00
        '    txtDebt.Text = 0.00
        'End If

        txtNet.Text = (CDec(txtSavings.Text) + CDec(txtJewelry.Text) + CDec(txtValue.Text) + CDec(txtLoans.Text)) - CDec(txtDebt.Text)
    End Sub

    Private Sub txtDebt_TextChanged(sender As Object, e As EventArgs) Handles txtDebt.TextChanged
        If txtSavings.Text = "" Then
            txtSavings.Text = 0.00
        End If

        If txtJewelry.Text = "" Then
            txtJewelry.Text = 0.00
        End If

        If txtValue.Text = "" Then
            txtValue.Text = 0.00
        End If

        If txtLoans.Text = "" Then
            txtLoans.Text = 0.00
        End If

        If txtDebt.Text = "" Then
            txtDebt.Text = 0.00
        End If

        'If txtSavings.Text = "" & txtJewelry.Text = "" & txtValue.Text = "" & txtLoans.Text = "" & txtDebt.Text = "" Then
        '    txtSavings.Text = 0.00
        '    txtJewelry.Text = 0.00
        '    txtValue.Text = 0.00
        '    txtLoans.Text = 0.00
        '    txtDebt.Text = "0.00"
        'End If

        txtNet.Text = (CDec(txtSavings.Text) + CDec(txtJewelry.Text) + CDec(txtValue.Text) + CDec(txtLoans.Text)) - CDec(txtDebt.Text)
    End Sub

    Private Sub btnEligible_Click(sender As Object, e As EventArgs) Handles btnEligible.Click
        iconEligible.Visible = False
        iconNotEligible.Visible = False

        If CDec(txtNet.Text) < 442 Then
            iconEligible.Visible = True
        Else
            iconNotEligible.Visible = True
            txtZakat.Text = ((CDec(txtNet.Text) - 442) * 0.025)
        End If
    End Sub

    Private Sub btnReset_Click(sender As Object, e As EventArgs) Handles btnReset.Click
        txtSavings.Text = ""
        txtJewelry.Text = ""
        txtValue.Text = ""
        txtLoans.Text = ""
        txtDebt.Text = ""
        txtNet.Text = 0.00
        iconEligible.Visible = False
        iconNotEligible.Visible = False
    End Sub
End Class