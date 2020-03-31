﻿Public Class UserRoles
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")

      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/")
        End If

        If Not IsPostBack Then
          'load the state dropdown
          lstUsers.DataSource = (From USER In oDB.USER Select New With {Key .fullName = USER.firstName & " " & USER.lastName & " - " & USER.email, Key .userId = USER.userId}).ToList
          lstUsers.DataTextField = "fullname"
          lstUsers.DataValueField = "userId"
          lstUsers.DataBind()

          lstAvailable.DataSource = (From ROLE In oDB.ROLE Order By ROLE.name).ToList
          lstAvailable.DataTextField = "name"
          lstAvailable.DataValueField = "roleId"
          lstAvailable.DataBind()

          'load the organization dropdown
          drpOrganization.DataSource = (From ORGANIZATION In oDB.ORGANIZATION Order By ORGANIZATION.name Select New With {Key .name = "(" & ORGANIZATION.organizationId & ") " & ORGANIZATION.name, Key .organizationId = ORGANIZATION.organizationId}).ToList
          drpOrganization.DataTextField = "name"
          drpOrganization.DataValueField = "organizationId"
          drpOrganization.DataBind()
          drpOrganization.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))
        End If

      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub lstUsers_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lstUsers.SelectedIndexChanged
    refreshLstAssigned()
  End Sub

  Private Sub txtSearchUser_TextChanged(sender As Object, e As EventArgs) Handles txtSearchUser.TextChanged
    clearSearchUser()
  End Sub

  Private Sub btnClear_Click(sender As Object, e As EventArgs) Handles btnClear.Click
    txtSearchUser.Text = ""
    lblUser.Text = "Select a User"
    clearSearchUser()
  End Sub

  Private Sub btnAddRole_Click(sender As Object, e As EventArgs) Handles btnAddRole.Click
    Try
      'if nothing is selected in the lstAvailable listbox, stop
      If lstAvailable.SelectedIndex = -1 Then Exit Sub

      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")

      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/")
        End If

        'get the selected role:
        Dim vNeededRole As Int32 = lstAvailable.SelectedValue
        If vNeededRole = 0 Then Exit Sub
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = CInt(lstUsers.SelectedValue) And USER_ROLE.ROLE.roleId = CInt(lstAvailable.SelectedValue) And USER_ROLE.organizationId = drpOrganization.SelectedValue).Any Then
          'add role to the user
          Dim oUserRole As New USER_ROLE
          With oUserRole
            .userId = lstUsers.SelectedValue
            .roleId = lstAvailable.SelectedValue
            .organizationId = drpOrganization.SelectedValue
          End With
          ' Add to Memory
          oDB.USER_ROLE.Add(oUserRole)
          oDB.SaveChanges()

          'update lstAssigned Roles listbox
          refreshLstAssigned()
        End If
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnDeleteRole_Click(sender As Object, e As EventArgs) Handles btnDeleteRole.Click
    Try
      'if nothing is selected in the lstAssigned listbox, stop
      If lstAssigned.SelectedIndex = -1 Then Exit Sub

      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")
      'if the logged in user tries to remove a permission, exit sub
      If vUserId = lstUsers.SelectedValue Then Exit Sub

      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/")
        End If

        'get the selected role:
        Dim vNeededRole As Int32 = lstAssigned.SelectedValue
        If vNeededRole = 0 Then Exit Sub
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userRoleId = CInt(lstAssigned.SelectedValue)).Any Then
          'add role to the user
          Dim oUserRole As USER_ROLE = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userRoleId = CInt(lstAssigned.SelectedValue)).First
          oDB.USER_ROLE.Remove(oUserRole)
          oDB.SaveChanges()

          'update lstAssigned Roles listbox
          refreshLstAssigned()
        End If
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub refreshLstAssigned()
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")

      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/")
        Else
          'get the select user in the listbox and display their current roles
          Dim oUser As USER = (From USER In oDB.USER Where USER.userId = lstUsers.SelectedValue).First
          Dim vSelectedUserId As Int32
          If Not lstUsers.SelectedIndex = -1 Then
            vSelectedUserId = lstUsers.SelectedValue
            lblUser.Text = oUser.firstName & " " & oUser.middleName & " " & oUser.lastName
            lblEmail.Text = oUser.email
          Else
            Exit Sub
          End If

          'load the assigned roles listbox
          lstAssigned.DataSource = (From USER_ROLE In oDB.USER_ROLE Join ROLE In oDB.ROLE On USER_ROLE.roleId Equals ROLE.roleId Where USER_ROLE.userId = vSelectedUserId Select New With {Key .userRoleId = USER_ROLE.userRoleId, Key .name = ROLE.name & " (for " & CStr(USER_ROLE.organizationId) & ")"}).ToList
          lstAssigned.DataTextField = "name"
          lstAssigned.DataValueField = "userRoleId"
          lstAssigned.DataBind()
        End If
      End Using

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub clearSearchUser()
    Try
      lblUser.Text = "Select a User"
      Using oDB As New zakatEntities
        lstUsers.DataSource = (From USER In oDB.USER Where USER.firstName.Contains(txtSearchUser.Text) Or USER.lastName.Contains(txtSearchUser.Text) Or USER.email.Contains(txtSearchUser.Text) Select New With {Key .fullName = USER.firstName & " " & USER.lastName & " - " & USER.email, Key .userId = USER.userId}).ToList
        lstUsers.DataTextField = "fullname"
        lstUsers.DataValueField = "userId"
        lstUsers.DataBind()
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpOrganization_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpOrganization.SelectedIndexChanged
    If drpOrganization.SelectedValue = "(Select One)" Then
      lstUsers.Enabled = False
      lstAvailable.Enabled = False
      lstAssigned.Enabled = False
      btnAddRole.Enabled = False
      btnDeleteRole.Enabled = False
      btnClear.Enabled = False
      btnSearch.Enabled = False
      txtSearchUser.Enabled = False
    Else
      lstUsers.Enabled = True
      lstAvailable.Enabled = True
      lstAssigned.Enabled = True
      btnAddRole.Enabled = True
      btnDeleteRole.Enabled = True
      btnClear.Enabled = True
      btnSearch.Enabled = True
      txtSearchUser.Enabled = True
    End If
  End Sub
End Class