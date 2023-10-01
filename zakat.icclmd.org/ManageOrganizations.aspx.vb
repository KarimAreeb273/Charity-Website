﻿Public Class ManageOrganizations
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")
      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId And USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/")
        End If

        If Not IsPostBack Then
          'load the state dropdown
          drpState.DataSource = (From STATE In oDB.STATE).ToList
          drpState.DataTextField = "stateName"
          drpState.DataValueField = "stateAbbr"
          drpState.DataBind()
          drpState.Items.Insert(0, New ListItem("(Select One)", 0))
        End If

        'load the org repeater
        setOrganizations()
      End Using
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnAddOrganization_Click(sender As Object, e As EventArgs) Handles btnAddOrganization.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")

      Using oDB As New zakatEntities
        'check if the user has admin role
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId And USER_ROLE.ROLE.name = "Administrator").Any Then
          'add organization
          Dim oOrganization As New ORGANIZATION

          'insert information about new org and save to db
          With oOrganization
            .name = txtOrganizationName.Text
            .abbreviation = txtOrganizationAbbreviation.Text
            .email = txtEmail.Text
            .phone = Base.getFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip)
            .website = txtWebsite.Text
            .street = txtStreet.Text
            .city = txtCity.Text
            .stateAbbr = drpState.SelectedValue
            .zip = txtZip.Text
          End With

          ' Add to Memory
          oDB.ORGANIZATION.Add(oOrganization)
          oDB.SaveChanges()

          'update the org repeater
          setOrganizations()

          'clear fields
          txtOrganizationName.Text = ""
          txtOrganizationAbbreviation.Text = ""
          txtEmail.Text = ""
          txtPhone.Text = ""
          txtWebsite.Text = ""
          txtStreet.Text = ""
          txtCity.Text = ""
          drpState.SelectedIndex = 0
          txtZip.Text = ""
        Else
          'redirect home
          Response.Redirect("/")
        End If
      End Using
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function getDate(ByVal month As Short, ByVal day As Short) As Date
    Try
      getDate = CDate(month.ToString + day.ToString + Today.Year.ToString)
    Catch ex As Exception
      Return Nothing
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try

  End Function

  Public Function getAge(ByVal dob As Date) As Int16
    Try
      getAge = Base.getAge(dob)
    Catch ex As Exception
      Return Nothing
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try

  End Function

  Protected Sub btnEdit_Click(sender As Object, e As System.EventArgs) Handles btnEdit.Click
    Try
      'go home if no session/user
      Dim vOrganizationId As Int32 = sender.CommandArgument
      If vOrganizationId = 0 Then Response.Redirect("/")
      'set org session id and redirect
      Session("sOrganizationId") = vOrganizationId
      'redirect to org edit
      Response.Redirect("organizationedit")
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    Try
      getFormattedPhone = Base.getFormattedPhone(pPhone, Base.enumFormatPhone.Format)
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Function

  Sub setOrganizations()
    Try
      'update org repeater
      Using oDB As New zakatEntities
        rptOrganizations.DataSource = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.name <> "Placeholder").ToList
        rptOrganizations.DataBind()
      End Using
    Catch ex As Exception
      Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
      Response.Write(ex.Message)
    End Try
  End Sub

End Class