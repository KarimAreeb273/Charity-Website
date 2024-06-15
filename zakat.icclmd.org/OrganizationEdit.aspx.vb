Public Class OrganizationEdit
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

        If Not IsPostBack Then
          'load the form
          Dim vOrganizationId As Int32 = Session("sOrganizationId")
          Dim oOrganization As ORGANIZATION = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.organizationId = vOrganizationId).First
          With oOrganization
            txtOrganizationName.Text = .name
            txtOrganizationAbbreviation.Text = .abbreviation
            txtEmail.Text = .email
            txtPhone.Text = Base.GetFormattedPhone(.phone, Base.enumFormatPhone.Format)
            txtWebsite.Text = .website
            txtStreet.Text = .street
            txtCity.Text = .city
            drpState.SelectedValue = .stateAbbr
            txtZip.Text = .zip
            chkAcknowledgement.Checked = If(.isDonationAccepted, True, False)
            If chkAcknowledgement.Checked Then
              txtPayPalImg.Enabled = True
              txtPayPalToken.Enabled = True
              valPayPalImg.Enabled = True
              valPayPalToken.Enabled = True
              valPayPalImgUrl.Enabled = True
              txtPayPalImg.Text = .payPalImageURL
              txtPayPalToken.Text = .payPalIdentityToken
            Else
              txtPayPalImg.Enabled = False
              txtPayPalToken.Enabled = False
              valPayPalImg.Enabled = False
              valPayPalToken.Enabled = False
              valPayPalImgUrl.Enabled = False
              txtPayPalImg.Text = ""
              txtPayPalToken.Text = ""
            End If
            txtMission.Text = If(.missionStatement = "", "", .missionStatement)
          End With
        End If

      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnSaveOrganization_Click(sender As Object, e As EventArgs) Handles btnSaveOrganization.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")

      Dim vOrganizationId As Int32 = Session("sOrganizationId")
      If vOrganizationId = 0 Then Response.Redirect("/")

      Using oDB As New zakatEntities
        'check if the user has admin role
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId And USER_ROLE.ROLE.name = "Administrator").Any Then
          'insert information about new org and save to db
          Dim oOrganization As ORGANIZATION = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.organizationId = vOrganizationId).First
          With oOrganization
            .name = txtOrganizationName.Text
            .abbreviation = txtOrganizationAbbreviation.Text
            .email = txtEmail.Text
            .phone = Base.GetFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip)
            .website = txtWebsite.Text
            .street = txtStreet.Text
            .city = txtCity.Text
            .stateAbbr = drpState.SelectedValue
            .zip = txtZip.Text
            .isDonationAccepted = chkAcknowledgement.Checked
            .payPalImageURL = txtPayPalImg.Text
            .payPalIdentityToken = txtPayPalToken.Text
            .missionStatement = txtMission.Text
          End With

          ' Add to Memory
          oDB.SaveChanges()

          'redirect to orgs
          Response.Redirect("manageorganizations")
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