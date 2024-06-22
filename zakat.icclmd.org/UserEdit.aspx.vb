Public Class UserEdit
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/", False)

      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/", False)
        End If

        If Not IsPostBack Then
          'load the form
          Dim vOtherUserId As Int32 = Session("sOtherUserId")
          Dim oUser As USER = (From User In oDB.USER Where User.userId = vOtherUserId).First
          With oUser
            txtUserId.Text = Base.getFormattedNumber(.userId)
            txtCreatedOn.Text = FormatDateTime(.createdOn, DateFormat.LongDate)
            txtEmail.Text = .email
            txtFirstName.Text = .firstName
            txtMiddleName.Text = .middleName
            txtLastName.Text = .lastName
            txtPhone.Text = Base.getFormattedPhone(.phone, Base.enumFormatPhone.Format)
          End With
        End If

      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnSaveUser_Click(sender As Object, e As EventArgs) Handles btnSaveUser.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/", False)

      'go home if no other user to update
      Dim vOtherUserId As Int32 = Session("sOtherUserId")
      If vOtherUserId = 0 Then Response.Redirect("/", False)

      Using oDB As New zakatEntities
        'check if the user has admin role
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId And USER_ROLE.ROLE.name = "Administrator").Any Then
          'insert information about new org and save to db
          Dim oUser As USER = (From User In oDB.USER Where User.userId = vOtherUserId).First
          With oUser
            .email = txtEmail.Text
            .firstName = txtFirstName.Text
            .middleName = txtMiddleName.Text
            .lastName = txtLastName.Text
            .phone = Base.getFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip)
            .updatedBy = vUserId
            .updatedOn = Date.Now
          End With

          ' Add to Memory
          oDB.SaveChanges()

          'redirect to users
          Response.Redirect("users")
        Else
          'redirect home
          Response.Redirect("/", False)
        End If
      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub txtEmail_TextChanged(sender As Object, e As EventArgs) Handles txtEmail.TextChanged
    Try
      'go home if no other user to update
      Dim vOtherUserId As Int32 = Session("sOtherUserId")
      If vOtherUserId = 0 Then Response.Redirect("/", False)

      Using oDB As New zakatEntities
        'reset validator
        valDuplicateEmail.IsValid = True
        'validate that its not already registered by a user other than the one being updated
        If (From USER In oDB.USER Where USER.userId <> vOtherUserId And USER.email = txtEmail.Text).Any Then
          valDuplicateEmail.IsValid = False
          Exit Sub
        End If
      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

End Class