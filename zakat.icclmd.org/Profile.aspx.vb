Public Class Profile
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      Response.Write("")
      If Not IsPostBack Then
        calDOB.EndDate = Date.Now
        Dim vUserId As Int32 = Session("sUserId")

        If vUserId = 0 Then Response.Redirect("/")

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

          If vUserId <> 0 Then
            'load user data into the form
            Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vUserId).First
            With oUser
              txtEmail.Text = .email
              txtEmail.Enabled = False
              txtSocialSecurity.Text = Base.getFormattedSSN(.socialSecurityNumber, Base.enumFormatSSN.Format)
              txtFirstName.Text = .firstName
              txtMiddleName.Text = .middleName
              txtLastName.Text = .lastName
              txtDOB.Text = IIf(IsDate(.dob), .dob, "")
              txtPhone.Text = Base.getFormattedPhone(.phone, Base.enumFormatPhone.Format)
              chkGender.SelectedValue = .gender
              drpMaritalStatus.SelectedValue = .maritalStatus
              txtStreet.Text = .street
              txtCity.Text = .city
              drpState.SelectedValue = .stateAbbr
              txtZip.Text = .zip
              txtBeganLiving.Text = IIf(IsDate(.beganLivingDate), .beganLivingDate, "")
              drpHomeType.SelectedValue = .homeType
              txtHomeType.Enabled = IIf(drpHomeType.SelectedValue = "Other", True, False)
              txtHomeType.Text = .homeTypeOther
              drpNationality.SelectedValue = .nationalityId
              drpCitizenship.SelectedValue = .citizenshipStatus
              drpHighestEducation.SelectedValue = .highestEducationCompleted
              txtSchoolName.Text = .schoolName
              txtSchoolStreet.Text = .schoolStreet
              txtSchoolCity.Text = .schoolCity
              drpSchoolState.SelectedValue = .schoolStateAbbr
              txtSchoolZip.Text = .schoolZip
              txtHusbandFirstName.Text = .husbandFirstName
              txtHusbandMiddleName.Text = .husbandMiddleName
              txtHusbandLastName.Text = .husbandLastName
              txtHusbandEmail.Text = .husbandEmail
              txtHusbandPhone.Text = Base.getFormattedPhone(.husbandPhone, Base.enumFormatPhone.Format)
              'chkHusbandApplied.SelectedValue = .husbandHasAppliedForZakat
              'txtHusbandExplanation.Text = .husbandZakatExplanation
            End With

            Session("sUserFirstName") = oUser.firstName

            'add saved languages to the spoken listbox
            If ((From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vUserId).Any) Then
              'there are languages so add in the form
              Dim oUserLanguages As List(Of USER_LANGUAGE) = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vUserId).ToList
              For Each item In oUserLanguages
                'obtain the language id from the list and add from the db
                lstSpoken.Items.Add(New ListItem(item.LANGUAGE.name, item.LANGUAGE.languageId))
              Next
            End If

            'add saved certifications to the skills/certs listbox
            If ((From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vUserId).Any) Then
              'there are skills/certs so add in the form
              Dim oCertSkills As List(Of CERTIFICATION_SKILL) = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vUserId).ToList
              For Each item In oCertSkills
                'obtain the skills/certs from the list and add from the db
                lstSkillCertification.Items.Add(New ListItem(item.certificationSkill, item.certificationSkillId))
              Next
            End If

            If chkGender.SelectedValue = "Female" And (drpMaritalStatus.SelectedValue = "Married" Or drpMaritalStatus.SelectedValue = "Divorced") Then
              pnlHusbandInformation.Visible = True
            Else
              pnlHusbandInformation.Visible = False
            End If
          End If
        End Using
      End If
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
    Try
      Dim vUserId As Int32 = Session("sUserId")

      Using oDB As New zakatEntities
        'check if the user exists or not, if not, exit sub
        If Not (From USER In oDB.USER Where USER.userId = vUserId).Any Then
          'verify user is in session or exit sub
          Exit Sub
        End If

        'save user data
        Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vUserId).First
        With oUser
          .socialSecurityNumber = Base.getFormattedSSN(txtSocialSecurity.Text, Base.enumFormatSSN.Strip)
          .firstName = txtFirstName.Text
          .middleName = txtMiddleName.Text
          .lastName = txtLastName.Text
          .dob = IIf(IsDate(txtDOB.Text), CDate(txtDOB.Text), Nothing)
          .phone = Base.getFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip)
          .gender = chkGender.SelectedValue
          .maritalStatus = drpMaritalStatus.SelectedValue
          .street = txtStreet.Text
          .city = txtCity.Text
          .stateAbbr = drpState.SelectedValue
          .zip = txtZip.Text
          .beganLivingDate = IIf(IsDate(txtBeganLiving.Text), CDate(txtBeganLiving.Text), Nothing)
          .homeType = drpHomeType.SelectedValue
          .homeTypeOther = txtHomeType.Text
          .nationalityId = drpNationality.SelectedValue
          .citizenshipStatus = drpCitizenship.SelectedValue
          .highestEducationCompleted = drpHighestEducation.SelectedValue
          .schoolName = txtSchoolName.Text
          .schoolStreet = txtSchoolStreet.Text
          .schoolCity = txtSchoolCity.Text
          .schoolStateAbbr = drpSchoolState.SelectedValue
          .schoolZip = txtSchoolZip.Text
          .husbandFirstName = txtHusbandFirstName.Text
          .husbandMiddleName = txtHusbandMiddleName.Text
          .husbandLastName = txtHusbandLastName.Text
          .husbandEmail = txtHusbandEmail.Text
          .husbandPhone = Base.getFormattedPhone(txtHusbandPhone.Text, Base.enumFormatPhone.Strip)
          '.husbandHasAppliedForZakat = chkHusbandApplied.SelectedValue
          '.husbandZakatExplanation = txtHusbandExplanation.Text

          'successful save so set user name
          Session("sUserFirstName") = txtFirstName.Text
        End With

        ' Add to Memory
        oDB.SaveChanges()

        'delete all saved languages
        If ((From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vUserId).Any) Then
          'there are languages so delete them and read just add those in the form
          Dim oUserLanguages As List(Of USER_LANGUAGE) = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vUserId).ToList
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
            .userId = vUserId
            .languageId = CInt(item.Value)
          End With
          oDB.USER_LANGUAGE.Add(oUserLanguage)
          oDB.SaveChanges()
        Next

        'delete all certs/skills
        If ((From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vUserId).Any) Then
          'there are languages so delete them and read just add those in the form
          Dim oCertSkills As List(Of CERTIFICATION_SKILL) = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vUserId).ToList
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
            .userId = vUserId
            .certificationSkill = item.Text
          End With
          oDB.CERTIFICATION_SKILL.Add(oCertSkill)
          oDB.SaveChanges()
        Next
      End Using

      'refresh page
      Response.Redirect("profile")

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub chkGender_SelectedIndexChanged(sender As Object, e As EventArgs) Handles chkGender.SelectedIndexChanged
    Try
      If chkGender.SelectedValue = "Female" And (drpMaritalStatus.SelectedValue = "Married" Or drpMaritalStatus.SelectedValue = "Divorced") Then
        pnlHusbandInformation.Visible = True
      Else
        pnlHusbandInformation.Visible = False
      End If
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpMaritalStatus_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpMaritalStatus.SelectedIndexChanged
    Try
      If chkGender.SelectedValue = "Female" And (drpMaritalStatus.SelectedValue = "Married" Or drpMaritalStatus.SelectedValue = "Divorced") Then
        pnlHusbandInformation.Visible = True
      Else
        pnlHusbandInformation.Visible = False
      End If
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub
End Class