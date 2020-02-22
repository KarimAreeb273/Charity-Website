Public Class SiteMaster
  Inherits MasterPage

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
    If Not IsPostBack Then
      'If HttpContext.Current.Request.Url.Host <> "localhost" Then
      '  If Not Request.IsSecureConnection Then
      '    Dim aAppPath As String = System.Configuration.ConfigurationManager.AppSettings("AppPath")
      '    Response.Redirect(aAppPath)
      '  End If
      'End If

      Dim vUserID As Int64 = Session("sUserId")

      'show panel Anonymous vs. LoggedIn
      If vUserID Then
        'LoggedIn
        If Session("sIsAdmin") Then
          lnkMembers.Visible = True
          lnkApplication.Visible = True
        Else
          lnkMembers.Visible = False
          lnkApplication.Visible = False
        End If
        pnlLoggedInTemplate.Visible = True
        pnlAnonymousTemplate.Visible = False
        lblName.Text = Session("sUserFirstName")
      Else
        'Anonymous
        pnlAnonymousTemplate.Visible = True
        pnlLoggedInTemplate.Visible = False
      End If
    End If
  End Sub

  Private Sub lnkProfile_Click(sender As Object, e As EventArgs) Handles lnkProfileHeader.Click, lnkProfileFooter.Click
    Session("sMemberId") = Session("sUserId")
    Response.Redirect("profile")
  End Sub

  Function getMaritalStatus(var As String) As String
    Select Case var
      Case "M"
        getMaritalStatus = "Married"
      Case "S"
        getMaritalStatus = "Single"
      Case "D"
        getMaritalStatus = "Divorced"
      Case Else
        getMaritalStatus = ""
    End Select
  End Function

  Function getPhone(cell As String, home As String, work As String) As String
    Dim vPhone As String
    If (cell IsNot Nothing) Then
      vPhone = Base.getFormattedPhone(cell, Base.enumFormatPhone.Strip)
    ElseIf (home IsNot Nothing) Then
      vPhone = Base.getFormattedPhone(home, Base.enumFormatPhone.Strip)
    ElseIf (work IsNot Nothing) Then
      vPhone = Base.getFormattedPhone(work, Base.enumFormatPhone.Strip)
    Else
      vPhone = ""
    End If
    getPhone = vPhone
  End Function

  Function getCitizenship(code As String) As String
    If (code = "US") Then
      getCitizenship = "US Citizen"
    ElseIf (code = "PR") Then
      getCitizenship = "Permanent Resident"
    Else
      getCitizenship = ""
    End If
  End Function

  Function getDependentType(rel As String) As String
    If (rel = "Spouse") Then
      getDependentType = "Spouse"
    ElseIf (rel = "Dependent") Then
      getDependentType = "Other"
    Else
      getDependentType = "Other"
    End If
  End Function
End Class