Public Class ZakatForm
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      If Not IsPostBack Then
        calDOB.EndDate = Date.Now
        Using oDB As New zakatEntities
          'load the state dropdown
          Dim oState As List(Of STATE) = (From STATE In oDB.STATE).ToList
          drpState.DataSource = oState
          drpState.DataTextField = "stateName"
          drpState.DataValueField = "stateAbbr"
          drpState.DataBind()
          drpState.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          drpEmployerState.DataSource = oState
          drpEmployerState.DataTextField = "stateName"
          drpEmployerState.DataValueField = "stateAbbr"
          drpEmployerState.DataBind()
          drpEmployerState.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          drpRefState.DataSource = oState
          drpRefState.DataTextField = "stateName"
          drpRefState.DataValueField = "stateAbbr"
          drpRefState.DataBind()
          drpRefState.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          drpSchoolState.DataSource = oState
          drpSchoolState.DataTextField = "stateName"
          drpSchoolState.DataValueField = "stateAbbr"
          drpSchoolState.DataBind()
          drpSchoolState.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          'load the nationality dropdown
          drpNationality.DataSource = (From NATIONALITY In oDB.NATIONALITY Order By NATIONALITY.name).ToList
          drpNationality.DataTextField = "name"
          drpNationality.DataValueField = "nationalityId"
          drpNationality.DataBind()
          drpNationality.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          'load the organization dropdown
          drpOrganization.DataSource = (From ORGANIZATION In oDB.ORGANIZATION Order By ORGANIZATION.name).ToList
          drpOrganization.DataTextField = "name"
          drpOrganization.DataValueField = "organizationId"
          drpOrganization.DataBind()
          drpOrganization.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          'load the language listbox
          lstLanguages.DataSource = (From LANGUAGE In oDB.LANGUAGE Order By LANGUAGE.name).ToList
          lstLanguages.DataTextField = "name"
          lstLanguages.DataValueField = "languageId"
          lstLanguages.DataBind()

          'load the dependents repeater
          setDependents()
          'load the references repeater
          setReferences()
        End Using
      End If
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
    Try
      Using oDB As New zakatEntities
        'reset validator
        valDuplicateEmail.IsValid = True
        'validate that its not already registered by a user
        If (From USER In oDB.USER Where USER.email = txtEmail.Text).Any Then
          valDuplicateEmail.IsValid = False
          Exit Sub
        End If
        Dim oMember As New USER
        'Dim vPhone As String = Base.getFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip)
        Dim vPassword As String = Base.getPassword()
        'insert information about new user and save to db
        With oMember
          .email = txtEmail.Text
          .firstName = txtFirstName.Text
          .middleName = txtMiddleName.Text
          .lastName = txtLastName.Text
          ''.statusId = Base.enumMembershipStatus.Pending
          .maritalStatus = drpMaritalStatus.SelectedValue
          .password = vPassword
          .phone = Base.getFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip)
          .gender = chkGender.SelectedValue
          .street = txtStreet.Text
          .city = txtCity.Text
          ''.county = drpCounty.SelectedValue
          .stateAbbr = drpState.SelectedValue
          .zip = txtZip.Text
          .dob = CDate(txtDOB.Text)
          .citizenshipStatus = drpCitizenship.SelectedValue
          ''.memberType = "Review"
          ''.isAuthenticated = False
          ''.isAdmin = False
          ''.isHouseholdHead = True
          ''.isVoterEligible = False
          ''.isApproved = False
          ''.hasReference = chkReference.Checked
          ''.referenceName = txtRefName.Text
          ''.referenceEmail = txtRefEmail.Text
          ''.referencePhone = Base.getFormattedPhone(txtRefPhone.Text, Base.enumFormatPhone.Strip)
          .createdOn = Date.Now
          .updatedOn = Date.Now
        End With

        ' Add to Memory
        oDB.USER.Add(oMember)
        oDB.SaveChanges()

        Dim vAdminId As Int32 = Session("sUserId")
        If vAdminId = 0 Then
          'registered by an anonymouse user
          Dim oUser As USER = (From USER In oDB.USER Where USER.email = txtEmail.Text).First
          With oUser
            .createdBy = oUser.userId
            .updatedBy = oUser.userId

            'set session variables
            Session("sUserId") = .userId
            Session("sMemberId") = .userId
            Session("sUserFirstName") = .firstName
            ''Session("sIsAdmin") = .isAdmin
          End With
        Else
          'registered by the administrater
          Dim oNewMember As USER = (From USER In oDB.USER Where USER.email = txtEmail.Text).First
          With oNewMember
            .createdBy = vAdminId
            .updatedBy = vAdminId

            'set session variables
            Session("sMemberId") = .userId
          End With
        End If
        oDB.SaveChanges()

        'create email to new applicant
        Dim vTo As String = txtEmail.Text
        Dim vSubject As String = "Online Zakat - New Application"
        Dim vMsgText As New StringBuilder

        vMsgText.Append("Assalaamu Alaikum " & txtFirstName.Text & ",<br /><br />")
        vMsgText.Append("Your Online Zakat Application has been received. ")
        vMsgText.Append("In addition, click or copy/paste the website link below and use the account information provided to log into your account.  ")
        vMsgText.Append("While there, change your auto-generated password.<br /><br />")
        vMsgText.Append("<b>Website Link:</b> <a target='_blank' href='https://zakat.icclmd.org/password?e=" & txtEmail.Text & "'>https://zakat.icclmd.org/password?e=" & txtEmail.Text & "</a><br />")
        vMsgText.Append("<b>Password:</b>  <i>" & vPassword & "</i><br /><br />")
        vMsgText.Append("If you have issues regarding your account, please don’t hesitate to contact us.<br /><br />")
        vMsgText.Append("Thank you,<br /><br />")
        vMsgText.Append("Online Zakat Administrator<br />")
        vMsgText.Append("<a target='_blank' href='mailto:zakat@icclmd.org'>zakat@icclmd.org</a><br />")
        vMsgText.Append("7306 Contee Road<br />")
        vMsgText.Append("Laurel, MD 20707<br />")
        vMsgText.Append("<a href='https://zakat.icclmd.org'>https://zakat.icclmd.org</a>")
        Dim vSend As Boolean = Base.sendEmail(vTo, vSubject, vMsgText.ToString)

        Response.Redirect("profile")
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtEmail_TextChanged(sender As Object, e As EventArgs) Handles txtEmail.TextChanged
    Try
      Using oDB As New zakatEntities
        'reset validator
        valDuplicateEmail.IsValid = True
        'validate that its not already registered by a user
        If (From USER In oDB.USER Where USER.email = txtEmail.Text).Any Then
          valDuplicateEmail.IsValid = False
          Exit Sub
        End If
      End Using
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function GetDate(ByVal month As Short, ByVal day As Short) As Date
    GetDate = CDate(month.ToString + day.ToString + Today.Year.ToString)
  End Function

  Sub RefershApplicantProgress()
    Try
      Dim v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 As Boolean
      If (txtEmail.Text = "") Then
        v1 = False
      Else
        v1 = True
      End If
      If (txtSocialSecurity.Text = "___-__-____") Then
        v2 = False
      Else
        v2 = True
      End If
      If (txtFirstName.Text = "") Then
        v3 = False
      Else
        v3 = True
      End If
      If (txtMiddleName.Text = "") Then
        v4 = False
      Else
        v4 = True
      End If
      If (txtLastName.Text = "") Then
        v5 = False
      Else
        v5 = True
      End If
      If (chkGender.SelectedIndex = -1) Then
        v6 = False
      Else
        v6 = True
      End If
      If (txtDOB.Text = "") Then
        v7 = False
      Else
        v7 = True
      End If
      If (txtPhone.Text = "(___) ___-____") Then
        v8 = False
      Else
        v8 = True
      End If
      If (txtStreet.Text = "") Then
        v9 = False
      Else
        v9 = True
      End If
      If (txtCity.Text = "") Then
        v10 = False
      Else
        v10 = True
      End If
      If (drpState.SelectedIndex = 0) Then
        v11 = False
      Else
        v11 = True
      End If
      If (txtZip.Text = "") Then
        v12 = False
      Else
        v12 = True
      End If
      If (txtBeganLiving.Text = "") Then
        v13 = False
      Else
        v13 = True
      End If
      If (drpHomeType.SelectedIndex = 0) Then
        v14 = False
      Else
        v14 = True
      End If
      If (drpCitizenship.SelectedIndex = 0) Then
        v15 = False
      Else
        v15 = True
      End If
      If (drpMaritalStatus.SelectedIndex = 0) Then
        v16 = False
      Else
        v16 = True
      End If
      If (drpNationality.SelectedIndex = 0) Then
        v17 = False
      Else
        v17 = True
      End If
      If (txtHomeType.Text = "") Then
        v18 = False
      Else
        v18 = True
      End If

      Dim vProgress As Decimal

      If (v1 = True) Then
        vProgress += 1
      End If
      If (v2 = True) Then
        vProgress += 1
      End If
      If (v3 = True) Then
        vProgress += 1
      End If
      If (v4 = True) Then
        vProgress += 1
      End If
      If (v5 = True) Then
        vProgress += 1
      End If
      If (v6 = True) Then
        vProgress += 1
      End If
      If (v7 = True) Then
        vProgress += 1
      End If
      If (v8 = True) Then
        vProgress += 1
      End If
      If (v9 = True) Then
        vProgress += 1
      End If
      If (v10 = True) Then
        vProgress += 1
      End If
      If (v11 = True) Then
        vProgress += 1
      End If
      If (v12 = True) Then
        vProgress += 1
      End If
      If (v13 = True) Then
        vProgress += 1
      End If
      If (v14 = True) Then
        vProgress += 1
      End If
      If (v15 = True) Then
        vProgress += 1
      End If
      If (v16 = True) Then
        vProgress += 1
      End If
      If (v17 = True) Then
        vProgress += 1
      End If
      If (v18 = True) Then
        vProgress += 1
      End If

      'calculate progress
      vProgress = ((vProgress / 17) * 100)

      'set progress bar attributes
      prgApplicant.Attributes.Add("aria-valuenow", CStr(CInt(vProgress)))
      prgApplicant.Style("width") = CStr(CInt(vProgress)) + "%"
      ltlPercentApplicant.Text = CStr(CInt(vProgress)) + "% Complete"
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtSocialSecurity_TextChanged(sender As Object, e As EventArgs) Handles txtSocialSecurity.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtFirstName_TextChanged(sender As Object, e As EventArgs) Handles txtFirstName.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtMiddleName_TextChanged(sender As Object, e As EventArgs) Handles txtMiddleName.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtLastName_TextChanged(sender As Object, e As EventArgs) Handles txtLastName.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub chkGender_SelectedIndexChanged(sender As Object, e As EventArgs) Handles chkGender.SelectedIndexChanged
    Try
      If chkGender.SelectedValue = "Female" And drpMaritalStatus.SelectedValue = "Married" Then
        pnlHusbandInformation.Visible = True
      Else
        pnlHusbandInformation.Visible = False
      End If
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtDOB_TextChanged(sender As Object, e As EventArgs) Handles txtDOB.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtPhone_TextChanged(sender As Object, e As EventArgs) Handles txtPhone.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtStreet_TextChanged(sender As Object, e As EventArgs) Handles txtStreet.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtCity_TextChanged(sender As Object, e As EventArgs) Handles txtCity.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpState_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpState.SelectedIndexChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtZip_TextChanged(sender As Object, e As EventArgs) Handles txtZip.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtBeganLiving_TextChanged(sender As Object, e As EventArgs) Handles txtBeganLiving.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpHomeType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpHomeType.SelectedIndexChanged
    Try
      If (drpHomeType.SelectedItem.Text = "Other") Then
        txtHomeType.Enabled = True
        valHomeType.Enabled = True
      Else
        txtHomeType.Enabled = False
        valHomeType.Enabled = False
      End If
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpCitizenship_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpCitizenship.SelectedIndexChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpMaritalStatus_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpMaritalStatus.SelectedIndexChanged
    Try
      If chkGender.SelectedValue = "Female" And drpMaritalStatus.SelectedValue = "Married" Then
        pnlHusbandInformation.Visible = True
      Else
        pnlHusbandInformation.Visible = False
      End If
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtHomeType_TextChanged(sender As Object, e As EventArgs) Handles txtHomeType.TextChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpNationality_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpNationality.SelectedIndexChanged
    Try
      RefershApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub chkInsurance_SelectedIndexChanged(sender As Object, e As EventArgs) Handles chkInsurance.SelectedIndexChanged
    Try
      If chkInsurance.SelectedValue = "Yes" Then
        pnlInsurance.Visible = True
      Else
        pnlInsurance.Visible = False
      End If
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function getAge(ByVal dob As Date) As Int16
    getAge = Base.getAge(dob)
  End Function

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    getFormattedPhone = Base.getFormattedPhone(pPhone, Base.enumFormatPhone.Format)
  End Function

  Public Sub btnDeleteDependent_Click(sender As Object, e As System.EventArgs) 'Handles btnDelete.Click
    Try
      'go home if no session/user
      'Dim vUserId As Int32 = Session("sUserId")
      'If vUserId = 0 Then Response.Redirect("default")

      Dim vDependentId As Int32 = sender.CommandArgument
      Using oDB As New zakatEntities
        Dim oDependent As DEPDENDENT = (From DEPDENDENT In oDB.DEPDENDENT Where DEPDENDENT.depdendentId = vDependentId).First
        oDB.DEPDENDENT.Remove(oDependent)
        oDB.SaveChanges()
      End Using
      'refresh the dependents list
      setDependents()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Sub btnDeleteReference_Click(sender As Object, e As System.EventArgs) 'Handles btnDelete.Click
    Try
      'go home if no session/user
      'Dim vUserId As Int32 = Session("sUserId")
      'If vUserId = 0 Then Response.Redirect("default")

      Dim vReferenceId As Int32 = sender.CommandArgument
      Using oDB As New zakatEntities
        Dim oReference As REFERENCE = (From REFERENCE In oDB.REFERENCE Where REFERENCE.referenceId = vReferenceId).First
        oDB.REFERENCE.Remove(oReference)
        oDB.SaveChanges()
      End Using
      'refresh the references list
      setReferences()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setDependents()
    Try
      Using oDB As New zakatEntities
        Dim vUserId As Int32 = Session("sUserId")
        'update repeater
        Dim oDependent_List As List(Of DEPDENDENT) = (From DEPDENDENT In oDB.DEPDENDENT Where DEPDENDENT.userId = vUserId).ToList
        rptDependents.DataSource = oDependent_List
        rptDependents.DataBind()
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setReferences()
    Try
      Using oDB As New zakatEntities
        Dim vUserId As Int32 = Session("sUserId")
        'update repeater
        Dim oReference_List As List(Of REFERENCE) = (From REFERENCE In oDB.REFERENCE Where REFERENCE.userId = vUserId).ToList
        rptReferences.DataSource = oReference_List
        rptReferences.DataBind()
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpOrganization_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpOrganization.SelectedIndexChanged
    Try
      Using oDB As New zakatEntities
        If drpOrganization.SelectedValue = "(Select One)" Then
          accZakat.Enabled = False
        Else
          accZakat.Enabled = True
        End If
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnAddLanguage_Click(sender As Object, e As EventArgs) Handles btnAddLanguage.Click
    Try
      'if nothing is selected in the lstLanguages listbox, stop
      If lstLanguages.SelectedIndex = -1 Then Exit Sub

      'get the selected language:
      Dim vSpokenLanguageValue As Int32 = lstLanguages.SelectedItem.Value
      Dim vSpokenLanguageText As String = lstLanguages.SelectedItem.Text

      If Not lstSpoken.Items.Contains(New ListItem(vSpokenLanguageText, vSpokenLanguageValue)) Then
        lstSpoken.Items.Add(New ListItem(vSpokenLanguageText, vSpokenLanguageValue))
      End If

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnDeleteLanguage_Click(sender As Object, e As EventArgs) Handles btnDeleteLanguage.Click
    Try
      'if nothing is selected in the lstLanguages listbox, stop
      If lstSpoken.SelectedIndex = -1 Then Exit Sub

      'get the selected language:
      Dim vSpokenLanguageValue As Int32 = lstSpoken.SelectedItem.Value
      Dim vSpokenLanguageText As String = lstSpoken.SelectedItem.Text

      lstSpoken.Items.Remove(New ListItem(vSpokenLanguageText, vSpokenLanguageValue))
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnAddCertification_Click(sender As Object, e As EventArgs) Handles btnAddCertification.Click
    Try
      'if nothing is selected in the lstLanguages listbox, stop
      If txtSkillCertification.Text = "" Then Exit Sub

      'get the selected language:

      If Not lstSkillCertification.Items.Contains(New ListItem(txtSkillCertification.Text)) Then
        lstSkillCertification.Items.Add(New ListItem(txtSkillCertification.Text))
        txtSkillCertification.Text = ""
      End If

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnRemoveCertification_Click(sender As Object, e As EventArgs) Handles btnRemoveCertification.Click
    Try
      'if nothing is selected in the lstLanguages listbox, stop
      If lstSkillCertification.SelectedIndex = -1 Then Exit Sub

      'get the selected language:
      Dim vSkillCertificationValue As String = lstSkillCertification.SelectedItem.Value
      Dim vSkillCertificationText As String = lstSkillCertification.SelectedItem.Text

      lstSkillCertification.Items.Remove(New ListItem(vSkillCertificationText, vSkillCertificationValue))
      txtSkillCertification.Text = ""
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtValueAssistance_TextChanged(sender As Object, e As EventArgs) Handles txtValueAssistance.TextChanged
    Try
      'if nothing is selected in the lstLanguages listbox then exit sub
      If txtValueAssistance.Text = "" Then Exit Sub
      'if not a number then exit sub
      If Not IsNumeric(txtValueAssistance.Text) Then Exit Sub
      'if the value equal zero then make the who assisted text box disabled along with the validation otherwise do opposite
      If CInt(txtValueAssistance.Text) = 0 Then
        txtWhoAssisted.Enabled = False
        valWhoAssisted.Enabled = False
      Else
        txtWhoAssisted.Enabled = True
        valWhoAssisted.Enabled = True
      End If
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub
End Class