Public Class SiteMaster
  Inherits MasterPage

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
    If Not IsPostBack Then
      Dim vUserID As Int32 = Session("sUserId")
      Dim vIsAnonymous As Boolean = Session("sIsAnonymous")
      Dim vIsApplicant As Boolean = Session("sIsApplicant")
      Dim vIsAdministrator As Boolean = Session("sIsAdministrator")
      Dim vIsApprover As Boolean = Session("sIsApprover")

      'show panel Anonymous vs. User vs. Admin vs. Approver
      If vUserID Then
        'LoggedIn
        If vIsApplicant Then
          pnlApplicant.Visible = True
          pnlAdministrator.Visible = False
          pnlApprover.Visible = False
          pnlAnonymous.Visible = False
          pnlFinancier.Visible = False
          lblNameApplicant.Text = Session("sUserFirstName")
        ElseIf vIsAdministrator Then
          pnlApplicant.Visible = False
          pnlAdministrator.Visible = True
          pnlApprover.Visible = False
          pnlAnonymous.Visible = False
          pnlFinancier.Visible = False
          lblNameAdministrator.Text = Session("sUserFirstName")
        ElseIf vIsApprover Then
          pnlApplicant.Visible = False
          pnlAdministrator.Visible = False
          pnlApprover.Visible = True
          pnlAnonymous.Visible = False
          pnlFinancier.Visible = False
          lblNameApprover.Text = Session("sUserFirstName")
        Else
          'Anonymous
          pnlApplicant.Visible = False
          pnlAdministrator.Visible = False
          pnlApprover.Visible = False
          pnlFinancier.Visible = False
          pnlAnonymous.Visible = True

        End If
      Else
        'Anonymous
        pnlApplicant.Visible = False
        pnlAdministrator.Visible = False
        pnlApprover.Visible = False
        pnlFinancier.Visible = False
        pnlAnonymous.Visible = True
      End If
    End If
  End Sub

  Private Sub lnkProfileFooter_Click(sender As Object, e As EventArgs) Handles lnkProfileFooter.Click
    Session("sApplicantId") = Session("sUserId")
    Response.Redirect("profile")
  End Sub
End Class