Imports System.IO
Imports System.Net

Public Class Confirm
    Inherits System.Web.UI.Page

    Dim aAppPayPalBaseURL As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalBaseURL")
    'Dim aAppPayPalIdentityTokenPDT As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalIdentityTokenPDT")     'set token from PayPal account

#Region " Web Form Designer Generated Code "
    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then
                Dim vDonationId As Int32 = Session("sDonationId")
                Dim vOrganizationId As Int32 = Session("sOrganizationId")
                Dim vFirstName As String = ""
                Dim vOrgPayPalIdentityTokenPDT As String = ""
                Dim vOrgName As String = ""

                'if either the donation Id or organization Id is not saved from the session, we will have it to get it from the cookie
                If vDonationId = 0 Or vOrganizationId = 0 Then
                    'Fetch the cookieDonation cookie using its Key.
                    'If cookieDonation exists fetch its value.
                    'vDonationId = CInt(If(cookieDonation IsNot Nothing, cookieDonation.Value.Split("="c)(1), 0))
                    If Not Request.Cookies("cookieDonation") Is Nothing Then
                        vDonationId = Request.Cookies("cookieDonation").Value
                        vOrganizationId = Request.Cookies("cookieDonation").Value
                        vDonationId = Request.Cookies("DonationId").Value
                        vOrganizationId = Request.Cookies("OrganizationId").Value
                    End If
                End If

                'if vDonation is still 0, re route to home
                If vDonationId = 0 Then Response.Redirect("/")

                Using oDB As New zakatEntities
                    'set member variables
                    If (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.organizationId = vOrganizationId).Any Then
                        Dim oOrganization As ORGANIZATION = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.organizationId = vOrganizationId).First
                        With oOrganization
                            vOrgPayPalIdentityTokenPDT = .payPalIdentityToken
                            vOrgName = .name
                        End With
                    End If
                End Using


                If vDonationId <> 0 Then
                    Using oDB As New zakatEntities
                        'set member variables
                        If (From DONATION In oDB.DONATION Where DONATION.donationId = vDonationId).Any Then
                            Dim oDonation As DONATION = (From DONATION In oDB.DONATION Where DONATION.donationId = vDonationId).First
                            With oDonation
                                vFirstName = .firstName
                            End With
                        End If
                    End Using

                    'set the values of session variables
                    Session("sDonationId") = vDonationId
                    Session("sUserFirstName") = vFirstName
                Else
                    Session.Clear()
                    Response.Redirect("~/")
                End If

                ''START PAYPAL PROCESSING
                ''=======================
                'set tx to value of tx passed in via Querystring from PayPal
                Dim tx As String = Request.QueryString("tx")
                If tx = Nothing Then Response.Redirect("dues")

                Dim PDTvalidateQuery As String
                Dim strResponse As HttpWebResponse
                Dim vEntireResponse As String
                Dim temp As String
                Dim iParts, sResults(0, 0), aParts(), sParts(), sKey, sValue As String
                Dim i As Integer
                'create variables for the PayPal response
                Dim address_city, address_country, address_country_code, address_name, address_state, address_status, address_street, address_zip, business, charset, custom, first_name, last_name, mc_currency, mc_fee, mc_gross, mc_handling, mc_shipping, num_cart_items, num_offers, payer_email, payer_id, payer_status, payment_date, payment_fee, payment_gross, payment_status, payment_type, pos_transaction_type, protection_eligibility, quantity1, receipt_reference_number, receiver_email, receiver_id, residence_country, store_id, tax, terminal_id, transaction_subject, txn_id, txn_type As String
                txn_id = ""
                custom = ""
                mc_currency = ""
                mc_gross = ""

                'set string = to the cmd value, tx And at that needs to be POSTed back to PayPal to validate the PDT
                PDTvalidateQuery = "cmd=_notify-synch&tx=" & tx & "&at=" & vOrgPayPalIdentityTokenPDT

                'Now we need to POST this info back to PayPal for validation of the PDT
                'Create the request back
                Dim req As HttpWebRequest = CType(WebRequest.Create(aAppPayPalBaseURL), HttpWebRequest)

                'Set values for the request back
                req.Method = "POST"  'set method
                'set content type
                req.ContentType = "application/x-www-form-urlencoded"
                'set length
                req.ContentLength = PDTvalidateQuery.Length

                'Write the request back to PayPal
                Dim stOut As StreamWriter = New StreamWriter(req.GetRequestStream(), Encoding.ASCII)
                stOut.Write(PDTvalidateQuery)
                stOut.Close()

                strResponse = CType(req.GetResponse(), HttpWebResponse)

                'Once we write the stream back To PayPal, we need to read the response.
                Dim IPNResponseStream As Stream = strResponse.GetResponseStream
                Dim encode As Encoding = System.Text.Encoding.GetEncoding("utf-8")
                Dim readStream As New StreamReader(IPNResponseStream, encode)

                'read the response int a String variable "temp"
                temp = readStream.ReadToEnd
                vEntireResponse = temp

                'Check to see if the 1st line of the response was "SUCCESS"
                If Mid(temp, 1, 7) = "SUCCESS" Then

                    'If it Is SUCCESS Then, the code below puts the response In a nice array
                    temp = Mid(temp, 9)
                    sParts = Split(temp, vbLf)
                    iParts = UBound(sParts) - 1
                    ReDim sResults(iParts, 1)

                    For i = 0 To iParts
                        aParts = Split(sParts(i), "=")
                        sKey = aParts(0)
                        sValue = aParts(1)
                        sResults(i, 0) = sKey
                        sResults(i, 1) = sValue

                        'add more case statements here in order to access other returned variables
                        Select Case sKey
                            Case "address_city"
                                address_city = sValue
                            Case "address_country"
                                address_country = sValue
                            Case "address_country_code"
                                address_country_code = sValue
                            Case "address_name"
                                address_name = sValue
                            Case "address_state"
                                address_state = sValue
                            Case "address_status"
                                address_status = sValue
                            Case "address_street"
                                address_street = sValue
                            Case "address_zip"
                                address_zip = sValue
                            Case "business"
                                business = sValue
                            Case "charset"
                                charset = sValue
                            Case "custom"
                                custom = sValue
                            Case "first_name"
                                first_name = sValue
                            Case "last_name"
                                last_name = sValue
                            Case "mc_currency"
                                mc_currency = sValue
                            Case "mc_fee"
                                mc_fee = sValue
                            Case "mc_gross"
                                mc_gross = sValue
                            Case "mc_handling"
                                mc_handling = sValue
                            Case "mc_shipping"
                                mc_shipping = sValue
                            Case "num_cart_items"
                                num_cart_items = sValue
                            Case "num_offers"
                                num_offers = sValue
                            Case "payer_email"
                                payer_email = sValue
                            Case "payer_id"
                                payer_id = sValue
                            Case "payer_status"
                                payer_status = sValue
                            Case "payment_date"
                                payment_date = sValue
                            Case "payment_fee"
                                payment_fee = sValue
                            Case "payment_gross"
                                payment_gross = sValue
                            Case "payment_status"
                                payment_status = sValue
                            Case "payment_type"
                                payment_type = sValue
                            Case "pos_transaction_type"
                                pos_transaction_type = sValue
                            Case "protection_eligibility"
                                protection_eligibility = sValue
                            Case "quantity1"
                                quantity1 = sValue
                            Case "receipt_reference_number"
                                receipt_reference_number = sValue
                            Case "receiver_email"
                                receiver_email = sValue
                            Case "receiver_id"
                                receiver_id = sValue
                            Case "residence_country"
                                residence_country = sValue
                            Case "store_id"
                                store_id = sValue
                            Case "tax"
                                tax = sValue
                            Case "terminal_id"
                                terminal_id = sValue
                            Case "transaction_subject"
                                transaction_subject = sValue
                            Case "txn_id"
                                txn_id = sValue
                            Case "txn_type"
                                txn_type = sValue
                        End Select
                    Next

                    'get the member dues ID
                    vDonationId = custom
                    '=====================
                    'END PAYPAL PROCESSING

                    'record Paypal Payment Data Transfer (PDT) Information and store in DB
                    Using oDB As New zakatEntities
                        If (From DONATION In oDB.DONATION Where DONATION.donationId = vDonationId).Any Then
                            Dim oDonation As DONATION
                            oDonation = (From DONATION In oDB.DONATION Where DONATION.donationId = vDonationId).First
                            With oDonation
                                .isConfirmed = True
                                .donationDate = oDonation.donationDate
                                .paypalPdtIsSuccessful = True
                                .paypalPdtConfirmDate = Date.Now
                                .paypalPdtTransactionId = txn_id
                                .paypalPdtResponse = vEntireResponse

                            End With
                            oDB.SaveChanges()

                            lblFirstName.Text = oDonation.firstName
                            lblDonationId.Text = oDonation.donationId.ToString("00000")
                            lblFullName.Text = oDonation.firstName + " " + oDonation.lastName
                            lblDonationAmount.Text = FormatCurrency(oDonation.amount)
                            lblDonationDate.Text = oDonation.donationDate
                            lblDonationMethod.Text = "PayPal"
                            lblOrgName.Text = vOrgName

                            ''create email to member as a receipt
                            'Dim oMember As USER = (From USER In oDB.USER Where USER.userId = oDonation.userId).First
                            'Dim vTo As String = oDonation.USER.email
                            'Dim vSubject As String = "ICCL - " & oDonation.membershipYear & " Membership Dues Payment"
                            'Dim vMsgText As New StringBuilder


                        End If
                    End Using
                End If
                'kill the session
                Session.Abandon()
                'stay on the page to show receipt
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Private Sub btnProfile_Click(sender As Object, e As EventArgs) Handles btnProfile.Click
        Try
            Dim vMemberId As Int32 = Session("sMemberId")
            Session("sMemberId") = vMemberId
            Response.Redirect("profile")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

End Class