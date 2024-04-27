Imports System.Net.NetworkInformation

Public Class Discussion
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      If Not IsPostBack Then
        Dim vUserId As Int32 = Session("sUserId")
        Dim vPostId As Int32 = Request.QueryString("pid")
        txtPostTitle.Text = ""
        drpPostCategory.SelectedIndex = -1
        txtPostContent.Text = ""
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
            'btnLogInReply.Visible = True
            btnSubmitPost.Text = "Post as a Guest"
            'btnSubmitReply.Text = "Reply as a Guest"
          Else
            '  '"Logged in"
            btnLogInPost.Visible = False
            'btnLogInReply.Visible = False
            btnSubmitPost.Text = "Submit Post"
            'btnSubmitReply.Text = "Submit Reply"
          End If
        End If

        Using oDB As New zakatEntities
          'update post category repeater
          Dim oPostCategories As List(Of POST_CATEGORY) = (From POST_CATEGORY In oDB.POST_CATEGORY Order By POST_CATEGORY.name).ToList
          rptPostCategories.DataSource = oPostCategories
          rptPostCategories.DataBind()
          drpPostCategory.DataSource = oPostCategories
          drpPostCategory.DataTextField = "name"
          drpPostCategory.DataValueField = "postCategoryId"
          drpPostCategory.DataBind()
          drpPostCategory.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          'update post repeater
          Dim oPost As List(Of POST) = (From POST In oDB.POST Where POST.postId = vPostId Or POST.postParentId = vPostId Order By POST.postCreatedOn).ToList
          rptPosts.DataSource = oPost
          rptPosts.DataBind()
        End Using
      End If

    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
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

  'Private Sub btnAddComment_Click(sender As Object, e As EventArgs) Handles btnAddComment.Click
  '    txtAnswer.Visible = True
  '    btnAddComment.Visible = False
  '    btnNoComment.Visible = True
  '    btnSubmit.Visible = True
  'End Sub

  'Private Sub btnNoComment_Click(sender As Object, e As EventArgs) Handles btnNoComment.Click
  '    txtAnswer.Visible = False
  '    btnAddComment.Visible = True
  '    btnNoComment.Visible = False
  '    btnSubmit.Visible = False
  'End Sub

  'Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
  '    Try

  '        Using oDB As New zakatEntities
  '            'add organization
  '            Dim oPost As New POST

  '            'insert information about new org and save to db
  '            With oPost
  '                .postContent = txtAnswer.InnerText
  '                '.postParentId = 
  '            End With

  '            ' Add to Memory
  '            oDB.POST.Add(oPost)
  '            oDB.SaveChanges()

  '            'update the org repeater
  '            setPosts()


  '        End Using
  '    Catch ex As Exception
  '        Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
  '        Response.Write(ex.Message)
  '    End Try
  'End Sub
  Public Sub btnViewPostCategory_Click(sender As Object, e As System.EventArgs)
    Try
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
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
        'setPosts()
        Response.Redirect("discussion?pid=" + vPostId)

        'clear fields
      End Using
      ''refresh page
      'Response.Redirect("Discussion")

    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
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
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub
  Protected Sub btnReplyPost_Click(sender As Object, e As System.EventArgs)
    Try
      'update modal based on which link is clicked
      Dim vUserId As Integer = Session("sUserId")
      Dim vPostId As Integer = sender.CommandArgument
      'btnSubmitReply.CommandArgument = vPostId

      'pnlReplyPostForm.visible = True

      Using oDB As New zakatEntities

        Dim oPost As POST = (From POST In oDB.POST Where POST.postId = vPostId).First()
        'lblReplyTitle.Text = "Re: " + oPost.postTitle
        'lblReplyCategory.Text = oPost.POST_CATEGORY.name
      End Using
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
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
        Response.Redirect("discussion?pid=" + vPostId)

        'clear fields
      End Using

    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
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
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
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
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Function
End Class