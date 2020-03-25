Imports System.Net.Mail

Public Class Base

#Region "Enumerations"

  Enum enumFormatPhone As Short
    Strip = 1
    Format = 2
  End Enum

  Enum enumFormatSSN As Short
    Strip = 1
    Format = 2
  End Enum

  Enum enumRole As Integer
    Appliciant = 1
    Validator = 2
    Investigator = 3
    Qualifier = 4
    Administrator = 5
    Financier = 6
  End Enum

#End Region

#Region "Functions"

  Public Shared Function sendEmail(ByVal pTo As String, ByVal pSubject As String, ByVal pBody As String, Optional ByVal pFrom As String = "zakat@icclmd.org", Optional ByVal pIsBodyHtml As Boolean = True) As Boolean
    Try
      Dim vMsgText As New StringBuilder

      vMsgText.Append(pBody)

      'create a message
      Dim oEmailMessage As New MailMessage()
      With oEmailMessage
        .From = New MailAddress(pFrom)
        .To.Add(pTo)
        .Subject = pSubject
        .Priority = MailPriority.Normal
        .Body = vMsgText.ToString()
        .IsBodyHtml = pIsBodyHtml
      End With

      'create a connection to the mail server using web.config
      Dim oSMTP As New SmtpClient

      'send the message
      'oSMTP.Send(oEmailMessage)
      sendEmail = True
    Catch ex As Exception
      sendEmail = False
    End Try
  End Function

  Public Shared Function getFormattedPhone(pPhone As String, pMode As enumFormatPhone) As String
    Try
      If pPhone = "" Then
        getFormattedPhone = ""
      Else
        Select Case pMode
          Case enumFormatPhone.Strip
            Dim nonNumericCharacters As New System.Text.RegularExpressions.Regex("\D")
            pPhone = nonNumericCharacters.Replace(pPhone, String.Empty)
          Case enumFormatPhone.Format
            pPhone = pPhone.Insert(3, "-")
            pPhone = pPhone.Insert(7, "-")
        End Select
        getFormattedPhone = pPhone
      End If
    Catch ex As Exception
      Return ""
    End Try
  End Function

  Public Shared Function getFormattedSSN(pSSN As String, pMode As enumFormatSSN) As String
    Try
      If pSSN = "" Then
        getFormattedSSN = ""
      Else
        Select Case pMode
          Case enumFormatPhone.Strip
            Dim nonNumericCharacters As New System.Text.RegularExpressions.Regex("\D")
            pSSN = nonNumericCharacters.Replace(pSSN, String.Empty)
          Case enumFormatPhone.Format
            pSSN = pSSN.Insert(3, "-")
            pSSN = pSSN.Insert(6, "-")
        End Select
        getFormattedSSN = pSSN
      End If
    Catch ex As Exception
      Return ""
    End Try
  End Function

  Public Shared Function getAge(ByVal dob As Date) As Int16
    Dim age As Int16 = Today.Year - dob.Year
    If (dob > Today.AddYears(-age)) Then age -= 1
    Return age
  End Function

  Public Shared Function getPassword() As String
    Dim s As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-:;/.,<>[]\|{}"
    Dim r As New Random
    Dim sb As New StringBuilder
    For i As Integer = 1 To 8
      Dim idx As Integer = r.Next(0, 87)
      sb.Append(s.Substring(idx, 1))
    Next
    getPassword = sb.ToString
  End Function

  Public Shared Function createUser(pRole As enumRole, pEmail As String, pFirst As String, pLast As String, Optional pMiddle As String = "") As Int32
    'create the user
    Dim oUser As New USER
    Dim vPassword As String
    Dim vUserId As Int32

    Using oDB As New zakatEntities
      'insert information about new user and save to db
      With oUser
        .email = LCase(pEmail)
        .firstName = pFirst
        .middleName = pMiddle
        .lastName = pLast
        .password = Base.getPassword()  'randomly generate a password
        .createdBy = oUser.userId
        .createdOn = Date.Now
        .updatedBy = oUser.userId
        .updatedOn = Date.Now
      End With

      ' Add to Memory
      oDB.USER.Add(oUser)
      oDB.SaveChanges()

      'set the userId after adding to db
      vUserId = oUser.userId
      vPassword = oUser.password

      'set the applicant role for this user
      Dim oUserRole As New USER_ROLE
      With oUserRole
        .userId = vUserId
        .roleId = pRole
      End With
      ' Add to Memory
      oDB.USER_ROLE.Add(oUserRole)
      oDB.SaveChanges()

    End Using
    'send an email to new applicant with the username and password
    Dim vTo As String = pEmail
    Dim vSubject As String = "Online Zakat - New Account"
    Dim vMsgText As New StringBuilder

    vMsgText.Append("Assalaamu Alaikum " & pFirst & ",<br /><br />")
    vMsgText.Append("Your Online Zakat account has been created. ")
    vMsgText.Append("This account will be used to provide you with updates regarding the progress of any submitted zakat applications. ")
    vMsgText.Append("You can click or copy/paste the website link below and use the account information provided to log into your account. ")
    vMsgText.Append("While there, change your auto-generated password so that you can remember it more easily:<br /><br />")
    vMsgText.Append("<b>Website Link: </b> <a target='_blank' href='https://zakat.icclmd.org/password?e=" & pEmail & "'>https://zakat.icclmd.org/password?e=" & pEmail & "</a><br />")
    vMsgText.Append("<b>Password:</b>  <i>" & vPassword & "</i><br /><br />")
    vMsgText.Append("If you have issues regarding your account, please don’t hesitate to contact us.<br /><br />")
    vMsgText.Append("Jazakum Allahu Khairan,<br /><br />")
    vMsgText.Append("ICCL Zakat Administrator<br />")
    vMsgText.Append("<a target='_blank' href='mailto:zakat@icclmd.org'>zakat@icclmd.org</a><br />")
    vMsgText.Append("(301) 317-4584")
    vMsgText.Append("7306 Contee Road<br />")
    vMsgText.Append("Laurel, MD 20707<br />")
    vMsgText.Append("<a href='https://zakat.icclmd.org'>https://zakat.icclmd.org</a>")
    Dim vSend As Boolean = Base.sendEmail(vTo, vSubject, vMsgText.ToString)

    createUser = vUserId
  End Function

#End Region

End Class
