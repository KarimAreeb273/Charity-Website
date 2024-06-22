Imports System.Net
Imports System.IO

Public Class ConfirmIPN
  Inherits System.Web.UI.Page

  Dim aAppPayPalBaseURL As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalBaseURL")

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
      'Put user code to initialize the page here

      'Read in IPN POST 
      Dim strFormValues As String = Encoding.ASCII.GetString(Request.BinaryRead(Request.ContentLength))
      Dim strNewValue As String

      ' Create the request back   (dev/test-https://www.sandbox.paypal.com/cgi-bin/webscr  or prod-https://ipnpb.paypal.com/cgi-bin/webscr)
      Dim req As HttpWebRequest = CType(WebRequest.Create(aAppPayPalBaseURL), HttpWebRequest)

      ' Set values for the request back
      req.Method = "POST"
      req.ContentType = "application/x-www-form-urlencoded"
      strNewValue = strFormValues + "&cmd=_notify-validate"
      req.ContentLength = strNewValue.Length

      ' Write the request back IPN strings
      Dim stOut As StreamWriter = New StreamWriter(req.GetRequestStream(), Encoding.ASCII)
      stOut.Write(strNewValue)
      stOut.Close()

      'send the request, read the response
      Dim strResponse As HttpWebResponse = CType(req.GetResponse(), HttpWebResponse)
      Dim IPNResponseStream As Stream = strResponse.GetResponseStream
      Dim encode As Encoding = System.Text.Encoding.GetEncoding("utf-8")
      Dim readStream As New StreamReader(IPNResponseStream, encode)

      Dim read(256) As [Char]
      ' Reads 256 characters at a time.

      Dim count As Integer = readStream.Read(read, 0, 256)

      'get the Donation ID from the custom variable
      Dim vDonationId As Int32

      'create variables for the PayPal response
      Dim iParts, sResults(0, 0), aParts(), sParts(), sKey, sValue As String
      Dim i As Integer
      Dim txn_id, custom, address_city, address_country, address_country_code, address_name, address_state, address_status, address_street, address_zip, business, charset, first_name, last_name, mc_currency, mc_fee, mc_gross, mc_handling, mc_shipping, num_cart_items, num_offers, payer_email, payer_id, payer_status, payment_date, payment_fee, payment_gross, payment_status, payment_type, pos_transaction_type, protection_eligibility, receipt_reference_number, receiver_email, receiver_id, residence_country, store_id, tax, terminal_id, transaction_subject, txn_type As String
      mc_currency = ""
      mc_gross = ""
      custom = ""
      txn_id = ""
      payer_email = ""

      'read in the IPN variables:
      sParts = Split(strNewValue, "&")
      iParts = UBound(sParts) - 1
      ReDim sResults(iParts, 1)

      'parse out 
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

      If custom <> "" Then
        vDonationId = CInt(custom)
      End If

      While count > 0
        ' Dumps the 256 characters to a string and displays the string to the console.
        Dim IPNResponse As New [String](read, 0, count)
        count = readStream.Read(read, 0, 256)

        Dim oDonation As DONATION
        Dim aAppPath As String = System.Configuration.ConfigurationManager.AppSettings("AppPath")

        'Determine if Instant Payment Notification (IPN) is successful or not:  IPNResponse="VERIFIED"=success ; IPNResponse="INVALID"=failed
        If IPNResponse = "VERIFIED" Then
          'record Paypal Instant Processing Notification(IPN) Information and store in DB
          Using oDB As New zakatEntities()
            If (From DONATION In oDB.DONATION Where DONATION.donationId = vDonationId).Any Then
              oDonation = (From DONATION In oDB.DONATION Where DONATION.donationId = vDonationId).First

              With oDonation
                .isConfirmed = True
                .paypalIpnIsSuccessful = True
                .paypalIpnConfirmDate = Date.Now
                .paypalIpnTransactionId = txn_id
                .paypalIpnResponse = strNewValue
              End With
              oDB.SaveChanges()

            End If
          End Using
        ElseIf IPNResponse = "INVALID" Then
          'If IPN Is INVALID then record Paypal Instant Data Transfer Information and store in DB
          Using oDB As New zakatEntities()
            If (From DONATION In oDB.DONATION Where DONATION.donationId = vDonationId).Any Then
              oDonation = (From DONATION In oDB.DONATION Where DONATION.donationId = vDonationId).First
              With oDonation
                .isConfirmed = True
                .paypalIpnIsSuccessful = False
                .paypalIpnConfirmDate = Date.Now
                .paypalIpnTransactionId = txn_id
                .paypalIpnResponse = strNewValue
              End With
              oDB.SaveChanges()
            End If
          End Using
        End If
      End While

      'tidy up, close streams
      readStream.Close()
      strResponse.Close()
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

End Class