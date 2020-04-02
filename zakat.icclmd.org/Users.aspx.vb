Public Class Users
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      Response.Write("")

      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")
      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId And USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/")
        End If
      End Using

      'set users repeater
      setUsers()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtEmail_TextChanged(sender As Object, e As EventArgs) Handles txtEmail.TextChanged
    Try
      Using oDB As New zakatEntities
        'reset validator
        valDuplicateEmail.IsValid = True
        'validate that its not already registered by a user
        If (From USER In oDB.USER Where USER.email = txtEmail.Text).Any Then
          valDuplicateEmail.IsValid = False
          Exit Sub
        End If
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setUsers()
    Try
      'update user repeater and update the badge
      Using oDB As New zakatEntities
        rptUsers.DataSource = (From USER_ROLE In oDB.USER_ROLE
                               Where USER_ROLE.roleId <> Base.enumRole.Appliciant
                               Select New With {Key .userId = USER_ROLE.userId,
                                                Key .phone = USER_ROLE.USER.phone,
                                                Key .fullName = USER_ROLE.USER.firstName & " " & USER_ROLE.USER.middleName & " " & USER_ROLE.USER.lastName,
                                                Key .email = USER_ROLE.USER.email}).Distinct.ToList
        rptUsers.DataBind()
        lblUsersCountBadge.Text = rptUsers.Items.Count
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Protected Sub btnEdit_Click(sender As Object, e As System.EventArgs) Handles btnEdit.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = sender.CommandArgument
      If vUserId = 0 Then Response.Redirect("/")
      'set org session id and redirect
      Session("sOtherUserId") = vUserId
      'redirect to org edit
      Response.Redirect("useredit")
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnAddUser_Click(sender As Object, e As EventArgs) Handles btnAddUser.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")

      Using oDB As New zakatEntities
        'check if the user has admin role
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId And USER_ROLE.ROLE.name = "Administrator").Any Then
          'reset validator
          valDuplicateEmail.IsValid = True
          'validate that its not already registered by a user
          If (From USER In oDB.USER Where USER.email = txtEmail.Text).Any Then
            valDuplicateEmail.IsValid = False
            Exit Sub
          End If

          'get the "Placeholder" organization
          Dim oOrganization As ORGANIZATION = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.name = "Placeholder").First
          Dim vOrganizationId As Int32 = oOrganization.organizationId

          'add new user
          Dim vNewUserId As Int32
          vNewUserId = Base.createUser(Base.enumRole.General, vOrganizationId, txtEmail.Text, txtFirstName.Text, txtLastName.Text, txtMiddleName.Text, Base.getFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip))

          'update the org repeater
          setUsers()

          'clear fields
          txtEmail.Text = ""
          txtFirstName.Text = ""
          txtMiddleName.Text = ""
          txtLastName.Text = ""
          txtPhone.Text = ""
        Else
          'redirect home
          Response.Redirect("/")
        End If
      End Using

      'refresh page
      Response.Redirect("users")
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    getFormattedPhone = Base.getFormattedPhone(pPhone, Base.enumFormatPhone.Format)
  End Function

End Class