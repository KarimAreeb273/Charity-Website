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
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId AndAlso USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/")
        End If
      End Using

      'set users repeater
      setUsers()
      ''set applicant repeater
      'setApplicants()
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
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
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
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
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Protected Sub btnEdit_Click(sender As Object, e As EventArgs) Handles btnEdit.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = sender.CommandArgument
      If vUserId = 0 Then Response.Redirect("/")
      'set org session id and redirect
      Session("sOtherUserId") = vUserId
      'redirect to users edit
      Response.Redirect("useredit")
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
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
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    Try
      getFormattedPhone = Base.getFormattedPhone(pPhone, Base.enumFormatPhone.Format)
    Catch ex As Exception
      Return Nothing
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Function

  Public Function GetFormattedNumber(ByVal pMemberId As Int32) As String
    Try
      GetFormattedNumber = Base.getFormattedNumber(pMemberId)
    Catch ex As Exception
      Return Nothing
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Function

End Class