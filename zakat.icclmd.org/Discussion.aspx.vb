Imports System.Net.NetworkInformation
Imports System.Web.UI.WebControls.Expressions

Public Class Discussion
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      If Not IsPostBack Then
        Dim vUserId As Int32 = Session("sUserId")
        Dim vPostId As Int32 = CInt(Request.QueryString("pid"))
        Dim vCategoryId As Int32 = CInt(Request.QueryString("cid"))
        Dim vSearch As String = (Request.QueryString("s"))
        txtPostTitle.Text = ""
        drpPostCategory.SelectedIndex = -1
        txtPostContent.Text = ""
        ' Show landing page if there no instructions
        If vPostId = 0 And vCategoryId = 0 And vSearch = "" Then
          pnlLanding.Visible = True
          pnlPosts.Visible = False
          pnlSearch.Visible = False
          pnlCategories.Visible = False
        End If
        ' Since a category was clicked, go get all the posts for that category
        If vCategoryId <> 0 Then
          pnlCategories.Visible = True
          pnlPosts.Visible = False
          pnlSearch.Visible = False
          pnlLanding.Visible = False
          pnlBody.ScrollBars = ScrollBars.Vertical

          Using oDB As New zakatEntities
            'Dynamically changing the context header for categories
            Dim oPostCategoryLabel As POST_CATEGORY = (From POST_CATEGORY In oDB.POST_CATEGORY Where POST_CATEGORY.postCategoryId = vCategoryId).First()
            lblCategory.Text = oPostCategoryLabel.name

            'update post for specific category repeater and dynamically change the No Post message visibility
            Dim oPost As List(Of POST) = (From POST In oDB.POST Where POST.postCategoryId = vCategoryId Order By POST.postCreatedOn).ToList
            rptPostCategories.DataSource = oPost
            rptPostCategories.DataBind()
            lblCategoryResults.Text = oPost.Count
            If oPost.Count = 0 Then
              pnlNoPostCategoryMsg.Visible = True
            Else
              pnlNoPostCategoryMsg.Visible = False
            End If
          End Using
        End If
        If vPostId = 0 Then
          If vUserId = 0 Then
            '  '"Not Logged In"
            btnLogInPost.Visible = True
            btnSubmitPost.Text = "Post as a Guest"
          Else
            '  '"Logged in"
            btnLogInPost.Visible = False
            btnSubmitPost.Text = "Submit Post"
          End If
        Else
          If vUserId = 0 Then
            '  '"Not Logged In"
            btnLogInPost.Visible = True
            btnSubmitPost.Text = "Post as a Guest"
          Else
            '  '"Logged in"
            btnLogInPost.Visible = False
            btnSubmitPost.Text = "Submit Post"
          End If
        End If
        ' Showing the Parent Posts and replies
        If vPostId <> 0 Then
          pnlPosts.Visible = True
          pnlCategories.Visible = False
          pnlSearch.Visible = False
          pnlLanding.Visible = False
          pnlBody.ScrollBars = ScrollBars.Vertical

          Using oDB As New zakatEntities
            Dim oPostLabel As POST = (From POST In oDB.POST Where POST.postId = vPostId).First()
            lblPosts.Text = oPostLabel.postTitle
            lblPostResults.Text = oPostLabel.countOfReplies

            'update post repeater
            Dim oPost As List(Of POST) = (From POST In oDB.POST Where POST.postId = vPostId Or POST.postParentId = vPostId Order By POST.postCreatedOn).ToList
            rptPosts.DataSource = oPost
            rptPosts.DataBind()
          End Using
        End If
        ' Show all posts for searched term
        If vSearch <> "" Then
          pnlPosts.Visible = False
          pnlCategories.Visible = False
          pnlSearch.Visible = True
          pnlLanding.Visible = False
          pnlBody.ScrollBars = ScrollBars.Vertical
          lblKeywordSearch.Text = vSearch

          Using oDB As New zakatEntities()
            Dim oPosts As List(Of POST) = oDB.POST.Where(Function(n) (n.postContent.Contains(vSearch)) Or n.postTitle.Contains(vSearch)).OrderByDescending(Function(n) n.postCreatedOn).ToList()
            rptSearchResultsDisplay.DataSource = oPosts
            rptSearchResultsDisplay.DataBind()
            lblSearchResults.Text = oPosts.Count
            If oPosts.Count = 0 Then
              pnlNoSearchMsg.Visible = True
            Else
              pnlNoSearchMsg.Visible = False
            End If
          End Using
        End If
        Using oDB As New zakatEntities
          'update category repeater
          Dim oPostCategories As List(Of POST_CATEGORY) = (From POST_CATEGORY In oDB.POST_CATEGORY Order By POST_CATEGORY.name).ToList
          rptCategories.DataSource = oPostCategories
          rptCategories.DataBind()
          drpPostCategory.DataSource = oPostCategories
          drpPostCategory.DataTextField = "name"
          drpPostCategory.DataValueField = "postCategoryId"
          drpPostCategory.DataBind()
          drpPostCategory.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))
        End Using
      End If

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub
  Private Sub btnCollapse_Click(sender As Object, e As EventArgs) Handles btnCollapse.Click
    btnCollapse.Visible = False
    btnExpand.Visible = True
    pnlNavigateShow.Visible = False
    pnlNavigateHide.Visible = Visible
    pnlNavigateShow.Width = 170
    pnlNavigateHide.Width = 40
    pnlBody.Width = 1130
  End Sub

  Private Sub btnExpand_Click(sender As Object, e As EventArgs) Handles btnExpand.Click
    btnCollapse.Visible = True
    btnExpand.Visible = False

    pnlNavigateShow.Visible = True
    pnlNavigateHide.Visible = False

    pnlNavigateShow.Width = 170
    pnlNavigateHide.Width = 40
    pnlBody.Width = 1000
  End Sub
  Private Sub btnLogInPost_Click(sender As Object, e As EventArgs) Handles btnLogInPost.Click
    Response.Redirect("/")
  End Sub
  Public Sub btnViewPostCategory_Click(sender As Object, e As System.EventArgs)
    Try
      Response.Redirect("discussion?cid=" & sender.CommandArgument)

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnSubmitPost_Click(sender As Object, e As EventArgs) Handles btnSubmitPost.Click
    Try

      'Determine if User is logged in or not
      Dim vUserId As Int32 = Session("sUserId")

      Using oDB As New zakatEntities
        'add post
        Dim oPost As New POST
        Dim vPostCategoryId As Int32 = drpPostCategory.SelectedValue
        Dim oPostCategory As POST_CATEGORY = (From POST_CATEGORY In oDB.POST_CATEGORY Where POST_CATEGORY.postCategoryId = vPostCategoryId).First()
        Dim vPostCategoryCount As Int32

        'insert information about new post and save to db
        With oPost
          .postTitle = txtPostTitle.Text
          .postCategoryId = drpPostCategory.SelectedValue
          .postContent = txtPostContent.Text
          .countOfReplies = 0
          .postCreatedOn = Date.Now
          .postUpdatedOn = Date.Now
          .postCreatedBy = IIf(vUserId = 0, Nothing, vUserId)
        End With

        ' Add to Memory
        oDB.POST.Add(oPost)
        oDB.SaveChanges()
        Dim vPostId As Int32 = oPost.postId

        'update post category with the total count of posts with the current selected category
        vPostCategoryCount = (From POST In oDB.POST Where POST.postCategoryId = drpPostCategory.SelectedValue).Count()
        oPostCategory.countOfPosts = vPostCategoryCount
        oDB.SaveChanges()


        'update the post repeater
        'reset modal form
        txtPostTitle.Text = ""
        drpPostCategory.SelectedValue = "(Select One)"
        txtPostContent.Text = ""
        Response.Redirect("discussion?pid=" & vPostId)

        'clear fields
      End Using

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub
  Sub setPosts(Optional pPostId As Int32 = 0)
    Try
      If pPostId <> 0 Then
        'update post repeater
        Using oDB As New zakatEntities
          rptPosts.DataSource = (From POST In oDB.POST Where POST.postId = pPostId Or POST.postParentId = pPostId Order By POST.postCreatedOn).ToList
          rptPosts.DataBind()
        End Using
      End If

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub
  Protected Sub btnReplyPost_Click(sender As Object, e As System.EventArgs)
    Try
      'update modal based on which link is clicked
      Dim vUserId As Integer = Session("sUserId")
      Dim vPostId As Integer = sender.CommandArgument

      Using oDB As New zakatEntities
        Dim oPost As POST = (From POST In oDB.POST Where POST.postId = vPostId).First()
      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Sub btnSubmitReply_Click(sender As Object, e As EventArgs)
    Try

      'Determine if User is logged in or not
      Dim vUserId As Int32 = Session("sUserId")
      Dim vPostId As Int32 = sender.CommandArgument

      Using oDB As New zakatEntities
        'add post
        Dim oParentPost As POST = (From POST In oDB.POST Where POST.postId = vPostId).First()
        Dim oPost As New POST

        'retrieving items within repeater
        Dim item As RepeaterItem = CType((CType(sender, Button)).NamingContainer, RepeaterItem)
        Dim txtReplyContent As TextBox = CType(item.FindControl("txtReplyContent"), TextBox)

        'insert information about new post and save to db
        With oPost
          .postParentId = vPostId
          .postTitle = IIf(InStr(oParentPost.postTitle, "Re: ") = 0, "Re: " + oParentPost.postTitle, oParentPost.postTitle)
          .postCategoryId = oParentPost.postCategoryId
          .postContent = txtReplyContent.Text
          .countOfReplies = 0
          .postCreatedOn = Date.Now
          .postUpdatedOn = Date.Now
          .postCreatedBy = IIf(vUserId = 0, Nothing, vUserId)
        End With

        ' Add to Memory
        oDB.POST.Add(oPost)
        oDB.SaveChanges()

        'update post with the total count of replies 
        Dim vPostRepliesCount As Int32 = (From POST In oDB.POST Where POST.postParentId = vPostId).Count()
        oParentPost.countOfReplies = vPostRepliesCount
        oDB.SaveChanges()

        'update the reply repeater
        txtReplyContent.Text = ""
        Response.Redirect("discussion?pid=" & vPostId)

        'clear fields
      End Using

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Function getName(Optional pUserId As Integer = 0) As String
    Try
      If pUserId = 0 Then
        getName = "Anonymous"
      Else
        ' Retrieve User First Name
        Using oDB As New zakatEntities
          Dim oUser As USER = (From USER In oDB.USER Where USER.userId = pUserId).First()
          getName = oUser.firstName
        End Using
      End If
    Catch ex As Exception
      Return ""
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Function

  Public Function getUser()
    Try
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then
        getUser = "Anonymous"
      Else
        ' Retrieve User First Name
        Using oDB As New zakatEntities
          Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vUserId).First()
          getUser = oUser.firstName
        End Using
      End If
    Catch ex As Exception
      Return ""
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Function

  Public Function GetHighlightedContent(ByVal pContent As String) As String
    Try
      Dim vSearch As String
      vSearch = (Request.QueryString("s"))
      'find the search string in the content
      Dim vSearchResult As Int16 = InStr(1, LCase(pContent), LCase(vSearch), 1)
      If vSearchResult > 0 Then
        Dim vOriginalSearchValue As String = pContent.Substring(vSearchResult - 1, Len(vSearch))
        'find the first instance of the serach within the content & store a snippet using 10 characters before and 10 characters after
        pContent = Replace(pContent, vOriginalSearchValue, ("<mark>" + vOriginalSearchValue + "</mark>"))
        pContent = Replace(pContent, "</mark> ", "</mark>")
        pContent = Replace(pContent, " </mark>", "</mark>")
        pContent = Replace(pContent, "<mark> ", "<mark>")
        pContent = Replace(pContent, " <mark>", "<mark>")
        Dim vSpacePosition As Int32 = InStrRev(pContent, " ")
        Return pContent
      Else
        Return pContent
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
      vSearch = txtSearch.Text
      Response.Redirect("discussion?s=" & vSearch)
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub
  Public Sub btnViewContent_Click(sender As Object, e As System.EventArgs)
    Try
      Dim vPostId As Int32 = sender.CommandArgument
      Response.Redirect("discussion?pid=" & vPostId)
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub
End Class