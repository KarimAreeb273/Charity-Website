﻿Imports System.Net.NetworkInformation
Imports AjaxControlToolkit

Public Class Donate
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Using oDB As New zakatEntities

        If Not IsPostBack Then
          'load the state dropdown
          drpOrganization.DataSource = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.isDonationAccepted = True).ToList
          drpOrganization.DataTextField = "name"
          drpOrganization.DataValueField = "organizationId"
          drpOrganization.DataBind()
          drpOrganization.Items.Insert(0, New ListItem("(Select One)", 0))
          'default the donation date to today
          txtDonationDate.Text = FormatDateTime(Date.Now, DateFormat.ShortDate)
        End If

      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnDonation_Click(sender As Object, e As EventArgs) Handles btnDonation.Click
    Try
      Dim vPayPalToken As String
      Dim vPayPalImage As String
      Dim vOrgName As String
      Using oDB As New zakatEntities
        'obtain the organization 
        Dim oOrganization As ORGANIZATION = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.organizationId = drpOrganization.SelectedValue).FirstOrDefault()
        vPayPalToken = oOrganization.payPalIdentityToken
        vPayPalImage = oOrganization.payPalImageURL
        vOrgName = oOrganization.name
      End Using

      'get application configuration variables
      Dim aAppPayPalBaseURL As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalBaseURL")
      Dim aAppPayPalEmail As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalEmail")
      Dim aAppPayPalSuccessURLPDT As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalSuccessURLPDT")
      Dim aAppPayPalCancelURL As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalCancelURL")
      Dim aAppPayPalNotifyURLIPN As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalNotifyURLIPN")
      Dim vFirstname As String = txtFirstName.Text
      Dim vLastname As String = txtLastName.Text
      Dim vAmount As String = txtDonationAmount.Text
      Dim vDonationId As Integer

      vAmount = vAmount.Replace(",", "")  'remove commas
      vAmount = vAmount.Replace("$", "")  'remove dollar sign

      Using oDB As New zakatEntities

        ' create the donation record with isConfirmed set to false
        Dim oDonation As New DONATION
        With oDonation
          .isConfirmed = False
          .amount = FormatCurrency(vAmount)
          .donationDate = CDate(txtDonationDate.Text)
          .organizationId = drpOrganization.SelectedValue
          .firstName = vFirstname
          .lastName = vLastname
        End With

        ' Add to Memory
        oDB.DONATION.Add(oDonation)
        oDB.SaveChanges()

        vDonationId = oDonation.donationId
      End Using

      'save the new DonationId in the session for the PayPal return data (is the custom value)
      Session("sDonationId") = vDonationId
      Session("sOrganizationId") = drpOrganization.SelectedValue

      'Process via PayPal so create a PayPal request
      Dim vPayPalRequest As New StringBuilder
      vPayPalRequest.Append("<form name='frmpaypal' action='" + aAppPayPalBaseURL + "' method='POST'> ")
      vPayPalRequest.Append("<input type='hidden' name='business'    value='" + aAppPayPalEmail + "'>")
      vPayPalRequest.Append("<input type='hidden' name='cmd'         value='_cart'>")
      vPayPalRequest.Append("<input type='hidden' name='upload'      value='1'>")
      vPayPalRequest.Append("<input type='hidden' name='rm'          value='2'>")
      vPayPalRequest.Append("<input type='hidden' name='no_shipping' value='1'>") '0=(Default) prompted for address, 1=customer is not prompted for address, 2=customer must provide address
      vPayPalRequest.Append("<input type='hidden' name='cs'          value='0'>")
      vPayPalRequest.Append("<input type='hidden' name='image_url'          value='" + vPayPalImage + "'>")
      vPayPalRequest.Append("<input type='hidden' name='return'          value='" + aAppPayPalSuccessURLPDT + "'>")
      vPayPalRequest.Append("<input type='hidden' name='cancel_return'   value='" + aAppPayPalCancelURL + "'>")
      vPayPalRequest.Append("<input type='hidden' name='notify_url'  value='" + aAppPayPalNotifyURLIPN + "'>")
      vPayPalRequest.Append("<input type='hidden' name='payer_id'      value='" + CStr(0) + "'>")
      vPayPalRequest.Append("<input type='hidden' name='first_name'      value='" + vFirstname + "'>")
      vPayPalRequest.Append("<input type='hidden' name='last_name'       value='" + vLastname + "'>")
      vPayPalRequest.Append("<input type='hidden' name='item_name_1' value='" + "Donation for Organization: " + vOrgName + "'>")
      vPayPalRequest.Append("<input type='hidden' name='amount_1' value='" + FormatNumber(CInt(vAmount), 2) + "'>")
      vPayPalRequest.Append("<input type='hidden' name='quantity_1' value='1'>")
      vPayPalRequest.Append("<input type='hidden' name='custom' value='" + CStr(vDonationId) + "'>")
      vPayPalRequest.Append("<input type='hidden' name='num_cart_items' value='1'>")
      vPayPalRequest.Append("<script>window.document.frmpaypal.submit();	</script>")
      vPayPalRequest.Append("</form>")

      'Create the cookie: cookieDonation
      Dim cookieDonation As New HttpCookie("cookieDonation")
      'Set the Cookie value
      cookieDonation.Values.Add("DonationId", vDonationId)
      cookieDonation.Values.Add("OrganizationId", drpOrganization.SelectedValue)
      'Set the Expiry date for one (1) day
      cookieDonation.Expires = DateTime.Now.AddHours(1)

      'execute the PayPal Request which redirects to PayPal
      Response.Write(vPayPalRequest)

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

End Class