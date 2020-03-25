Public Class Application1
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      'Dim vUserId As Int32 = Session("sUserId")
      'Dim vApplicationId As Int32 = Session("sApplicationId")
      Dim vApplicationId As Int32 = 6
      'If vUserId = 0 Or vApplicationId = 0 Then Response.Redirect("/")

      'comment
      'lblApplication.Text = "The content for this Online Zakat Application #: " & Session("sApplicationId") & " will be placed here."

      Using oDB As New zakatEntities
        'verify if the user is a reviewer otherwise redirect home
        'If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId And (USER_ROLE.ROLE.name = "Validator" OrElse USER_ROLE.ROLE.name = "Investigator" OrElse USER_ROLE.ROLE.name = "Qualifier")).Any Then
        '  Response.Redirect("/")
        'End If

        Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First
        With oApplication
          txtEmail.Text = .USER.email
          txtFirstName.Text = .USER.firstName
          txtMiddleName.Text = .USER.middleName
          txtLastName.Text = .USER.lastName
          txtSocialSecurity.Text = .USER.socialSecurityNumber
          txtDOB.Text = .USER.dob
          txtPhone.Text = Base.getFormattedPhone(.USER.phone, Base.enumFormatPhone.Format)
          txtGender.Text = .USER.gender
          txtMaritalStatus.Text = .USER.maritalStatus
          txtStreet.Text = .USER.street
          txtCity.Text = .USER.city
          txtState.Text = .USER.STATE.stateName
          txtZip.Text = .USER.zip
          txtBeganLiving.Text = .USER.beganLivingDate
          txtHomeType.Text = .USER.homeType
          txtOtherHomeType.Text = .USER.homeTypeOther
          txtNationality.Text = .USER.NATIONALITY.name
          txtCitizenship.Text = .USER.citizenshipStatus
          txtHighestEducation.Text = .USER.highestEducationCompleted
          txtSchoolName.Text = .USER.schoolName
          txtSchoolStreet.Text = .USER.schoolStreet
          txtSchoolCity.Text = .USER.schoolCity
          txtSchoolState.Text = .USER.STATE.stateName
          txtSchoolZip.Text = .USER.schoolZip
          txtHusbandFirstName.Text = .USER.husbandFirstName
          txtHusbandMiddleName.Text = .USER.husbandMiddleName
          txtHusbandLastName.Text = .USER.husbandLastName
          txtHusbandApplied.Text = .USER.husbandHasAppliedForZakat
          txtHusbandExplanation.Text = .USER.husbandZakatExplanation
          txtMasjidName.Text = .USER.primaryMasjidName
          txtMasjidPhone.Text = .USER.primaryMasjidPhone

          'add saved languages to the list
          Dim vLanguages As String = ""
          If ((From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = .userId).Any) Then
            'there are languages so add in the form
            Dim oUserLanguages As List(Of USER_LANGUAGE) = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = .userId).ToList
            For Each item In oUserLanguages
              'concatenate user's spoken languages
              vLanguages = IIf(vLanguages = "", item.LANGUAGE.name, vLanguages + ", " + item.LANGUAGE.name)
            Next
          End If
          txtLanguages.Text = vLanguages

          'add saved skills/certs to the list
          Dim vCertSkills As String = ""
          If ((From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = .userId).Any) Then
            'there are skills/certs so add in the form
            Dim oCertSkills As List(Of CERTIFICATION_SKILL) = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = .userId).ToList
            For Each item In oCertSkills
              'obtain the skills/certs from the list and add from the db
              vCertSkills = IIf(vCertSkills = "", item.certificationSkill, vCertSkills + ", " + item.certificationSkill)
            Next
          End If
          txtCertSkills.Text = vCertSkills

          txtOrganization.Text = .ORGANIZATION.name
          txtValueCash.Text = FormatCurrency(.totalValueCash)
          txtValueGold.Text = FormatCurrency(.totalValueGold)
          txtValueSilver.Text = FormatCurrency(.totalValueSilver)
          txtValueInvestment.Text = FormatCurrency(.totalValueInvestment)
          txtValueRetirement.Text = FormatCurrency(.totalValueRetirement)
          txtValueLifeInsurance.Text = FormatCurrency(.totalValueLifeInsurance)
          txtValueDebt.Text = FormatCurrency(.totalValueOutstandingDebts)
          txtValueChildSupport.Text = FormatCurrency(.totalChildSupport)
          txtChildSupportFrequency.Text = .frequencyChildSupport
          txtValueFoodStamps.Text = FormatCurrency(.totalFoodStamps)
          txtFoodStampFrequency.Text = .frequencyFoodStamps
          txtValueAssistance.Text = FormatCurrency(.totalTemporaryCashAssistance)
          txtWhoAssisted.Text = .sourceTemporaryCashAssistance
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
          txtEmployerState.Text = .employerStateAbbr
          txtEmployerZip.Text = .employerZip
          txtPersonalStatement.Text = .personalNeedStatement

          'add dependents to form if there are any
          Dim vDependents As String = ""
          If ((From DEPENDENT In oDB.DEPENDENT Where DEPENDENT.userId = .userId).Any) Then
            'there are skills/certs so add in the form
            Dim oDependentList As List(Of DEPENDENT) = (From DEPENDENT In oDB.DEPENDENT Where DEPENDENT.userId = .userId).ToList
            For Each item In oDependentList
              'obtain the skills/certs from the list and add from the db
              vDependents = IIf(vDependents = "", item.firstName + " " + item.middleName + " " + item.lastName + " (" + item.relationship + ")", vDependents + ", " + item.firstName + " " + item.middleName + " " + item.lastName + " (" + item.relationship + ")")
            Next
          Else
            vDependents = "None"
          End If
          txtDependents.Text = vDependents

          'add reference to the form if any
          Dim oReference_List As List(Of REFERENCE) = (From REFERENCE In oDB.REFERENCE Where REFERENCE.userId = .userId).ToList
          rptReferences.DataSource = oReference_List
          rptReferences.DataBind()
        End With
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    getFormattedPhone = Base.getFormattedPhone(pPhone, Base.enumFormatPhone.Format)
  End Function


End Class