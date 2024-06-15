Public Class ManageOrganizations
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
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
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
                        .isDonationAccepted = chkAcknowledgement.Checked
                        .payPalImageURL = txtPayPalImg.Text
                        .payPalIdentityToken = txtPayPalToken.Text
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
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Function getDate(ByVal month As Short, ByVal day As Short) As Date
    Try
      getDate = CDate(month.ToString + day.ToString + Today.Year.ToString)
    Catch ex As Exception
      Return Nothing
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try

  End Function

  Public Function getAge(ByVal dob As Date) As Int16
    Try
      getAge = Base.getAge(dob)
    Catch ex As Exception
      Return Nothing
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
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
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    Try
      getFormattedPhone = Base.getFormattedPhone(pPhone, Base.enumFormatPhone.Format)
    Catch ex As Exception
      Return Nothing
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
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
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

    Private Sub chkAcknowledgment_CheckedChanged(sender As Object, e As EventArgs) Handles chkAcknowledgement.CheckedChanged
        Try
            'enable PayPal fields if the check is true otherwise disable them
            If chkAcknowledgement.Checked Then
                txtPayPalImg.Enabled = True
                txtPayPalToken.Enabled = True
                valPayPalImg.Enabled = True
                valPayPalToken.Enabled = True
                valPayPalImgUrl.Enabled = True
            Else
                txtPayPalImg.Enabled = False
                txtPayPalToken.Enabled = False
                valPayPalImg.Enabled = False
                valPayPalToken.Enabled = False
                valPayPalImgUrl.Enabled = False
                txtPayPalImg.Text = ""
                txtPayPalToken.Text = ""
            End If
        Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
    End Sub

End Class