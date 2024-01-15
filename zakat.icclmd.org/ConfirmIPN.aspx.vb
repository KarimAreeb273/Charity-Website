Imports System.Net
Imports System.IO

Public Class ConfirmIPN
    Inherits System.Web.UI.Page

    '  Dim aAppPayPalBaseURL As String = System.Configuration.ConfigurationManager.AppSettings("AppPayPalBaseURL")

    '#Region " Web Form Designer Generated Code "
    '  'This call is required by the Web Form Designer.
    '  <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    '  End Sub

    '  Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
    '    'CODEGEN: This method call is required by the Web Form Designer
    '    'Do not modify it using the code editor.
    '    InitializeComponent()
    '  End Sub
    '#End Region

    '  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    Try
    '      'Put user code to initialize the page here

    '      'Read in IPN POST 
    '      Dim strFormValues As String = Encoding.ASCII.GetString(Request.BinaryRead(Request.ContentLength))
    '      Dim strNewValue As String

    '      ' Create the request back   (dev/test-https://www.sandbox.paypal.com/cgi-bin/webscr  or prod-https://ipnpb.paypal.com/cgi-bin/webscr)
    '      Dim req As HttpWebRequest = CType(WebRequest.Create(aAppPayPalBaseURL), HttpWebRequest)

    '      ' Set values for the request back
    '      req.Method = "POST"
    '      req.ContentType = "application/x-www-form-urlencoded"
    '      strNewValue = strFormValues + "&cmd=_notify-validate"
    '      req.ContentLength = strNewValue.Length

    '      ' Write the request back IPN strings
    '      Dim stOut As StreamWriter = New StreamWriter(req.GetRequestStream(), Encoding.ASCII)
    '      stOut.Write(strNewValue)
    '      stOut.Close()

    '      'send the request, read the response
    '      Dim strResponse As HttpWebResponse = CType(req.GetResponse(), HttpWebResponse)
    '      Dim IPNResponseStream As Stream = strResponse.GetResponseStream
    '      Dim encode As Encoding = System.Text.Encoding.GetEncoding("utf-8")
    '      Dim readStream As New StreamReader(IPNResponseStream, encode)

    '      Dim read(256) As [Char]
    '      ' Reads 256 characters at a time.

    '      Dim count As Integer = readStream.Read(read, 0, 256)

    '      'get the Member Dues ID from the custom variable
    '      Dim vMemberDuesId As Int32

    '      'create variables for the PayPal response
    '      Dim iParts, sResults(0, 0), aParts(), sParts(), sKey, sValue As String
    '      Dim i As Integer
    '      Dim txn_id, custom, address_city, address_country, address_country_code, address_name, address_state, address_status, address_street, address_zip, business, charset, first_name, last_name, mc_currency, mc_fee, mc_gross, mc_handling, mc_shipping, num_cart_items, num_offers, payer_email, payer_id, payer_status, payment_date, payment_fee, payment_gross, payment_status, payment_type, pos_transaction_type, protection_eligibility, receipt_reference_number, receiver_email, receiver_id, residence_country, store_id, tax, terminal_id, transaction_subject, txn_type As String
    '      mc_currency = ""
    '      mc_gross = ""
    '      custom = ""
    '      txn_id = ""
    '      payer_email = ""

    '      'read in the IPN variables:
    '      sParts = Split(strNewValue, "&")
    '      iParts = UBound(sParts) - 1
    '      ReDim sResults(iParts, 1)

    '      'parse out 
    '      For i = 0 To iParts
    '        aParts = Split(sParts(i), "=")
    '        sKey = aParts(0)
    '        sValue = aParts(1)
    '        sResults(i, 0) = sKey
    '        sResults(i, 1) = sValue

    '        'add more case statements here in order to access other returned variables
    '        Select Case sKey
    '          Case "address_city"
    '            address_city = sValue
    '          Case "address_country"
    '            address_country = sValue
    '          Case "address_country_code"
    '            address_country_code = sValue
    '          Case "address_name"
    '            address_name = sValue
    '          Case "address_state"
    '            address_state = sValue
    '          Case "address_status"
    '            address_status = sValue
    '          Case "address_street"
    '            address_street = sValue
    '          Case "address_zip"
    '            address_zip = sValue
    '          Case "business"
    '            business = sValue
    '          Case "charset"
    '            charset = sValue
    '          Case "custom"
    '            custom = sValue
    '          Case "first_name"
    '            first_name = sValue
    '          Case "last_name"
    '            last_name = sValue
    '          Case "mc_currency"
    '            mc_currency = sValue
    '          Case "mc_fee"
    '            mc_fee = sValue
    '          Case "mc_gross"
    '            mc_gross = sValue
    '          Case "mc_handling"
    '            mc_handling = sValue
    '          Case "mc_shipping"
    '            mc_shipping = sValue
    '          Case "num_cart_items"
    '            num_cart_items = sValue
    '          Case "num_offers"
    '            num_offers = sValue
    '          Case "payer_email"
    '            payer_email = sValue
    '          Case "payer_id"
    '            payer_id = sValue
    '          Case "payer_status"
    '            payer_status = sValue
    '          Case "payment_date"
    '            payment_date = sValue
    '          Case "payment_fee"
    '            payment_fee = sValue
    '          Case "payment_gross"
    '            payment_gross = sValue
    '          Case "payment_status"
    '            payment_status = sValue
    '          Case "payment_type"
    '            payment_type = sValue
    '          Case "pos_transaction_type"
    '            pos_transaction_type = sValue
    '          Case "protection_eligibility"
    '            protection_eligibility = sValue
    '          Case "receipt_reference_number"
    '            receipt_reference_number = sValue
    '          Case "receiver_email"
    '            receiver_email = sValue
    '          Case "receiver_id"
    '            receiver_id = sValue
    '          Case "residence_country"
    '            residence_country = sValue
    '          Case "store_id"
    '            store_id = sValue
    '          Case "tax"
    '            tax = sValue
    '          Case "terminal_id"
    '            terminal_id = sValue
    '          Case "transaction_subject"
    '            transaction_subject = sValue
    '          Case "txn_id"
    '            txn_id = sValue
    '          Case "txn_type"
    '            txn_type = sValue
    '        End Select
    '      Next

    '      If custom <> "" Then
    '        vMemberDuesId = CInt(custom)
    '      End If

    '      While count > 0
    '        ' Dumps the 256 characters to a string and displays the string to the console.
    '        Dim IPNResponse As New [String](read, 0, count)
    '        count = readStream.Read(read, 0, 256)

    '        Dim oMemberDues As MEMBER_DUES
    '        Dim aAppPath As String = System.Configuration.ConfigurationManager.AppSettings("AppPath")

    '        'Determine if Instant Payment Notification (IPN) is successful or not:  IPNResponse="VERIFIED"=success ; IPNResponse="INVALID"=failed
    '        If IPNResponse = "VERIFIED" Then
    '          ' if IPN response was VERIFIED, perform VERIFIED handling
    '          Dim vMemberId As Integer

    '          'record Paypal Instant Processing Notification(IPN) Information and store in DB
    '          Using oDB As New membersEntities()
    '            If (From MEMBER_DUES In oDB.MEMBER_DUES Where MEMBER_DUES.memberDuesId = vMemberDuesId).Any Then
    '              oMemberDues = (From MEMBER_DUES In oDB.MEMBER_DUES Where MEMBER_DUES.memberDuesId = vMemberDuesId).First

    '              With oMemberDues
    '                .isConfirmed = True
    '                '.paymentDate === do not update because the date may not be today
    '                .paypalIpnIsSuccessful = True
    '                .paypalIpnConfirmDate = Date.Now
    '                .paypalIpnTransactionId = txn_id
    '                .paypalIpnResponse = strNewValue
    '                .recordedBy = 1  'admin
    '                vMemberId = .userId
    '              End With
    '              oDB.SaveChanges()

    '              'send email if the member dues payment has NOT been confirmed meaning an email was never sent
    '              If oMemberDues.isConfirmed = False Then
    '                Dim oUser As USER
    '                Dim vFirst As String
    '                Dim vMiddle As String
    '                Dim vLast As String
    '                If oMemberDues.recordedBy = oMemberDues.userId Then
    '                  vFirst = oMemberDues.USER.firstName
    '                  vMiddle = oMemberDues.USER.middleName
    '                  vLast = oMemberDues.USER.lastName
    '                Else
    '                  oUser = (From USER In oDB.USER Where USER.userId = 1).First
    '                  vFirst = oUser.firstName
    '                  vMiddle = oUser.middleName
    '                  vLast = oUser.lastName
    '                End If
    '                Dim vTo As String = IIf(oMemberDues.userId = 0, "", oMemberDues.USER.email)
    '                Dim vSubject As String = "ICCL - " & oMemberDues.membershipYear & " Membership Dues Payment"
    '                Dim vMsgText As New StringBuilder

    '                vMsgText.Append("Assalaamu Alaikum " & oMemberDues.USER.firstName & ",<br /><br />")
    '                vMsgText.Append("Your ICCL Membership Dues have been received for membership year: <b>" & oMemberDues.membershipYear & "</b>. Please ensure that you keep this email as a receipt.<br /><br />")
    '                vMsgText.Append("<b>Member #:</b> " & Base.GetFormattedNumber(oMemberDues.userId) & "<br />")
    '                vMsgText.Append("<b>Member Name:</b> " & oMemberDues.USER.firstName & " " & oMemberDues.USER.middleName & " " & oMemberDues.USER.lastName & "<br />")
    '                vMsgText.Append("<b>Membership Type:</b> " & oMemberDues.DUES_TYPE.name & "<br />")
    '                vMsgText.Append("<b>Membership Year:</b> " & oMemberDues.membershipYear & "<br />")
    '                vMsgText.Append("<b>Payment Amount:</b> " & FormatCurrency(oMemberDues.paymentAmount) & "<br />")
    '                vMsgText.Append("<b>Payment Method:</b> " & oMemberDues.paymentMethod & "<br />")
    '                vMsgText.Append("<b>Payment Date:</b> " & oMemberDues.paymentDate & "<br />")
    '                vMsgText.Append("<b>Payment Reference:</b> " & oMemberDues.paymentReference & "<br />")
    '                vMsgText.Append("<b>Recorded By:</b> " & vFirst + " " + IIf(vMiddle = "", "", vMiddle + " ") + " " + vLast & "<br /><br />")
    '                vMsgText.Append("Please note that ICCL Membership Dues are not tax deductible.  If you have issues regarding your account, please don’t hesitate to contact us.<br /><br />")
    '                vMsgText.Append("Thank you,<br /><br />")
    '                vMsgText.Append("ICCL Membership Administrator<br />")
    '                vMsgText.Append("<a target='_blank' href='mailto:membership@icclmd.org'>membership@icclmd.org</a><br />")
    '                vMsgText.Append("7306 Contee Road<br />")
    '                vMsgText.Append("Laurel, MD 20707<br />")
    '                vMsgText.Append("<a target='_blank' href='https://membership.icclmd.org'>https://membership.icclmd.org</a>")
    '                Dim vSend As Boolean = Base.sendEmail(vTo, vSubject, vMsgText.ToString)
    '              End If
    '            End If
    '          End Using
    '        ElseIf IPNResponse = "INVALID" Then
    '          'If IPN Is INVALID then record Paypal Insta Data Transfer Information and store in DB
    '          Using oDB As New membersEntities()
    '            If (From MEMBER_DUES In oDB.MEMBER_DUES Where MEMBER_DUES.memberDuesId = vMemberDuesId).Any Then
    '              oMemberDues = (From MEMBER_DUES In oDB.MEMBER_DUES Where MEMBER_DUES.memberDuesId = vMemberDuesId).First
    '              With oMemberDues
    '                .isConfirmed = True
    '                .paypalIpnIsSuccessful = False
    '                .paypalIpnConfirmDate = Date.Now
    '                .paypalIpnTransactionId = txn_id
    '                .paypalIpnResponse = strNewValue
    '                .recordedBy = 1  'admin
    '              End With
    '              oDB.SaveChanges()
    '            End If
    '          End Using
    '        End If
    '      End While

    '      'tidy up, close streams
    '      readStream.Close()
    '      strResponse.Close()
    '    Catch ex As Exception
    '      Console.Write(ex.Message)
    '    End Try
    '  End Sub

End Class