Imports System.Net.Mail

Public Class Base

#Region "Enumerations"

  Enum enumFormatPhone As Short
    Strip = 1
    Format = 2
  End Enum

  Enum enumMembershipStatus As Integer
    Pending = 1
    Active = 2
    Inactive = 3
    Late = 4
    Lapsed = 5
  End Enum

  Enum enumDependencyType As Short
    Spouse = 1
    Child = 2
    Parent = 3
    Other = 4
    Self = 5
  End Enum

#End Region

#Region "Functions"

  Public Shared Function sendEmail(ByVal pTo As String, ByVal pSubject As String, ByVal pBody As String, Optional ByVal pFrom As String = "membership@icclmd.org", Optional ByVal pIsBodyHtml As Boolean = True) As Boolean
    Try
      'Dim aAppPath As String = System.Configuration.ConfigurationManager.AppSettings("AppPath")
      'Dim aAppEmailHost As String = System.Configuration.ConfigurationManager.AppSettings("AppEmailHost")
      'Dim aAppEmailUser As String = ""
      'Dim aAppEmailPass As String = ""
      'Select Case pFrom
      '  Case "orders@sayyadfarm.com"
      '    aAppEmailUser = System.Configuration.ConfigurationManager.AppSettings("AppEmailUserOrder")
      '    aAppEmailPass = System.Configuration.ConfigurationManager.AppSettings("AppEmailPassOrder")
      '  Case Else
      '    aAppEmailUser = System.Configuration.ConfigurationManager.AppSettings("AppEmailUserSupport")
      '    aAppEmailPass = System.Configuration.ConfigurationManager.AppSettings("AppEmailPassSupport")
      'End Select
      'Dim aAppEmailPort As Integer = System.Configuration.ConfigurationManager.AppSettings("AppEmailPort")
      'Dim aAppEmailSSL As Boolean = System.Configuration.ConfigurationManager.AppSettings("AppEmailSSL")
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
      sendEmail = True
    Catch ex As Exception
      sendEmail = False
    End Try
  End Function

  'Public Shared Function getIsAdmin(pUserID As Integer, pRole As Integer) As Boolean
  '  Try
  '    Using oDB As New zakatEntities
  '      If (From USER In oDB.USER Where USER.userId = pUserID AndAlso USER.isAdmin = True).Any Then
  '        Return True
  '      Else
  '        Return False
  '      End If
  '    End Using
  '  Catch ex As Exception
  '    Return False
  '  End Try
  'End Function

  Public Shared Function getFormattedPhone(pPhone As String, pMode As enumFormatPhone) As String
    Try
      If pPhone = "" Then
        getFormattedPhone = "None"
      Else
        Select Case pMode
          Case enumFormatPhone.Strip
            Dim nonNumericCharacters As New System.Text.RegularExpressions.Regex("\D")
            pPhone = nonNumericCharacters.Replace(pPhone, String.Empty)
          Case enumFormatPhone.Format
            pPhone = pPhone.Insert(3, ".")
            pPhone = pPhone.Insert(7, ".")
        End Select
        getFormattedPhone = pPhone
      End If
    Catch ex As Exception
      Return ""
    End Try
  End Function

  Public Shared Function getVoterElibility(pHasPaidDues As Boolean, pMemberType As String, pIsHouseldHead As Boolean, pMemberStatus As enumMembershipStatus, pDOB As Date, pMaritalStatus As String, pCitizenship As String, pCounty As String, Optional pDependencyType As String = "Self") As Boolean
    Dim vAge As Int16 = getAge(pDOB)
    If pHasPaidDues Then
      If pMemberType = "General" Then
        If pMemberStatus = enumMembershipStatus.Active Then
          'active, so verify other rules for voting
          If pIsHouseldHead And vAge >= 18 Then
            'head of household and older than 18
            If pCitizenship = "US Citizen" Or pCitizenship = "Permanent Resident" Then
              'citizenship is US or PR = true
              If pCounty = "Other" Then
                'any county other than the 4 = false
                Return False
              Else
                'only 1 of the 4 counties = true
                Return True
              End If
            Else
              'citizenship is not US or PR = false
              Return False
            End If
          Else
            'dependent
            If vAge <= 18 Then
              '18 or younger = false 
              Return False
            ElseIf vAge >= 55 Then
              '55 or older = true
              If pCitizenship = "US Citizen" Or pCitizenship = "Permanent Resident" Then
                'citizenship is US or PR = true
                If pCounty = "Other" Then
                  'any county other than the 4 = false
                  Return False
                Else
                  'only 1 of the 4 counties = true
                  Return True
                End If
              Else
                'citizenship is not US or PR = false
                Return False
              End If
            Else
              If pMaritalStatus = "Single" Then
                'between 18 and 55 and single = true
                If pCitizenship = "US Citizen" Or pCitizenship = "Permanent Resident" Then
                  'citizenship is US or PR = true
                  If pCounty = "Other" Then
                    'any county other than the 4 = false
                    Return False
                  Else
                    'only 1 of the 4 counties = true
                    Return True
                  End If
                Else
                  'citizenship is not US or PR = false
                  Return False
                End If
              ElseIf pMaritalStatus = "Married" And pDependencyType = "Spouse" Then
                'married to the head of household
                If pCitizenship = "US Citizen" Or pCitizenship = "Permanent Resident" Then
                  'citizenship is US or PR = true
                  If pCounty = "Other" Then
                    'any county other than the 4 = false
                    Return False
                  Else
                    'only 1 of the 4 counties = true
                    Return True
                  End If
                Else
                  'citizenship is not US or PR = false
                  Return False
                End If
              Else
                'between 18 and 55 and married = false
                Return False
              End If
            End If
          End If
        Else
          'not active will always return false
          Return False
        End If
      Else
        Return False
      End If
    Else
      Return False
    End If
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

  Public Shared Function GetFormattedId(pMemberId As Int32) As String
    Try
      Dim vMemberId As String = pMemberId.ToString
      Select Case vMemberId.Length
        Case 1
          GetFormattedId = "0000" & vMemberId
        Case 2
          GetFormattedId = "000" & vMemberId
        Case 3
          GetFormattedId = "00" & vMemberId
        Case 4
          GetFormattedId = "0" & vMemberId
        Case 5
          GetFormattedId = vMemberId
        Case Else
          GetFormattedId = vMemberId
      End Select
    Catch ex As Exception
      Return Nothing
    End Try
  End Function

#End Region

End Class
