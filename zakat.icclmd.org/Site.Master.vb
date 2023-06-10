Public Class SiteMaster
  Inherits MasterPage

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
    Try
      If Not IsPostBack Then
        Dim vUserID As Int32 = Session("sUserId")
        Dim vIsAnonymous As Boolean = Session("sIsAnonymous")
        Dim vIsApplicant As Boolean = Session("sIsApplicant")
        Dim vIsAdministrator As Boolean = Session("sIsAdministrator")
        Dim vIsApprover As Boolean = Session("sIsApprover")
        Dim vSearched As Boolean = Session("hasSearched")

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

        If vSearched = True Then
          txtSearch.Focus()
        End If
      End If
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub lnkProfileFooter_Click(sender As Object, e As EventArgs) Handles lnkProfileFooter.Click
    Try
      Session("sApplicantId") = Session("sUserId")
      Response.Redirect("profile")
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Sub btnViewContent_Click(sender As Object, e As System.EventArgs)
    Try
      Response.Redirect(sender.CommandArgument)
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function GetHighlightedContent(ByVal pContent As String) As String
    Try
      Dim vSearch As String
      vSearch = txtSearch.Text
      'find the search string in the content
      Dim vSearchResult As Int16 = InStr(1, pContent, vSearch, 1)
      If vSearchResult >= 0 Then
        'find the first instance of the serach within the content & store a snippet using 10 characters before and 10 characters after
        Dim vSnippetStart As Int16 = IIf(vSearchResult - 15 >= 0, vSearchResult - 15, 0)
        Dim vSnippetLength As Int16 = IIf((vSearchResult + Len(vSearch) + 10) <= Len(pContent), (Len(vSearch) + 30), Len(pContent))
        Dim vSnippet = "..." + pContent.Substring(vSnippetStart, vSnippetLength) + "..."
        'highlight the search within the snippet and remove any extra spaces
        vSnippet = Replace(LCase(vSnippet), LCase(vSearch), Replace("<mark>" + vSearch + "</mark>", " ", ""))
        vSnippet = Replace(vSnippet, "</mark> ", "</mark>")
        GetHighlightedContent = vSnippet
      Else
        GetHighlightedContent = ""
      End If
    Catch ex As Exception
      GetHighlightedContent = ""
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Function
  Private Sub txtSearch_TextChanged(sender As Object, e As EventArgs) Handles txtSearch.TextChanged
    Try
      Dim vSearch As String
      Dim vCount As Int16
      vCount = 10
      vSearch = txtSearch.Text
      Using oDB As New zakatEntities()
        Dim oTopics As List(Of TOPIC) = oDB.TOPIC.Where(Function(n) n.topicContent.Contains(vSearch)).OrderBy(Function(n) n.topicName).Take(vCount).ToList()
        'lblResultsCount.Text = oTopics.Count
        rptSearchResults.DataSource = oTopics
        rptSearchResults.DataBind()
      End Using
      Session("hasSearched") = True
      txtSearch.Focus()
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

End Class