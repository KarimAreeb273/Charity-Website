Imports System.Net.NetworkInformation

Public Class Donate
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'go home if no session/user
            Using oDB As New zakatEntities

                If Not IsPostBack Then
                    'load the state dropdown
                    drpOrganization.DataSource = (From ORGANIZATION In oDB.ORGANIZATION).ToList
                    drpOrganization.DataTextField = "name"
                    drpOrganization.DataValueField = "organizationId"
                    drpOrganization.DataBind()
                    drpOrganization.Items.Insert(0, New ListItem("(Select One)", 0))
                    'default the donation date to today
                    txtDonationDate.Text = FormatDateTime(Date.Now, DateFormat.ShortDate)
                End If

            End Using
        Catch ex As Exception
            Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
            Response.Write(ex.Message)
        End Try
    End Sub

    Private Sub btnDonation_Click(sender As Object, e As EventArgs) Handles btnDonation.Click
        Try

            Using oDB As New zakatEntities
                'obtain the organization 
                Dim oOrganization As ORGANIZATION = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.organizationId = drpOrganization.SelectedValue).FirstOrDefault()
                Dim vPayPalToken As String = oOrganization.payPalIdentityToken
                Dim vPayPalImage As String = oOrganization.payPalImageURL
            End Using


            'get application configuration variables
            Dim aAppPayPalBaseURL As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalBaseURL")
            Dim aAppPayPalEmail As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalEmail")
            'Dim aAppPayPalImageURL As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalImageURL")
            Dim aAppPayPalSuccessURLPDT As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalSuccessURLPDT")
            Dim aAppPayPalCancelURL As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalCancelURL")
            Dim aAppPayPalNotifyURLIPN As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalNotifyURLIPN")
            'Dim vFirstname As String
            'Dim vLastname As String
            Dim vAmount As String = txtDonationAmount.Text
            Dim vDonationId As Integer

            vAmount = vAmount.Replace(",", "")  'remove commas
            vAmount = vAmount.Replace("$", "")  'remove dollar sign

            Using oDB As New zakatEntities

                ' create the member dues payment record with isConfirmed set to false
                Dim oDonation As New DONATION
                With oDonation
                    .isConfirmed = False
                    .amount = FormatCurrency(vAmount)
                    .donationDate = CDate(txtDonationDate.Text)
                    .organizationId = drpOrganization.SelectedValue
                    'Will add the first name and last name
                End With

                ' Add to Memory
                oDB.DONATION.Add(oDonation)
                oDB.SaveChanges()

                vDonationId = oDonation.donationId
            End Using

            'save the new DonationId in the session for the PayPal return data (is the custom value)
            Session("sDonationId") = vDonationId

            'Process via PayPal so create a PayPal request
            'Dim vPayPalRequest As New StringBuilder
            'vPayPalRequest.Append("<form name='frmpaypal' action='" + aAppPayPalBaseURL + "' method='POST'> ")
            'vPayPalRequest.Append("<input type='hidden' name='business'    value='" + aAppPayPalEmail + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='cmd'         value='_cart'>")
            'vPayPalRequest.Append("<input type='hidden' name='upload'      value='1'>")
            'vPayPalRequest.Append("<input type='hidden' name='rm'          value='2'>")
            'vPayPalRequest.Append("<input type='hidden' name='no_shipping' value='1'>") '0=(Default) prompted for address, 1=customer is not prompted for address, 2=customer must provide address
            'vPayPalRequest.Append("<input type='hidden' name='cs'          value='0'>")
            'vPayPalRequest.Append("<input type='hidden' name='image_url'          value='" + aAppPayPalImageURL + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='return'          value='" + aAppPayPalSuccessURLPDT + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='cancel_return'   value='" + aAppPayPalCancelURL + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='notify_url'  value='" + aAppPayPalNotifyURLIPN + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='payer_id'      value='" + CStr(vMemberId) + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='first_name'      value='" + vFirstname + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='last_name'       value='" + vLastname + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='email'           value='" + vEmail + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='phone'           value='" + vPhone + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='item_name_1' value='" + drpMembershipYear.SelectedValue + " " + drpDuesType.SelectedItem.Text + " Membership Dues for Member #: " + Base.GetFormattedNumber(vMemberId) + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='item_number_1' value='" + drpDuesType.SelectedItem.Value + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='amount_1' value='" + FormatNumber(CInt(vAmount), 2) + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='quantity_1' value='1'>")
            'vPayPalRequest.Append("<input type='hidden' name='custom' value='" + CStr(vMemberDuesId) + "'>")
            'vPayPalRequest.Append("<input type='hidden' name='num_cart_items' value='1'>")
            'vPayPalRequest.Append("<script>window.document.frmpaypal.submit();	</script>")
            'vPayPalRequest.Append("</form>")

            ''Create the cookie: cookieMemberDuesId
            'Dim cookieMemberDuesId As New HttpCookie("cookieMemberDuesId")
            ''Set the Cookie value
            'cookieMemberDuesId.Values("cookieMemberDuesId") = vMemberDuesId
            ''Set the Expiry date for one (1) day
            'cookieMemberDuesId.Expires = DateTime.Now.AddHours(1)
            ''Add the Cookie to Browser
            'Response.Cookies.Add(cookieMemberDuesId)

            ''execute the PayPal Request which redirects to PayPal
            'Response.Write(vPayPalRequest)

        Catch ex As Exception
            Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
            Response.Write(ex.Message)
        End Try
    End Sub
End Class