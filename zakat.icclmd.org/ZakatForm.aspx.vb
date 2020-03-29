Public Class ZakatForm
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      Response.Write("")
      If Not IsPostBack Then
        calDOB.EndDate = Date.Now
        Dim vUserId As Int32 = Session("sUserId")

        Using oDB As New zakatEntities
          'load the state dropdown
          Dim oState As List(Of STATE) = (From STATE In oDB.STATE Order By STATE.stateName).ToList
          drpState.DataSource = oState
          drpState.DataTextField = "stateName"
          drpState.DataValueField = "stateAbbr"
          drpState.DataBind()

          drpEmployerState.DataSource = oState
          drpEmployerState.DataTextField = "stateName"
          drpEmployerState.DataValueField = "stateAbbr"
          drpEmployerState.DataBind()

          drpRefState.DataSource = oState
          drpRefState.DataTextField = "stateName"
          drpRefState.DataValueField = "stateAbbr"
          drpRefState.DataBind()

          drpSchoolState.DataSource = oState
          drpSchoolState.DataTextField = "stateName"
          drpSchoolState.DataValueField = "stateAbbr"
          drpSchoolState.DataBind()

          'load the nationality dropdown
          drpNationality.DataSource = (From NATIONALITY In oDB.NATIONALITY Order By NATIONALITY.name).ToList
          drpNationality.DataTextField = "name"
          drpNationality.DataValueField = "nationalityId"
          drpNationality.DataBind()

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

          If vUserId <> 0 Then
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
              'show husband pane based on rules
              If (.gender = "Female" And (.maritalStatus = "Married" Or .maritalStatus = "Divorced")) Then
                pnlHusbandInformation.Visible = True
              Else
                pnlHusbandInformation.Visible = False
              End If
              txtHusbandFirstName.Text = .husbandFirstName
              txtHusbandMiddleName.Text = .husbandMiddleName
              txtHusbandLastName.Text = .husbandLastName
              txtHusbandEmail.Text = .husbandEmail
              txtHusbandPhone.Text = Base.getFormattedPhone(.husbandPhone, Base.enumFormatPhone.Format)
              chkHusbandApplied.SelectedValue = .husbandHasAppliedForZakat
              txtHusbandExplanation.Text = .husbandZakatExplanation
              txtMasjidName.Text = .primaryMasjidName
              txtMasjidPhone.Text = Base.getFormattedPhone(.primaryMasjidPhone, Base.enumFormatPhone.Format)
            End With

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

            'load the dependents repeater
            setDependents()
            'load the references repeater
            setReferences()

            'refresh applicant progress
            RefreshApplicantProgress()
            'refresh reference progress
            RefreshReferenceProgress()

            'load applciation belongs to the user and the draft status is true and the submitted flag is false
            If (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId And APPLICATION.isDrafted = True And APPLICATION.isSubmitted = False).Any Then
              Dim oDraftApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId And APPLICATION.isDrafted = True And APPLICATION.isSubmitted = False).First

              With oDraftApplication
                drpOrganization.SelectedValue = .organizationId
                txtValueCash.Text = FormatCurrency(.totalValueCash)
                txtValueGold.Text = FormatCurrency(.totalValueGold)
                txtValueSilver.Text = FormatCurrency(.totalValueSilver)
                txtValueInvestment.Text = FormatCurrency(.totalValueInvestment)
                txtValueRetirement.Text = FormatCurrency(.totalValueRetirement)
                txtValueLifeInsurance.Text = FormatCurrency(.totalValueLifeInsurance)
                txtValueDebt.Text = FormatCurrency(.totalValueOutstandingDebts)
                txtValueChildSupport.Text = FormatCurrency(.totalChildSupport)
                drpChildSupportFrequency.Enabled = IIf(.totalChildSupport > 0, True, False)
                drpChildSupportFrequency.SelectedValue = .frequencyChildSupport
                txtValueFoodStamps.Text = FormatCurrency(.totalFoodStamps)
                drpFoodStampFrequency.Enabled = IIf(.totalFoodStamps > 0, True, False)
                drpFoodStampFrequency.SelectedValue = .frequencyFoodStamps
                txtValueAssistance.Text = FormatCurrency(.totalTemporaryCashAssistance)
                txtWhoAssisted.Enabled = IIf(.totalTemporaryCashAssistance > 0, True, False)
                txtWhoAssisted.Text = .sourceTemporaryCashAssistance
                If (.hasHealthInsurance <> "") Then
                  chkInsurance.SelectedValue = IIf(.hasHealthInsurance, "Yes", "No")
                End If
                pnlInsurance.Visible = IIf(chkInsurance.SelectedValue = "Yes", True, False)
                txtInsuranceProvider.Text = .healthInsuranceProviderName
                txtPolicyNumber.Text = .healthInsuranceProviderPolicyNumber
                txtMedicare.Text = .medicareNumber
                txtMedicaid.Text = .medicaidNumber
                txtEmployerName.Text = .employerName
                txtEmploymentStart.Text = IIf(IsDate(.employmentStartDate), .employmentStartDate, "")
                txtEmploymentEnd.Text = IIf(IsDate(.employmentEndtDate), .employmentEndtDate, "")
                txtPosition.Text = .positionTitle
                txtEmployerPhone.Text = Base.getFormattedPhone(.employerPhone, Base.enumFormatPhone.Format)
                txtMonthlySalary.Text = FormatCurrency(.totalMonthlyGrossSalary)
                txtEmployerStreet.Text = .employerStreet
                txtEmployerCity.Text = .employerCity
                drpEmployerState.SelectedValue = .employerStateAbbr
                txtEmployerZip.Text = .employerZip
                txtPersonalStatement.Text = .personalNeedStatement
              End With
              'refresh assets and support progress
              RefreshAssetsSupportProgress()
              'refresh employment progress
              RefreshEmploymentProgress()
              'refresh personal statement progress
              RefreshStatementProgress()
            End If
          End If
        End Using
        If drpOrganization.SelectedValue = "(Select One)" Then
          accZakat.Enabled = False
          btnSave.Enabled = False
          btnSubmit.Enabled = False
        Else
          accZakat.Enabled = True
          btnSave.Enabled = True
          btnSubmit.Enabled = True
        End If
      End If
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function GetDate(ByVal month As Short, ByVal day As Short) As Date
    GetDate = CDate(month.ToString + day.ToString + Today.Year.ToString)
  End Function

  Sub RefreshApplicantProgress()
    Try
      Dim v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29 As Boolean
      If (txtEmail.Text = "") Then
        v1 = False
      Else
        v1 = True
      End If
      If (txtSocialSecurity.Text = "") Then
        v2 = False
      Else
        v2 = True
      End If
      If (txtFirstName.Text = "") Then
        v3 = False
      Else
        v3 = True
      End If
      If (txtLastName.Text = "") Then
        v4 = False
      Else
        v4 = True
      End If
      If (txtDOB.Text = "") Then
        v5 = False
      Else
        v5 = True
      End If
      If (txtPhone.Text = "") Then
        v6 = False
      Else
        v6 = True
      End If
      If (chkGender.SelectedIndex = -1) Then
        v7 = False
      Else
        v7 = True
      End If
      If (drpMaritalStatus.SelectedIndex = 0) Then
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
      If (txtHomeType.Text = "") Then
        v15 = False
      Else
        v15 = True
      End If
      If (drpNationality.SelectedIndex = 0) Then
        v16 = False
      Else
        v16 = True
      End If
      If (drpCitizenship.SelectedIndex = 0) Then
        v17 = False
      Else
        v17 = True
      End If
      If (drpHighestEducation.SelectedIndex = 0) Then
        v18 = False
      Else
        v18 = True
      End If
      If (txtSchoolName.Text = "") Then
        v19 = False
      Else
        v19 = True
      End If
      If (txtSchoolStreet.Text = "") Then
        v20 = False
      Else
        v20 = True
      End If
      If (txtSchoolCity.Text = "") Then
        v21 = False
      Else
        v21 = True
      End If
      If (drpSchoolState.SelectedIndex = 0) Then
        v22 = False
      Else
        v22 = True
      End If
      If (txtSchoolZip.Text = "") Then
        v23 = False
      Else
        v23 = True
      End If
      If (txtHusbandFirstName.Text = "") Then
        v24 = False
      Else
        v24 = True
      End If
      If (txtHusbandLastName.Text = "") Then
        v25 = False
      Else
        v25 = True
      End If
      If (txtHusbandPhone.Text = "") Then
        v26 = False
      Else
        v26 = True
      End If
      If (txtHusbandEmail.Text = "") Then
        v27 = False
      Else
        v27 = True
      End If
      If (chkHusbandApplied.SelectedIndex = -1) Then
        v28 = False
      Else
        v28 = True
      End If
      If (txtHusbandExplanation.Text = "") Then
        v29 = False
      Else
        v29 = True
      End If

      Dim vProgress As Decimal = 0
      Dim vPossible As Int16 = IIf(chkGender.SelectedValue = "Female" And (drpMaritalStatus.SelectedValue = "Married" Or drpMaritalStatus.SelectedValue = "Divorced"), 28, 22)
      vPossible = IIf(drpHomeType.SelectedValue = "Other", vPossible + 1, vPossible)
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
      If (drpHomeType.SelectedValue = "Other" And txtHomeType.Text <> "") Then
        If (v15 = True) Then
          vProgress += 1
        End If
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
      If (v19 = True) Then
        vProgress += 1
      End If
      If (v20 = True) Then
        vProgress += 1
      End If
      If (v21 = True) Then
        vProgress += 1
      End If
      If (v22 = True) Then
        vProgress += 1
      End If
      If (v23 = True) Then
        vProgress += 1
      End If

      'add the following if husband section is visible
      If (chkGender.SelectedValue = "Female" And (drpMaritalStatus.SelectedValue = "Married" Or drpMaritalStatus.SelectedValue = "Divorced")) Then
        If (v24 = True) Then
          vProgress += 1
        End If
        If (v25 = True) Then
          vProgress += 1
        End If
        If (v26 = True) Then
          vProgress += 1
        End If
        If (v27 = True) Then
          vProgress += 1
        End If
        If (v28 = True) Then
          vProgress += 1
        End If
        If (v29 = True) Then
          vProgress += 1
        End If
      End If

      'calculate progress
      vProgress = ((vProgress / vPossible) * 100)

      'set progress bar attributes
      prgApplicant.Attributes.Add("aria-valuenow", CStr(CInt(vProgress)))
      prgApplicant.Style("width") = CStr(CInt(vProgress)) + "%"
      ltlPercentApplicant.Text = CStr(CInt(vProgress)) + "% Complete"
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub RefreshAssetsSupportProgress()
    Try
      Dim v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 As Boolean
      If (txtValueCash.Text = "") Then
        v1 = False
      Else
        v1 = True
      End If
      If (txtValueGold.Text = "") Then
        v2 = False
      Else
        v2 = True
      End If
      If (txtValueSilver.Text = "") Then
        v3 = False
      Else
        v3 = True
      End If
      If (txtValueInvestment.Text = "") Then
        v4 = False
      Else
        v4 = True
      End If
      If (txtValueRetirement.Text = "") Then
        v5 = False
      Else
        v5 = True
      End If
      If (txtValueLifeInsurance.Text = "") Then
        v6 = False
      Else
        v6 = True
      End If
      If (txtValueDebt.Text = "") Then
        v7 = False
      Else
        v7 = True
      End If
      If (txtValueChildSupport.Text = "") Then
        v8 = False
      Else
        v8 = True
      End If
      If (IsNumeric(txtValueChildSupport.Text)) Then
        If CInt(txtValueChildSupport.Text) > 0 Then
          If drpChildSupportFrequency.SelectedIndex = 0 Then
            v9 = False
          Else
            v9 = True
          End If
        Else
          v9 = False
        End If
      Else
        v9 = False
      End If
      If (txtValueFoodStamps.Text = "") Then
        v10 = False
      Else
        v10 = True
      End If
      If (IsNumeric(txtValueFoodStamps.Text)) Then
        If CInt(txtValueFoodStamps.Text) > 0 Then
          If drpFoodStampFrequency.SelectedIndex = 0 Then
            v11 = False
          Else
            v11 = True
          End If
        Else
          v11 = False
        End If
      Else
        v11 = False
      End If
      If (txtValueAssistance.Text = "") Then
        v12 = False
      Else
        v12 = True
      End If
      If (IsNumeric(txtValueAssistance.Text)) Then
        If (CInt(txtValueAssistance.Text) > 0) Then
          If (txtWhoAssisted.Text = "") Then
            v13 = False
          Else
            v13 = True
          End If
        Else
          v13 = False
        End If
      Else
        v13 = False
      End If
      If (chkInsurance.SelectedValue = "") Then
        v14 = False
      Else
        v14 = True
        If (chkInsurance.SelectedValue = "Yes") Then
          If (txtInsuranceProvider.Text = "") Then
            v15 = False
          Else
            v15 = True
          End If
          If (txtMedicare.Text = "") Then
            v16 = False
          Else
            v16 = True
          End If
          If (txtPolicyNumber.Text = "") Then
            v17 = False
          Else
            v17 = True
          End If
          If (txtMedicaid.Text = "") Then
            v18 = False
          Else
            v18 = True
          End If
        End If
      End If

      Dim vProgress As Decimal
      Dim vPossible As Int16 = 11

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
      If (IsNumeric(txtValueChildSupport.Text)) Then
        If (CInt(txtValueChildSupport.Text) > 0) Then
          vPossible += 1
          If (v9 = True) Then
            vProgress += 1
          End If
        End If
      End If
      If (v10 = True) Then
        vProgress += 1
      End If
      If (IsNumeric(txtValueFoodStamps.Text)) Then
        If (CInt(txtValueFoodStamps.Text) > 0) Then
          vPossible += 1
          If (v11 = True) Then
            vProgress += 1
          End If
        End If
      End If
      If (v12 = True) Then
        vProgress += 1
      End If
      If (IsNumeric(txtValueAssistance.Text)) Then
        If (CInt(txtValueAssistance.Text) > 0) Then
          vPossible += 1
          If (v13 = True) Then
            vProgress += 1
          End If
        End If
      End If
      If (v14 = True) Then
        vPossible += 4
        vProgress += 1
        'add the following since insurance section visible
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
      End If

      'calculate progress
      vProgress = ((vProgress / vPossible) * 100)

      'set progress bar attributes
      prgAssetsAndSupport.Attributes.Add("aria-valuenow", CStr(CInt(vProgress)))
      prgAssetsAndSupport.Style("width") = CStr(CInt(vProgress)) + "%"
      ltlPercentAssetsAndSupport.Text = CStr(CInt(vProgress)) + "% Complete"
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub RefreshEmploymentProgress()
    Try
      Dim v1, v2, v3, v4, v5, v6, v7, v8, v9 As Boolean
      If (txtEmployerName.Text = "") Then
        v1 = False
      Else
        v1 = True
      End If
      If (txtEmploymentStart.Text = "") Then
        v2 = False
      Else
        v2 = True
      End If
      ''If (txtEmploymentEnd.Text = "") Then
      ''  v3 = False
      ''Else
      ''  v3 = True
      ''End If
      If (txtPosition.Text = "") Then
        v3 = False
      Else
        v3 = True
      End If
      If (txtEmployerPhone.Text = "") Then
        v4 = False
      Else
        v4 = True
      End If
      If (txtMonthlySalary.Text = "") Then
        v5 = False
      Else
        v5 = True
      End If
      If (txtEmployerStreet.Text = "") Then
        v6 = False
      Else
        v6 = True
      End If
      If (txtEmployerCity.Text = "") Then
        v7 = False
      Else
        v7 = True
      End If
      If (drpEmployerState.SelectedIndex = 0) Then
        v8 = False
      Else
        v8 = True
      End If
      If (txtEmployerZip.Text = "") Then
        v9 = False
      Else
        v9 = True
      End If

      Dim vProgress As Decimal
      Dim vPossible As Int16 = 9

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

      'calculate progress
      vProgress = ((vProgress / vPossible) * 100)

      'set progress bar attributes
      prgEmployment.Attributes.Add("aria-valuenow", CStr(CInt(vProgress)))
      prgEmployment.Style("width") = CStr(CInt(vProgress)) + "%"
      ltlPercentEmployment.Text = CStr(CInt(vProgress)) + "% Complete"
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub RefreshReferenceProgress()
    Try
      Dim vProgress As Decimal = CInt(lblReferences.Text)
      Dim vPossible As Int32 = 2
      'calculate progress
      If vProgress > 2 Then
        vProgress = 2
      End If
      vProgress = ((vProgress / vPossible) * 100)

      'set progress bar attributes
      prgReference.Attributes.Add("aria-valuenow", CStr(CInt(vProgress)))
      prgReference.Style("width") = CStr(CInt(vProgress)) + "%"
      ltlPercentReference.Text = CStr(CInt(vProgress)) + "% Complete"
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub RefreshStatementProgress()
    Try
      If txtPersonalStatement.Text = "" Then
        'set progress bar attributes
        prgStatement.Attributes.Add("aria-valuenow", "0")
        prgStatement.Style("width") = "0%"
        ltlPercentStatement.Text = "0% Complete"
      Else
        'set progress bar attributes
        prgStatement.Attributes.Add("aria-valuenow", "100")
        prgStatement.Style("width") = "100%"
        ltlPercentStatement.Text = "100% Complete"
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
      Dim vDependentId As Int32 = sender.CommandArgument
      Using oDB As New zakatEntities
        Dim oDependent As DEPENDENT = (From DEPENDENT In oDB.DEPENDENT Where DEPENDENT.dependentId = vDependentId).First
        oDB.DEPENDENT.Remove(oDependent)
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
        Dim oDependent_List As List(Of DEPENDENT) = (From DEPENDENT In oDB.DEPENDENT Where DEPENDENT.userId = vUserId).ToList
        rptDependents.DataSource = oDependent_List
        rptDependents.DataBind()
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setReferences()
    Try
      Dim vUserId As Int32 = Session("sUserId")
      Using oDB As New zakatEntities
        'update repeater
        Dim oReference_List As List(Of REFERENCE) = (From REFERENCE In oDB.REFERENCE Where REFERENCE.userId = vUserId).ToList
        rptReferences.DataSource = oReference_List
        rptReferences.DataBind()
        'set the badge
        lblReferences.Text = oReference_List.Count
      End Using
      ' refresh the progress bar
      RefreshReferenceProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpOrganization_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpOrganization.SelectedIndexChanged
    Try
      Using oDB As New zakatEntities
        If drpOrganization.SelectedValue = "(Select One)" Then
          accZakat.Enabled = False
          btnSave.Enabled = False
          btnSubmit.Enabled = False
        Else
          accZakat.Enabled = True
          btnSave.Enabled = True
          btnSubmit.Enabled = True
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

  Private Sub btnAddDependent_Click(sender As Object, e As EventArgs) Handles btnAddDependent.Click
    Try
      'reset validator
      valUserRequiredDep.IsValid = True

      'if no user determine if one can be created or give validation
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then
        'is the email, first and last name populated?
        If txtEmail.Text <> "" And txtFirstName.Text <> "" And txtLastName.Text <> "" Then
          'create the user
          vUserId = Base.createUser(Base.enumRole.Appliciant, txtEmail.Text, txtFirstName.Text, txtLastName.Text, txtMiddleName.Text)
        Else
          'show validation and exit sub
          valUserRequiredDep.IsValid = False
          Exit Sub
        End If
      End If

      'set session userId
      Session("sUserId") = vUserId

      'add dependent
      Using oDB As New zakatEntities
        Dim oDependent As New DEPENDENT

        'insert information about new dependent and save to db
        With oDependent
          .userId = vUserId
          .firstName = txtDepFirstName.Text
          .middleName = txtDepMiddleName.Text
          .lastName = txtDepLastName.Text
          .gender = chkDepGender.SelectedValue
          .relationship = drpDepRelation.SelectedValue
          .dob = CDate(txtDepDOB.Text)
        End With

        ' Add to Memory
        oDB.DEPENDENT.Add(oDependent)
        oDB.SaveChanges()
      End Using

      'reset input values
      txtDepFirstName.Text = ""
      txtDepMiddleName.Text = ""
      txtDepLastName.Text = ""
      txtDepDOB.Text = ""
      chkDepGender.ClearSelection()
      drpDepRelation.SelectedValue = "(Select One)"
      'refresh the dependent repeater
      setDependents()
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
      RefreshApplicantProgress()

      'place the focus in the next textbox in the tabnidex order
      'Dim tb As TextBox = CType(FormOrder.FindControl("txtFirstName"), TextBox)
      'tb.Focus()
      'SetFocus(txtFirstName)
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtFirstName_TextChanged(sender As Object, e As EventArgs) Handles txtFirstName.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtLastName_TextChanged(sender As Object, e As EventArgs) Handles txtLastName.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtSocialSecurity_TextChanged(sender As Object, e As EventArgs) Handles txtSocialSecurity.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtDOB_TextChanged(sender As Object, e As EventArgs) Handles txtDOB.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtPhone_TextChanged(sender As Object, e As EventArgs) Handles txtPhone.TextChanged
    Try
      RefreshApplicantProgress()
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
      RefreshApplicantProgress()
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
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtStreet_TextChanged(sender As Object, e As EventArgs) Handles txtStreet.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtCity_TextChanged(sender As Object, e As EventArgs) Handles txtCity.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpState_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpState.SelectedIndexChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtZip_TextChanged(sender As Object, e As EventArgs) Handles txtZip.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtBeganLiving_TextChanged(sender As Object, e As EventArgs) Handles txtBeganLiving.TextChanged
    Try
      RefreshApplicantProgress()
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
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtHomeType_TextChanged(sender As Object, e As EventArgs) Handles txtHomeType.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpNationality_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpNationality.SelectedIndexChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpCitizenship_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpCitizenship.SelectedIndexChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpHighestEducation_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpHighestEducation.SelectedIndexChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtSchoolName_TextChanged(sender As Object, e As EventArgs) Handles txtSchoolName.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtSchoolStreet_TextChanged(sender As Object, e As EventArgs) Handles txtSchoolStreet.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtSchoolCity_TextChanged(sender As Object, e As EventArgs) Handles txtSchoolCity.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpSchoolState_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpSchoolState.SelectedIndexChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtSchoolZip_TextChanged(sender As Object, e As EventArgs) Handles txtSchoolZip.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtHusbandFirstName_TextChanged(sender As Object, e As EventArgs) Handles txtHusbandFirstName.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtHusbandLastName_TextChanged(sender As Object, e As EventArgs) Handles txtHusbandLastName.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtHusbandPhone_TextChanged(sender As Object, e As EventArgs) Handles txtHusbandPhone.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtHusbandEmail_TextChanged(sender As Object, e As EventArgs) Handles txtHusbandEmail.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub chkHusbandApplied_SelectedIndexChanged(sender As Object, e As EventArgs) Handles chkHusbandApplied.SelectedIndexChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtHusbandExplanation_TextChanged(sender As Object, e As EventArgs) Handles txtHusbandExplanation.TextChanged
    Try
      RefreshApplicantProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtValueCash_TextChanged(sender As Object, e As EventArgs) Handles txtValueCash.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtValueGold_TextChanged(sender As Object, e As EventArgs) Handles txtValueGold.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtValueSilver_TextChanged(sender As Object, e As EventArgs) Handles txtValueSilver.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtValueInvestment_TextChanged(sender As Object, e As EventArgs) Handles txtValueInvestment.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtValueRetirement_TextChanged(sender As Object, e As EventArgs) Handles txtValueRetirement.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtValueLifeInsurance_TextChanged(sender As Object, e As EventArgs) Handles txtValueLifeInsurance.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtValueDebt_TextChanged(sender As Object, e As EventArgs) Handles txtValueDebt.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtValueChildSupport_TextChanged(sender As Object, e As EventArgs) Handles txtValueChildSupport.TextChanged
    Try
      If CInt(txtValueChildSupport.Text) > 0 Then
        drpChildSupportFrequency.Enabled = True
        valChildSupportFrequency.Enabled = True
      Else
        drpChildSupportFrequency.SelectedValue = "(Select One)"
        drpChildSupportFrequency.Enabled = False
        valChildSupportFrequency.Enabled = False
      End If
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpChildSupportFrequency_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpChildSupportFrequency.SelectedIndexChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtValueFoodStamps_TextChanged(sender As Object, e As EventArgs) Handles txtValueFoodStamps.TextChanged
    Try
      If CInt(txtValueFoodStamps.Text) > 0 Then
        drpFoodStampFrequency.Enabled = True
        valFoodStampFrequency.Enabled = True
      Else
        drpFoodStampFrequency.SelectedValue = "(Select One)"
        drpFoodStampFrequency.Enabled = False
        valFoodStampFrequency.Enabled = False
      End If
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpFoodStampFrequency_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpFoodStampFrequency.SelectedIndexChanged
    Try
      RefreshAssetsSupportProgress()
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
      'refresh the progress bar
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtWhoAssisted_TextChanged(sender As Object, e As EventArgs) Handles txtWhoAssisted.TextChanged
    Try
      RefreshAssetsSupportProgress()
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
      'refresh the progress bar
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtInsuranceProvider_TextChanged(sender As Object, e As EventArgs) Handles txtInsuranceProvider.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtMedicare_TextChanged(sender As Object, e As EventArgs) Handles txtMedicare.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtPolicyNumber_TextChanged(sender As Object, e As EventArgs) Handles txtPolicyNumber.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtMedicaid_TextChanged(sender As Object, e As EventArgs) Handles txtMedicaid.TextChanged
    Try
      RefreshAssetsSupportProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtEmployerName_TextChanged(sender As Object, e As EventArgs) Handles txtEmployerName.TextChanged
    Try
      RefreshEmploymentProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtEmploymentStart_TextChanged(sender As Object, e As EventArgs) Handles txtEmploymentStart.TextChanged
    Try
      RefreshEmploymentProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtEmploymentEnd_TextChanged(sender As Object, e As EventArgs) Handles txtEmploymentEnd.TextChanged
    Try
      RefreshEmploymentProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtPosition_TextChanged(sender As Object, e As EventArgs) Handles txtPosition.TextChanged
    Try
      RefreshEmploymentProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtEmployerPhone_TextChanged(sender As Object, e As EventArgs) Handles txtEmployerPhone.TextChanged
    Try
      RefreshEmploymentProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtMonthlySalary_TextChanged(sender As Object, e As EventArgs) Handles txtMonthlySalary.TextChanged
    Try
      RefreshEmploymentProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtEmployerStreet_TextChanged(sender As Object, e As EventArgs) Handles txtEmployerStreet.TextChanged
    Try
      RefreshEmploymentProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtEmployerCity_TextChanged(sender As Object, e As EventArgs) Handles txtEmployerCity.TextChanged
    Try
      RefreshEmploymentProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub drpEmployerState_SelectedIndexChanged(sender As Object, e As EventArgs) Handles drpEmployerState.SelectedIndexChanged
    Try
      RefreshEmploymentProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtEmployerZip_TextChanged(sender As Object, e As EventArgs) Handles txtEmployerZip.TextChanged
    Try
      RefreshEmploymentProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub txtPersonalStatement_TextChanged(sender As Object, e As EventArgs) Handles txtPersonalStatement.TextChanged
    Try
      RefreshStatementProgress()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnAddReference_Click(sender As Object, e As EventArgs) Handles btnAddReference.Click
    Try
      'reset validator
      valUserRequiredRef.IsValid = True

      'if no user determine if one can be created or give validation
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then
        'is the email, first and last name populated?
        If txtEmail.Text <> "" And txtFirstName.Text <> "" And txtLastName.Text <> "" Then
          'create the user and then add the reference
          vUserId = Base.createUser(Base.enumRole.Appliciant, txtEmail.Text, txtFirstName.Text, txtLastName.Text)
        Else
          'show validation and exit sub
          valUserRequiredRef.IsValid = False
          Exit Sub
        End If
      End If

      'set session userId
      Session("sUserId") = vUserId

      'add reference
      Using oDB As New zakatEntities
        Dim oReference As New REFERENCE

        'insert information about new dependent and save to db
        With oReference
          .userId = vUserId
          .firstName = txtRefFirstName.Text
          .middleName = txtRefMiddleName.Text
          .lastName = txtRefLastName.Text
          .relationship = drpRefRelation.SelectedValue
          .phone = Base.getFormattedPhone(txtRefPhone.Text, Base.enumFormatPhone.Strip)
          .knownSince = CDate(txtKnownSince.Text)
          .street = txtRefStreet.Text
          .city = txtRefCity.Text
          .stateAbbr = drpRefState.SelectedValue
          .zip = txtRefZip.Text
        End With

        ' Add to Memory
        oDB.REFERENCE.Add(oReference)
        oDB.SaveChanges()
      End Using

      'reset input values
      txtRefFirstName.Text = ""
      txtRefMiddleName.Text = ""
      txtRefLastName.Text = ""
      drpRefRelation.SelectedValue = "(Select One)"
      txtRefPhone.Text = ""
      txtKnownSince.Text = ""
      txtRefStreet.Text = ""
      txtRefCity.Text = ""
      drpRefState.SelectedValue = "(Select One)"
      txtRefZip.Text = ""

      'refresh the reference repeater
      setReferences()
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
    Try
      'reset validator
      valUserRequiredSave.IsValid = True

      'if no user, determine if one can be created or give validation
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then
        'is the email, first and last name populated?
        If txtEmail.Text <> "" And txtFirstName.Text <> "" And txtLastName.Text <> "" Then
          vUserId = Base.createUser(Base.enumRole.Appliciant, txtEmail.Text, txtFirstName.Text, txtLastName.Text, txtMiddleName.Text)
        Else
          'show validation and exit sub
          valUserRequiredSave.IsValid = False
          Exit Sub
        End If
      End If

      'update all the values stored in the form by calling a common sub routine
      SaveZakatForm(vUserId, True)

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
    Try
      'verify acknowledgement statement
      valAcknowledgement.IsValid = True
      If chkAcknowledgement.Checked = False Then
        valAcknowledgement.IsValid = False
        Exit Sub
      End If

      Dim vApplicationId As Int32
      'if no user, determine if one can be created or give validation
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then
        'is the email, first and last name populated?
        If txtEmail.Text <> "" And txtFirstName.Text <> "" And txtLastName.Text <> "" Then
          vUserId = Base.createUser(Base.enumRole.Appliciant, txtEmail.Text, txtFirstName.Text, txtLastName.Text, txtMiddleName.Text)
        Else
          'show validation and exit sub
          valUserRequiredSave.IsValid = False
          Exit Sub
        End If
      End If

      'update all the values stored in the form by calling a common sub routine
      SaveZakatForm(vUserId, False)



      'set the appropriate status for submission: isDrafted=True, isSubmitted=True, approvalStatus=Submitted
      Using oDB As New zakatEntities
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId And APPLICATION.isDrafted = True).Any Then
          Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId And APPLICATION.isDrafted = True).First
          With oApplication
            .userId = vUserId
            .organizationId = drpOrganization.SelectedValue
            .isDrafted = True
            .isSubmitted = True
            .isValidated = False
            .isInvestigated = False
            .isQualified1 = False
            .isQualified2 = False
            .IsDispersed = False
            .applicationStatus = "Submitted"
            .submittedOn = Date.Now
            .submittedBy = vUserId
            .updatedOn = Date.Now
            .updatedBy = vUserId
          End With
          'update db
          oDB.SaveChanges()

          vApplicationId = oApplication.applicationId
        End If
      End Using

      'email the user about application submission
      Dim vTo As String = txtEmail.Text
      Dim vSubject As String = "Online Zakat - Application Submitted"
      Dim vMsgText As New StringBuilder

      vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
      vMsgText.Append("Assalaamu Alaikum " & Session("sUserFirstName") & ",<br /><br />")
      vMsgText.Append("Your Zakat Application has been received. We will provide you with updates regarding the progress of your application. You can also review the progress of your application online by clicking or copying/pasting the dashboard link below:<br /><br />")
      vMsgText.Append("<b>Dashboard Link: </b> <a target='_blank' href='https://zakat.icclmd.org/dashboard'>https://zakat.icclmd.org/dashboard</a><br /><br />")
      vMsgText.Append("If you have issues regarding your zakat application, please don’t hesitate to contact us using the information below.<br /><br />")
      vMsgText.Append("Jazakum Allahu Khairan,<br /><br />")
      vMsgText.Append("ICCL Zakat Administrator<br />")
      vMsgText.Append("<a target='_blank' href='mailto:zakat@icclmd.org'>zakat@icclmd.org</a><br />")
      vMsgText.Append("301-317-4584<br />")
      vMsgText.Append("7306 Contee Road<br />")
      vMsgText.Append("Laurel, MD 20707<br />")
      vMsgText.Append("<a href='https://zakat.icclmd.org'>https://zakat.icclmd.org</a>")
      vMsgText.Append("</span>")
      '*******************
      'uncomment next line
      '*******************
      'Dim vSend As Boolean = Base.sendEmail(vTo, vSubject, vMsgText.ToString)

      'email the validators that an application requires reviewing
      Using oDB As New zakatEntities
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.roleId = Base.enumRole.Validator).Any Then
          Dim oUserRoles As List(Of USER_ROLE) = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.roleId = Base.enumRole.Validator).ToList
          vTo = ""
          For Each item In oUserRoles
            vTo = IIf(vTo = "", item.USER.email, vTo + "," + item.USER.email)
          Next

          vSubject = "Online Zakat - Application Submitted"
          vMsgText.Clear()
          vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
          vMsgText.Append("Assalaamu Alaikum Validator(s),<br /><br />")
          vMsgText.Append("A new Zakat Application has been submitted and is awaiting validation. Please login and perform the necessary validation by clicking or copying/pasting the inbox link below:<br /><br />")
          vMsgText.Append("<b>Inbox Link: </b> <a target='_blank' href='https://zakat.icclmd.org/inbox'>https://zakat.icclmd.org/inbox</a><br /><br />")
          vMsgText.Append("If you have questions regarding the action you need to take, please don’t hesitate to contact the ICCL Zakat Administrator using the information below.<br /><br />")
          vMsgText.Append("Jazakum Allahu Khairan,<br /><br />")
          vMsgText.Append("ICCL Zakat Administrator<br />")
          vMsgText.Append("<a target='_blank' href='mailto:zakat@icclmd.org'>zakat@icclmd.org</a><br />")
          vMsgText.Append("301-317-4584<br />")
          vMsgText.Append("7306 Contee Road<br />")
          vMsgText.Append("Laurel, MD 20707<br />")
          vMsgText.Append("<a href='https://zakat.icclmd.org'>https://zakat.icclmd.org</a>")
          vMsgText.Append("</span>")
          '*******************
          'uncomment next line
          '*******************
          'Dim vSend As Boolean = Base.sendEmail(vTo, vSubject, vMsgText.ToString)
        End If

        'add a generic review action on behalf of the user
        Dim oReview As New REVIEW
        With oReview
          .userId = vUserId
          .applicationId = vApplicationId
          .reviewAction = "Submitted"
          .reviewDate = Date.Now
          .reviewComment = "I am submitting this zakat application for your review."
        End With

        ' Add to Memory
        oDB.REVIEW.Add(oReview)
        oDB.SaveChanges()

      End Using

      'redirect to the dashboard
      Response.Redirect("dashboard")

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub SaveZakatForm(pUserId As Int32, isSave As Boolean)
    Try
      Using oDB As New zakatEntities
        'check if the user exists or not, if not, exit sub
        If Not (From USER In oDB.USER Where USER.userId = pUserId).Any Then
          'verify user is in session or exit sub
          Exit Sub
        End If

        'save user data
        Dim oUser As USER = (From USER In oDB.USER Where USER.userId = pUserId).First
        With oUser
          .socialSecurityNumber = Base.getFormattedSSN(txtSocialSecurity.Text, Base.enumFormatSSN.Strip)
          .firstName = txtFirstName.Text
          .middleName = txtMiddleName.Text
          .lastName = txtLastName.Text
          If txtDOB.Text <> "" Then
            .dob = IIf(IsDate(txtDOB.Text), CDate(txtDOB.Text), Nothing)
          End If
          .phone = Base.getFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip)
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
          .husbandHasAppliedForZakat = chkHusbandApplied.SelectedValue
          .husbandZakatExplanation = txtHusbandExplanation.Text
          .primaryMasjidName = txtMasjidName.Text
          .primaryMasjidPhone = Base.getFormattedPhone(txtMasjidPhone.Text, Base.enumFormatPhone.Strip)
          .updatedBy = pUserId
          .updatedOn = Date.Now
        End With

        ' Add to Memory
        oDB.SaveChanges()

        'Using oDB As New zakatEntities
        'Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vUserId).First
        'set session variables:
        Session("sUserId") = pUserId
        Session("sIsApplicant") = True
        Session("sUserFirstName") = oUser.firstName
        'End Using

        'delete all saved languages
        If ((From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = pUserId).Any) Then
          'there are languages so delete them and read just add those in the form
          Dim oUserLanguages As List(Of USER_LANGUAGE) = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = pUserId).ToList
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
            .userId = pUserId
            .languageId = CInt(item.Value)
          End With
          oDB.USER_LANGUAGE.Add(oUserLanguage)
          oDB.SaveChanges()
        Next

        'delete all certs/skills
        If ((From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = pUserId).Any) Then
          'there are languages so delete them and read just add those in the form
          Dim oCertSkills As List(Of CERTIFICATION_SKILL) = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = pUserId).ToList
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
            .userId = pUserId
            .certificationSkill = item.Text
          End With
          oDB.CERTIFICATION_SKILL.Add(oCertSkill)
          oDB.SaveChanges()
        Next

        'check if an application has been started or not.  If so, load application data, if not create application data
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = pUserId And APPLICATION.isDrafted = True And APPLICATION.isSubmitted = False).Any Then
          'application already exists so save application
          Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = pUserId And APPLICATION.isDrafted = True And APPLICATION.isSubmitted = False).First
          With oApplication
            .userId = pUserId
            .organizationId = drpOrganization.SelectedValue
            .isDrafted = True
            .isSubmitted = False
            .isValidated = False
            .isInvestigated = False
            .isQualified1 = False
            .isQualified2 = False
            .IsDispersed = False
            .applicationStatus = "Drafted"
            .totalValueCash = txtValueCash.Text
            .totalValueGold = txtValueGold.Text
            .totalValueSilver = txtValueSilver.Text
            .totalValueInvestment = txtValueInvestment.Text
            .totalValueRetirement = txtValueRetirement.Text
            .hasRetirement = IIf(CInt(txtValueRetirement.Text) > 0, True, False)
            .totalValueLifeInsurance = txtValueLifeInsurance.Text
            .hasLifeInsurance = IIf(CInt(txtValueLifeInsurance.Text) > 0, True, False)
            .totalValueOutstandingDebts = txtValueDebt.Text
            .hasOutstandingDebts = IIf(CInt(txtValueDebt.Text) > 0, True, False)
            .totalChildSupport = txtValueChildSupport.Text
            .hasChildSupport = IIf(CInt(txtValueChildSupport.Text) > 0, True, False)
            .frequencyChildSupport = drpChildSupportFrequency.SelectedValue
            .totalFoodStamps = txtValueFoodStamps.Text
            .hasFoodStamps = IIf(CInt(txtValueFoodStamps.Text) > 0, True, False)
            .frequencyFoodStamps = drpFoodStampFrequency.SelectedValue
            .totalTemporaryCashAssistance = txtValueAssistance.Text
            .hasTemporaryCashAssistance = IIf(CInt(txtValueAssistance.Text) > 0, True, False)
            .sourceTemporaryCashAssistance = txtWhoAssisted.Text
            If (chkInsurance.SelectedValue <> "") Then
              .hasHealthInsurance = IIf(chkInsurance.SelectedValue = "Yes", True, False)
            End If
            .healthInsuranceProviderName = txtInsuranceProvider.Text
            .healthInsuranceProviderPolicyNumber = txtPolicyNumber.Text
            .medicareNumber = txtMedicare.Text
            .medicaidNumber = txtMedicaid.Text
            .employerName = txtEmployerName.Text
            If txtEmploymentStart.Text <> "" Then
              .employmentStartDate = IIf(IsDate(txtEmploymentStart.Text), CDate(txtEmploymentStart.Text), Nothing)
            End If
            If txtEmploymentEnd.Text <> "" Then
              .employmentEndtDate = IIf(IsDate(txtEmploymentEnd.Text), CDate(txtEmploymentEnd.Text), Nothing)
            End If
            .positionTitle = txtPosition.Text
            .employerPhone = Base.getFormattedPhone(txtEmployerPhone.Text, Base.enumFormatPhone.Strip)
            .totalMonthlyGrossSalary = txtMonthlySalary.Text
            .employerStreet = txtEmployerStreet.Text
            .employerCity = txtEmployerCity.Text
            .employerStateAbbr = drpEmployerState.SelectedValue
            .employerZip = txtEmployerZip.Text
            .personalNeedStatement = txtPersonalStatement.Text
            .updatedOn = Date.Now
            .updatedBy = pUserId
          End With
          'update db
          oDB.SaveChanges()
        Else
          'application does not exist so create new application
          Dim oApplication As New APPLICATION

          With oApplication
            .userId = pUserId
            .organizationId = drpOrganization.SelectedValue
            .isDrafted = True
            .isSubmitted = False
            .isValidated = False
            .isInvestigated = False
            .isQualified1 = False
            .isQualified2 = False
            .IsDispersed = False
            .applicationStatus = "Drafted"
            .totalValueCash = txtValueCash.Text
            .totalValueGold = txtValueGold.Text
            .totalValueSilver = txtValueSilver.Text
            .totalValueInvestment = txtValueInvestment.Text
            .totalValueRetirement = txtValueRetirement.Text
            .hasRetirement = IIf(CInt(txtValueRetirement.Text) > 0, True, False)
            .totalValueLifeInsurance = txtValueLifeInsurance.Text
            .hasLifeInsurance = IIf(CInt(txtValueLifeInsurance.Text) > 0, True, False)
            .totalValueOutstandingDebts = txtValueDebt.Text
            .hasOutstandingDebts = IIf(CInt(txtValueDebt.Text) > 0, True, False)
            .totalChildSupport = txtValueChildSupport.Text
            .hasChildSupport = IIf(CInt(txtValueChildSupport.Text) > 0, True, False)
            .frequencyChildSupport = drpChildSupportFrequency.SelectedValue
            .totalFoodStamps = txtValueChildSupport.Text
            .hasFoodStamps = IIf(CInt(txtValueChildSupport.Text) > 0, True, False)
            .frequencyFoodStamps = drpFoodStampFrequency.SelectedValue
            .totalTemporaryCashAssistance = txtValueAssistance.Text
            .hasTemporaryCashAssistance = IIf(CInt(txtValueAssistance.Text) > 0, True, False)
            .sourceTemporaryCashAssistance = txtWhoAssisted.Text
            If (chkInsurance.SelectedValue <> "") Then
              .hasHealthInsurance = IIf(chkInsurance.SelectedValue = "Yes", True, False)
            End If
            .healthInsuranceProviderName = txtInsuranceProvider.Text
            .healthInsuranceProviderPolicyNumber = txtPolicyNumber.Text
            .medicareNumber = txtMedicare.Text
            .medicaidNumber = txtMedicaid.Text
            .employerName = txtEmployerName.Text
            If txtEmploymentStart.Text <> "" Then
              .employmentStartDate = IIf(IsDate(txtEmploymentStart.Text), CDate(txtEmploymentStart.Text), Nothing)
            End If
            If txtEmploymentEnd.Text <> "" Then
              .employmentEndtDate = IIf(IsDate(txtEmploymentEnd.Text), CDate(txtEmploymentEnd.Text), Nothing)
            End If
            .positionTitle = txtPosition.Text
            .employerPhone = Base.getFormattedPhone(txtEmployerPhone.Text, Base.enumFormatPhone.Strip)
            .totalMonthlyGrossSalary = txtMonthlySalary.Text
            .employerStreet = txtEmployerStreet.Text
            .employerCity = txtEmployerCity.Text
            .employerStateAbbr = drpEmployerState.SelectedValue
            .employerZip = txtEmployerZip.Text
            .personalNeedStatement = txtPersonalStatement.Text
            .createdOn = Date.Now
            .createdBy = pUserId
            .updatedOn = Date.Now
            .updatedBy = pUserId
          End With
          'create in db
          oDB.APPLICATION.Add(oApplication)
          oDB.SaveChanges()
        End If
      End Using

      If isSave Then
        'refresh page
        Response.Redirect("zakatform")
      End If

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub
End Class