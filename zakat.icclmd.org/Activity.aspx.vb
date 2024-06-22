Public Class Activity
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/", False)

      Using oDB As New zakatEntities
        Dim oApplications As List(Of APPLICATION)
        oApplications = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId).ToList
        rptInbox.DataSource = oApplications
        rptInbox.DataBind()
      End Using

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Sub btnViewTimeline_Click(sender As Object, e As System.EventArgs)
    Try
      Session("sApplicationId") = sender.CommandArgument
      Response.Redirect("timeline", False)
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Function getFormattedNumber(ByVal pMemberId As Int32) As String
    Try
      getFormattedNumber = Base.getFormattedNumber(pMemberId)
    Catch ex As Exception
      Return Nothing
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Function

  Public Function getRejectionComment(ByVal pApplicationId As Int32) As String
    Try
      Using oDB As New zakatEntities
        Dim oReview As REVIEW = (From REVIEW In oDB.REVIEW Where REVIEW.applicationId = pApplicationId AndAlso REVIEW.reviewAction = "Rejected").First
        getRejectionComment = oReview.reviewComment
      End Using

    Catch ex As Exception
      Return Nothing
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Function

End Class