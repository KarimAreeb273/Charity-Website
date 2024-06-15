Public Class Profile
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      If Not IsPostBack Then
        calDOB.EndDate = Date.Now
        Dim vApplicantId As Integer
        If vApplicantId = 0 Then
          If Request.QueryString("a") <> Nothing Then
            vApplicantId = Request.QueryString("a")
            If vApplicantId <> 0 Then
              'since the applicant id is set, we need to also set the corresponding session variable
              Session("sApplicantId") = vApplicantId
            End If
          End If
        End If
        If vApplicantId = 0 Then
          If Session("sApplicantId") <> Nothing Then
            vApplicantId = Session("sApplicantId")
          End If
        End If
        Dim vIsAdministrator As Boolean = Session("sIsAdministrator")
        If vIsAdministrator Then
          pnlPassword.Visible = True
          ManageValidations(False)
        Else
          pnlPassword.Visible = False
          ManageValidations(True)
        End If

        If vApplicantId = 0 Then Response.Redirect("/", False)

        Using oDB As New zakatEntities
          'load the state dropdown
          Dim oState As List(Of STATE) = (From STATE In oDB.STATE Order By STATE.stateName).ToList
          drpState.DataSource = oState
          drpState.DataTextField = "stateName"
          drpState.DataValueField = "stateAbbr"
          drpState.DataBind()

          drpSchoolState.DataSource = oState
          drpSchoolState.DataTextField = "stateName"
          drpSchoolState.DataValueField = "stateAbbr"
          drpSchoolState.DataBind()

          'load the nationality dropdown
          drpNationality.DataSource = (From NATIONALITY In oDB.NATIONALITY Order By NATIONALITY.name).ToList
          drpNationality.DataTextField = "name"
          drpNationality.DataValueField = "nationalityId"
          drpNationality.DataBind()

          'load the language listbox
          lstLanguages.DataSource = (From LANGUAGE In oDB.LANGUAGE Order By LANGUAGE.name).ToList
          lstLanguages.DataTextField = "name"
          lstLanguages.DataValueField = "languageId"
          lstLanguages.DataBind()

          'load the language listbox
          drpSchoolCountry.DataSource = (From COUNTRY In oDB.COUNTRY Order By COUNTRY.name).ToList
          drpSchoolCountry.DataTextField = "name"
          drpSchoolCountry.DataValueField = "countryId"
          drpSchoolCountry.DataBind()

          If vApplicantId <> 0 Then
            'load user data into the form
            Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vApplicantId).First
            With oUser
              txtEmail.Text = .email
              txtEmail.Enabled = False
              If .socialSecurityNumberEncrypted IsNot Nothing Then
                txtSocialSecurity1.Text = Left(Base.decryptString(.socialSecurityNumberEncrypted), 3)
                txtSocialSecurity2.Text = Mid(Base.decryptString(.socialSecurityNumberEncrypted), 4, 2)
                txtSocialSecurity3.Text = Right(Base.decryptString(.socialSecurityNumberEncrypted), 4)
              End If
              lblPageHeaderUserFullName.Text = .firstName + " " + .middleName + " " + .lastName
              txtFirstName.Text = .firstName
              txtMiddleName.Text = .middleName
              txtLastName.Text = .lastName
              txtDOB.Text = IIf(IsDate(.dob), .dob, "")
              txtPhone1.Text = Left(.phone, 3)
              txtPhone2.Text = Mid(.phone, 4, 3)
              txtPhone3.Text = Right(.phone, 4)
              chkGender.SelectedValue = .gender
              drpMaritalStatus.SelectedValue = .maritalStatus
              txtStreet.Text = .street
              txtCity.Text = .city
              drpState.SelectedValue = .stateAbbr
              txtZip.Text = .zip
              txtBeganLiving.Text = IIf(IsDate(.beganLivingDate), .beganLivingDate, "")
              drpHomeType.SelectedValue = .homeType
              If (drpHomeType.SelectedValue = "Other") Then
                txtHomeType.Enabled = True
                litHomeType.Visible = True
              Else
                txtHomeType.Enabled = False
                litHomeType.Visible = False
              End If
              txtHomeType.Text = .homeTypeOther
              If .nationalityId IsNot Nothing Then
                drpNationality.SelectedValue = .nationalityId
              End If
              drpCitizenship.SelectedValue = .citizenshipStatus
              drpHighestEducation.SelectedValue = .highestEducationCompleted
              If .isInternationalSchool IsNot Nothing Then
                chkIsInternational.Checked = .isInternationalSchool
              End If
              txtSchoolName.Text = .schoolName
              txtSchoolCity.Text = .schoolCity
              If .isInternationalSchool Then
                pnlDomestic.Visible = False
                pnlInternational.Visible = True
              Else
                pnlDomestic.Visible = True
                pnlInternational.Visible = False
              End If
              txtSchoolStreet.Text = .schoolStreet
              If .schoolCountryId IsNot Nothing Then
                drpSchoolCountry.SelectedValue = .schoolCountryId
              End If
              drpSchoolState.SelectedValue = .schoolStateAbbr
              txtSchoolZip.Text = .schoolZip
              txtHusbandFirstName.Text = .husbandFirstName
              txtHusbandMiddleName.Text = .husbandMiddleName
              txtHusbandLastName.Text = .husbandLastName
              txtHusbandEmail.Text = .husbandEmail
              txtHusbandPhone.Text = Base.getFormattedPhone(.husbandPhone, Base.enumFormatPhone.Format)
              txtMasjidName.Text = .primaryMasjidName
              txtMasjidPhone1.Text = Left(.primaryMasjidPhone, 3)
              txtMasjidPhone2.Text = Mid(.primaryMasjidPhone, 4, 3)
              txtMasjidPhone3.Text = Right(.primaryMasjidPhone, 4)
              If .passwordEncrypted IsNot Nothing Then
                txtPassword.Text = Base.decryptString(.passwordEncrypted)
              End If
            End With

            If Session("sUserId") = oUser.userId Then
              Session("sUserFirstName") = oUser.firstName
            End If
            'add saved languages to the spoken listbox
            If ((From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vApplicantId).Any) Then
              'there are languages so add in the form
              Dim oUserLanguages As List(Of USER_LANGUAGE) = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vApplicantId).ToList
              For Each item In oUserLanguages
                'obtain the language id from the list and add from the db
                lstSpoken.Items.Add(New ListItem(item.LANGUAGE.name, item.LANGUAGE.languageId))
              Next
            End If

            'add saved certifications to the skills/certs listbox
            If ((From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vApplicantId).Any) Then
              'there are skills/certs so add in the form
              Dim oCertSkills As List(Of CERTIFICATION_SKILL) = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vApplicantId).ToList
              For Each item In oCertSkills
                'obtain the skills/certs from the list and add from the db
                lstSkillCertification.Items.Add(New ListItem(item.certificationSkill, item.certificationSkillId))
              Next
            End If
          End If
        End Using
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
    Try
      If (txtSocialSecurity1.Text = "" Or txtSocialSecurity2.Text = "" Or txtSocialSecurity3.Text = "") Then
        valSocialSecurity.IsValid = False
      End If
      If (txtPhone1.Text = "" Or txtPhone2.Text = "" Or txtPhone3.Text = "") Then
        valPhone.IsValid = False
      End If
      If (txtMasjidPhone1.Text = "" Or txtMasjidPhone2.Text = "" Or txtMasjidPhone3.Text = "") Then
        valMasjidPhone.IsValid = False
      End If
      Dim vUserId As Int32 = Session("sUserId")
      Dim vApplicantId As Int32 = Session("sApplicantId")

      Using oDB As New zakatEntities
        'check if the user exists or not, if not, exit sub
        If Not (From USER In oDB.USER Where USER.userId = vUserId).Any Then
          'verify user is in session or exit sub
          Exit Sub
        End If

        'save user data
        Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vApplicantId).First
        With oUser
          Dim vSocialSecurityNumber As String = txtSocialSecurity1.Text + txtSocialSecurity2.Text + txtSocialSecurity3.Text
          .socialSecurityNumberEncrypted = Base.encryptString(vSocialSecurityNumber)
          If txtPassword.Text <> "" Then
            .passwordEncrypted = Base.encryptString(LTrim(RTrim(txtPassword.Text)))
          End If
          .firstName = txtFirstName.Text
          .middleName = txtMiddleName.Text
          .lastName = txtLastName.Text
          If txtDOB.Text <> "" Then
            .dob = IIf(IsDate(txtDOB.Text), CDate(txtDOB.Text), Nothing)
          End If
          Dim vPhone As String = txtPhone1.Text + txtPhone2.Text + txtPhone3.Text
          .phone = Base.getFormattedPhone(vPhone, Base.enumFormatPhone.Strip)
          .gender = chkGender.SelectedValue
          .maritalStatus = drpMaritalStatus.SelectedValue
          .street = txtStreet.Text
          .city = txtCity.Text
          .stateAbbr = drpState.SelectedValue
          .zip = txtZip.Text
          If txtBeganLiving.Text <> "" Then
            .beganLivingDate = IIf(IsDate(txtBeganLiving.Text), CDate(txtBeganLiving.Text), Nothing)
          End If
          .homeType = drpHomeType.SelectedValue
          .homeTypeOther = txtHomeType.Text
          .nationalityId = drpNationality.SelectedValue
          .citizenshipStatus = drpCitizenship.SelectedValue
          .highestEducationCompleted = drpHighestEducation.SelectedValue
          .isInternationalSchool = chkIsInternational.Checked
          .schoolName = txtSchoolName.Text
          .schoolStreet = txtSchoolStreet.Text
          .schoolCity = txtSchoolCity.Text
          .schoolStateAbbr = drpSchoolState.SelectedValue
          .schoolCountryId = drpSchoolCountry.SelectedValue
          .schoolZip = txtSchoolZip.Text
          .husbandFirstName = txtHusbandFirstName.Text
          .husbandMiddleName = txtHusbandMiddleName.Text
          .husbandLastName = txtHusbandLastName.Text
          .husbandEmail = txtHusbandEmail.Text
          .husbandPhone = Base.getFormattedPhone(txtHusbandPhone.Text, Base.enumFormatPhone.Strip)
          .primaryMasjidName = txtMasjidName.Text
          Dim vMasjidPhone As String = txtMasjidPhone1.Text + txtMasjidPhone2.Text + txtMasjidPhone3.Text
          .primaryMasjidPhone = Base.getFormattedPhone(vMasjidPhone, Base.enumFormatPhone.Strip)
          .updatedBy = vApplicantId
          .updatedOn = Date.Now
        End With

        ' Add to Memory
        oDB.SaveChanges()

        'delete all saved languages
        If ((From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vApplicantId).Any) Then
          'there are languages so delete them and read just add those in the form
          Dim oUserLanguages As List(Of USER_LANGUAGE) = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vApplicantId).ToList
          For Each item In oUserLanguages
            'obtain the language id from the list and delete from the db
            Dim oUserLanguage As USER_LANGUAGE = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userLanguageId = item.userLanguageId).First
            oDB.USER_LANGUAGE.Remove(oUserLanguage)
            oDB.SaveChanges()
          Next
        End If

        'save languages in the form
        For Each item In lstSpoken.Items

          Dim oUserLanguage As New USER_LANGUAGE
          With oUserLanguage
            .userId = vApplicantId
            .languageId = CInt(item.Value)
          End With
          oDB.USER_LANGUAGE.Add(oUserLanguage)
          oDB.SaveChanges()
        Next

        'delete all certs/skills
        If ((From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vApplicantId).Any) Then
          'there are languages so delete them and read just add those in the form
          Dim oCertSkills As List(Of CERTIFICATION_SKILL) = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vApplicantId).ToList
          For Each item In oCertSkills
            'obtain the language id from the list and delete from the db
            Dim oCertSkill As CERTIFICATION_SKILL = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.certificationSkillId = item.certificationSkillId).First
            oDB.CERTIFICATION_SKILL.Remove(oCertSkill)
            oDB.SaveChanges()
          Next
        End If

        'save certs/skills in the form
        For Each item In lstSkillCertification.Items
          Dim oCertSkill As New CERTIFICATION_SKILL
          With oCertSkill
            .userId = vApplicantId
            .certificationSkill = item.Text
          End With
          oDB.CERTIFICATION_SKILL.Add(oCertSkill)
          oDB.SaveChanges()
        Next
      End Using

      'refresh page
      lblSaved.Visible = True

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub drpHomeType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpHomeType.SelectedIndexChanged
    Try
      If (drpHomeType.SelectedItem.Text = "Other") Then
        litHomeType.Visible = True
        txtHomeType.Enabled = True
        valTxtHomeType.Enabled = True
      Else
        litHomeType.Visible = False
        txtHomeType.Enabled = False
        valTxtHomeType.Enabled = False
        txtHomeType.Text = ""
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub chkIsInternational_CheckedChanged(sender As Object, e As EventArgs) Handles chkIsInternational.CheckedChanged
    Try
      'was the person ever employed
      If chkIsInternational.Checked Then
        'is international
        pnlInternational.Visible = True
        pnlDomestic.Visible = False
      Else
        'is not international
        pnlInternational.Visible = False
        pnlDomestic.Visible = True
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub ManageValidations(IsValidating As Boolean)
    Try
      'Username
      valUsernameIsValidEmail.Enabled = IsValidating
      valDuplicateEmail.Enabled = IsValidating
      valUsername.Enabled = IsValidating
      'SSN
      valSocialSecurity.Enabled = IsValidating
      'Names
      valFirstName.Enabled = IsValidating
      valMiddleName.Enabled = IsValidating
      valLastName.Enabled = IsValidating
      'DOB
      valDOB.Enabled = IsValidating
      'Phone
      valPhone.Enabled = IsValidating
      'Gender
      valGender.Enabled = IsValidating
      'Address
      valStreet.Enabled = IsValidating
      valCity.Enabled = IsValidating
      valState.Enabled = IsValidating
      valZip.Enabled = IsValidating
      'Began Living
      valBeganLiving.Enabled = IsValidating
      'Home Type
      valDrpHomeType.Enabled = IsValidating
      valTxtHomeType.Enabled = IsValidating
      'Nationality
      valNationality.Enabled = IsValidating
      'Citizenship
      valCitizenship.Enabled = IsValidating
      'Masjid Info
      valMasjidName.Enabled = IsValidating
      valMasjidPhone.Enabled = IsValidating
      'Education
      valHighestEducation.Enabled = IsValidating
      valSchoolName.Enabled = IsValidating
      valSchoolStreet.Enabled = IsValidating
      valSchoolCity.Enabled = IsValidating
      valSchoolState.Enabled = IsValidating
      valSchoolZip.Enabled = IsValidating
      valSchoolCountry.Enabled = IsValidating
      'Husband Info
      valMaritalStatus.Enabled = IsValidating
      valHusbandApplied.Enabled = IsValidating
      valHusbandFirstName.Enabled = IsValidating
      valHusbandMiddleName.Enabled = IsValidating
      valHusbandLastName.Enabled = IsValidating
      valHusbandEmail.Enabled = IsValidating
      valHusbandPhone.Enabled = IsValidating
      valHusbandExplanation.Enabled = IsValidating
      'password
      valPassword.Enabled = IsValidating
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

End Class