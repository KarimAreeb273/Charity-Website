
Public Class SiteMaster
  Inherits MasterPage

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
    Try
      If txtSearch.Text = "" Then
        pnlSearchResults.Visible = False
      Else
        pnlSearchResults.Visible = True
      End If
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
            Using oDB As New zakatEntities()
              Dim oTranslation As TRANSLATION = (From TRANSLATION In oDB.TRANSLATION Where TRANSLATION.translationNameEnglish = "English").FirstOrDefault
              drpTranslation.DataSource = (From TRANSLATION In oDB.TRANSLATION Order By TRANSLATION.translationNameEnglish).ToList()
              drpTranslation.DataTextField = "translationNameEnglish"
              drpTranslation.DataValueField = "translationId"
              drpTranslation.DataBind()
              drpTranslation.Items.Insert(0, New ListItem("(Translate Site)", 0))
            End Using
          End If
        Else
          'Anonymous
          pnlApplicant.Visible = False
          pnlAdministrator.Visible = False
          pnlApprover.Visible = False
          pnlFinancier.Visible = False
          pnlAnonymous.Visible = True
          Using oDB As New zakatEntities()
            Dim oTranslation As TRANSLATION = (From TRANSLATION In oDB.TRANSLATION Where TRANSLATION.translationNameEnglish = "English").FirstOrDefault
            drpTranslation.DataSource = (From TRANSLATION In oDB.TRANSLATION Order By TRANSLATION.translationNameEnglish).ToList()
            drpTranslation.DataTextField = "translationNameEnglish"
            drpTranslation.DataValueField = "translationId"
            drpTranslation.DataBind()
            drpTranslation.Items.Insert(0, New ListItem("(Translate Site)", 0))
          End Using
        End If

        If vSearched = True Then
          txtSearch.Focus()
        End If
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Sub btnViewContent_Click(sender As Object, e As System.EventArgs)
    Try
      Response.Redirect(sender.CommandArgument)
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
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
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
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
        If oTopics.Count Then
          pnlSearchResults.Visible = True
        Else
          pnlSearchResults.Visible = False
        End If
      End Using
      Session("hasSearched") = True
      txtSearch.Focus()
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub drpTranslation_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpTranslation.SelectedIndexChanged
    Try
      If Not (drpTranslation.SelectedValue = 0) Then
        Using oDB As New zakatEntities()
          Dim oTranslation As TRANSLATION = (From TRANSLATION In oDB.TRANSLATION Where TRANSLATION.translationId = drpTranslation.SelectedValue).FirstOrDefault
          Response.Redirect(oTranslation.translationURL)
        End Using
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub
End Class