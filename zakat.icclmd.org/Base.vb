﻿Imports System.IO
Imports System.Net.Mail
Imports System.Security.Cryptography

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
    General = 7
  End Enum

#End Region

#Region "Functions"
  Public Shared Function SendEmail(ByVal pTo As String, ByVal pSubject As String, ByVal pBody As String, Optional ByVal pFrom As String = "zakat@icclmd.org", Optional ByVal pIsBodyHtml As Boolean = True) As Boolean
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
      oSMTP.Send(oEmailMessage)
      SendEmail = True
    Catch ex As Exception
      SendEmail = False
    End Try
  End Function

  Public Shared Function GetFormattedPhone(pPhone As String, pMode As enumFormatPhone) As String
    Try
      If pPhone = "" Then
        GetFormattedPhone = ""
      Else
        Select Case pMode
          Case enumFormatPhone.Strip
            Dim nonNumericCharacters As New System.Text.RegularExpressions.Regex("\D")
            pPhone = nonNumericCharacters.Replace(pPhone, String.Empty)
          Case enumFormatPhone.Format
            pPhone = pPhone.Insert(3, "-")
            pPhone = pPhone.Insert(7, "-")
        End Select
        GetFormattedPhone = pPhone
      End If
    Catch ex As Exception
      Return ""
    End Try
  End Function

  Public Shared Function GetFormattedSSN(pSSN As String, pMode As enumFormatSSN) As String
    Try
      If pSSN = "" Then
        GetFormattedSSN = ""
      Else
        Select Case pMode
          Case enumFormatPhone.Strip
            Dim nonNumericCharacters As New System.Text.RegularExpressions.Regex("\D")
            pSSN = nonNumericCharacters.Replace(pSSN, String.Empty)
          Case enumFormatPhone.Format
            pSSN = pSSN.Insert(3, "-")
            pSSN = pSSN.Insert(6, "-")
        End Select
        GetFormattedSSN = pSSN
      End If
    Catch ex As Exception
      Return ""
    End Try
  End Function

  Public Shared Function GetFormattedNumber(pId As Int32) As String
    Try
      Dim vId As String = pId.ToString
      Select Case vId.Length
        Case 1
          GetFormattedNumber = "0000" & vId
        Case 2
          GetFormattedNumber = "000" & vId
        Case 3
          GetFormattedNumber = "00" & vId
        Case 4
          GetFormattedNumber = "0" & vId
        Case 5
          GetFormattedNumber = vId
        Case Else
          GetFormattedNumber = vId
      End Select
    Catch ex As Exception
      Return Nothing
    End Try
  End Function

  Public Shared Function GetAge(ByVal dob As Date) As Int16
    Dim age As Int16 = Today.Year - dob.Year
    If (dob > Today.AddYears(-age)) Then age -= 1
    Return age
  End Function

  Public Shared Function GetPassword() As String
    Dim s As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-:;/.,[]\|{}"
    Dim r As New Random
    Dim sb As New StringBuilder
    For i As Integer = 1 To 8
      Dim idx As Integer = r.Next(0, 87)
      sb.Append(s.Substring(idx, 1))
    Next
    GetPassword = sb.ToString
  End Function

  Public Shared Function CreateUser(pRole As enumRole, pOrganizationId As Int32, pEmail As String, pFirst As String, pLast As String, Optional pMiddle As String = "", Optional pPhone As String = "") As Int32
    'create the user
    Dim oUser As New USER
    Dim vPassword As String = Base.getPassword() 'randomly generate a password
    Dim vPasswordEncrypted As String = Base.EncryptString(vPassword) 'encrypts the randomly generated password
    Dim vUserId As Int32

    Using oDB As New zakatEntities
      'insert information about new user and save to db
      With oUser
        .email = Trim(LCase(pEmail))
        .firstName = pFirst
        .middleName = pMiddle
        .lastName = pLast
        .phone = getFormattedPhone(pPhone, enumFormatPhone.Strip)
        '.password = vPassword
        .passwordEncrypted = vPasswordEncrypted
        .createdOn = Date.Now
        .updatedOn = Date.Now
      End With

      ' Add to db
      oDB.USER.Add(oUser)
      oDB.SaveChanges()

      'set the userId after adding to db
      vUserId = oUser.userId

      'save audit information
      Dim oUserUpdate As USER = (From USER In oDB.USER Where USER.userId = vUserId).First
      With oUserUpdate
        .createdBy = vUserId
        .updatedBy = vUserId
      End With
      ' Add to Memory
      oDB.SaveChanges()

      'set the applicant role for this user
      Dim oUserRole As New USER_ROLE
      With oUserRole
        .userId = vUserId
        .roleId = pRole
        .organizationId = pOrganizationId
      End With
      ' Add to Memory
      oDB.USER_ROLE.Add(oUserRole)
      oDB.SaveChanges()
    End Using
    'send an email to new applicant with the username and password
    Dim vTo As String = pEmail
    Dim vSubject As String = "Online Zakat - New Account"
    Dim vMsgText As New StringBuilder

    vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
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
    vMsgText.Append("301-317-4584<br />")
    vMsgText.Append("7306 Contee Road<br />")
    vMsgText.Append("Laurel, MD 20707<br />")
    vMsgText.Append("<a href='https://zakat.icclmd.org'>https://zakat.icclmd.org</a>")
    vMsgText.Append("</span>")
    Dim vSend As Boolean = Base.sendEmail(vTo, vSubject, vMsgText.ToString)

    CreateUser = vUserId
  End Function

  Public Shared Function EncryptString(ByVal encryptText As String) As String
    Dim bytesBuff As Byte() = Encoding.Unicode.GetBytes(encryptText)
    Dim aAppEnDecryptKey As String = System.Configuration.ConfigurationManager.AppSettings("AppEnDecryptKey")
    Dim key As String = aAppEnDecryptKey
    Using aes__1 As Aes = Aes.Create()
      Dim crypto As New Rfc2898DeriveBytes(key, New Byte() {&H49, &H76, &H61, &H6E, &H20, &H4D, &H65, &H64, &H76, &H65, &H64, &H65, &H76})
      aes__1.Key = crypto.GetBytes(32)
      aes__1.IV = crypto.GetBytes(16)
      Using mStream As New MemoryStream()
        Using cStream As New CryptoStream(mStream, aes__1.CreateEncryptor(), CryptoStreamMode.Write)
          cStream.Write(bytesBuff, 0, bytesBuff.Length)
          cStream.Close()
        End Using
        encryptText = Convert.ToBase64String(mStream.ToArray())
      End Using
    End Using
    Return encryptText
  End Function

  Public Shared Function DecryptString(ByVal decryptText As String) As String
    Dim aAppEnDecryptKey As String = System.Configuration.ConfigurationManager.AppSettings("AppEnDecryptKey")
    Dim key As String = aAppEnDecryptKey
    decryptText = decryptText.Replace(" ", "+")
    Dim bytesBuff As Byte() = Convert.FromBase64String(decryptText)
    Using aes__1 As Aes = Aes.Create()
      Dim crypto As New Rfc2898DeriveBytes(key, New Byte() {&H49, &H76, &H61, &H6E, &H20, &H4D, &H65, &H64, &H76, &H65, &H64, &H65, &H76})
      aes__1.Key = crypto.GetBytes(32)
      aes__1.IV = crypto.GetBytes(16)
      Using mStream As New MemoryStream()
        Using cStream As New CryptoStream(mStream, aes__1.CreateDecryptor(), CryptoStreamMode.Write)
          cStream.Write(bytesBuff, 0, bytesBuff.Length)
          cStream.Close()
        End Using
        decryptText = Encoding.Unicode.GetString(mStream.ToArray())
      End Using
    End Using
    Return decryptText
  End Function

  Public Shared Function CheckPermission(pUserID As Integer, pRoleId As Integer) As Boolean
    Try
      Using oDB As New zakatEntities()
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = pUserID AndAlso USER_ROLE.roleId = pRoleId).Any Then
          Return True
        Else
          Return False
        End If
      End Using
    Catch ex As Exception
      Return False
    End Try
  End Function

#End Region

End Class
