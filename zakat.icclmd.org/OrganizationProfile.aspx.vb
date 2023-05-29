Public Class OrganizationProfile
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      Dim vOrganizationId As Int32 = CInt(Request.QueryString("o"))
      Dim aGoogleMapsAPIKey As String = System.Configuration.ConfigurationManager.AppSettings("GoogleMapsAPIKey")
      'go to organizations page if a url parameter for org is not passed
      If vOrganizationId = 0 Then Response.Redirect("organizations")

      'get org and populated fields
      Using oDB As New zakatEntities
        If (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.organizationId = vOrganizationId).Any Then
          Dim oOrganization As ORGANIZATION = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.organizationId = vOrganizationId).FirstOrDefault()
          lblOrganizationName.Text = oOrganization.name + "(" + oOrganization.abbreviation + ")"
          hypEmail.NavigateUrl = "mailto:" + oOrganization.email
          hypEmail.Text = oOrganization.email
          hypWebsite.NavigateUrl = oOrganization.website
          hypWebsite.Text = oOrganization.website
          lblPhone.Text = Base.getFormattedPhone(oOrganization.phone, Base.enumFormatPhone.Format)
          lblAddress.Text = oOrganization.street + " " + oOrganization.city + ", " + oOrganization.stateAbbr + " " + oOrganization.zip
          Dim vMapAddress As String = Replace(oOrganization.street, " ", "+") + ",+" + Replace(oOrganization.city, " ", "+") + ",+" + Replace(oOrganization.stateAbbr, " ", "+") + "+" + Replace(oOrganization.zip, " ", "+")
          ifrMap.Src = "https://www.google.com/maps/embed/v1/search?key=" + aGoogleMapsAPIKey + "&q=" + vMapAddress
        Else
          Response.Redirect("organizations")
        End If
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

End Class