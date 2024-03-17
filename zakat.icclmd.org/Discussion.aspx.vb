Imports System.Net.NetworkInformation

Public Class Discussion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      If Not IsPostBack Then
        Dim vUserId As Int32 = Session("sUserId")
        txtPostTitle.Text = ""
        drpPostCategory.SelectedIndex = -1
        txtPostContent.Text = ""
        If vUserId = 0 Then
          '"Not Logged In"
          divNotLoggedIn.Visible = True
          divLoggedIn.Visible = False
          divNotLoggedInPost.Visible = True
          divLoggedInPost.Visible = False
        Else
          '"Logged in"
          divLoggedIn.Visible = True
          divNotLoggedIn.Visible = False
          divNotLoggedInPost.Visible = False
          divLoggedInPost.Visible = True
        End If
        'update org repeater
        Using oDB As New zakatEntities
          Dim oPostCategories As List(Of POST_CATEGORY) = (From POST_CATEGORY In oDB.POST_CATEGORY Order By POST_CATEGORY.name).ToList
          rptPostCategories.DataSource = oPostCategories
          rptPostCategories.DataBind()
          drpPostCategory.DataSource = oPostCategories
          drpPostCategory.DataTextField = "name"
          drpPostCategory.DataValueField = "postCategoryId"
          drpPostCategory.DataBind()
          drpPostCategory.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))
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
    Private Sub btnLogIn_Click(sender As Object, e As EventArgs) Handles btnLogIn.Click
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

  Private Sub btnSubmitPost_Click(sender As Object, e As EventArgs) Handles btnGuestSubmitPost.Click, btnUserSubmitPost.Click
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
          .postHeader = txtPostTitle.Text
          .postCategoryId = drpPostCategory.SelectedValue
          .postContent = txtPostContent.Text
          .hasPosts = 0
          .postCreatedOn = Date.Now
          .postCreatedBy = IIf(vUserId = 0, Nothing, vUserId)
        End With

        ' Add to Memory
        oDB.POST.Add(oPost)
        oDB.SaveChanges()

        'update post category with the total count of posts with the current selected category
        vPostCategoryCount = (From POST In oDB.POST Where POST.postCategoryId = drpPostCategory.SelectedValue).Count()
        oPostCategory.countOfPosts = vPostCategoryCount
        oDB.SaveChanges()

        'update the post repeater
        setPosts()

        'clear fields
      End Using
      'refresh page
      Response.Redirect("discussion")

    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub
  Sub setPosts()
    Try
      'update org repeater
      Using oDB As New zakatEntities
        rptPosts.DataSource = (From POST In oDB.POST Where POST.postId <> "Placeholder").ToList
        rptPosts.DataBind()
      End Using
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub
  Public Sub btnReplyPost_Click(sender As Object, e As System.EventArgs)

  End Sub

End Class