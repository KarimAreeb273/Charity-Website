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
            txtOrganizationName.Text = oOrganization.name
            txtEmail.Text = oOrganization.email
            txtPhone.Text = Base.getFormattedPhone(oOrganization.phone, Base.enumFormatPhone.Format)
            txtWebsite.Text = oOrganization.website
            txtStreet.Text = oOrganization.street
            txtCity.Text = oOrganization.city
            drpState.SelectedValue = oOrganization.stateAbbr
            txtZip.Text = oOrganization.zip
          End With
        End If

      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
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
            .email = txtEmail.Text
            .phone = Base.getFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip)
            .website = txtWebsite.Text
            .street = txtStreet.Text
            .city = txtCity.Text
            .stateAbbr = drpState.SelectedValue
            .zip = txtZip.Text
          End With

          ' Add to Memory
          oDB.SaveChanges()

          'redirect to orgs
          Response.Redirect("organizations")
        Else
          'redirect home
          Response.Redirect("/")
        End If
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

End Class