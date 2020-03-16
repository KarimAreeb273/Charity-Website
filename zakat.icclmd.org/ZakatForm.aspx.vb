﻿Public Class ZakatForm
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
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
          'drpState.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          drpEmployerState.DataSource = oState
          drpEmployerState.DataTextField = "stateName"
          drpEmployerState.DataValueField = "stateAbbr"
          drpEmployerState.DataBind()
          'drpEmployerState.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          drpRefState.DataSource = oState
          drpRefState.DataTextField = "stateName"
          drpRefState.DataValueField = "stateAbbr"
          drpRefState.DataBind()
          'drpRefState.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          drpSchoolState.DataSource = oState
          drpSchoolState.DataTextField = "stateName"
          drpSchoolState.DataValueField = "stateAbbr"
          drpSchoolState.DataBind()
          'drpSchoolState.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

          'load the nationality dropdown
          drpNationality.DataSource = (From NATIONALITY In oDB.NATIONALITY Order By NATIONALITY.name).ToList
          drpNationality.DataTextField = "name"
          drpNationality.DataValueField = "nationalityId"
          drpNationality.DataBind()
          'drpNationality.Items.Insert(0, New ListItem("(Select One)", "(Select One)"))

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
            'load the form for edit purposes if the user has an application in draft status
            'load user data into the form
            Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vUserId).First
            With oUser
              txtSocialSecurity.Text = .socialSecurityNumber
              txtFirstName.Text = .firstName
              txtMiddleName.Text = .middleName
              txtLastName.Text = .lastName
              txtDOB.Text = .dob
              txtPhone.Text = Base.getFormattedPhone(.phone, Base.enumFormatPhone.Format)
              chkGender.SelectedValue = .gender
              drpMaritalStatus.SelectedValue = .maritalStatus
              txtStreet.Text = .street
              txtCity.Text = .city
              drpState.SelectedValue = .stateAbbr
              txtZip.Text = .zip
              txtBeganLiving.Text = .beganLivingDate
              drpHomeType.SelectedValue = .homeType
              txtHomeType.Text = .homeTypeOther
              drpNationality.SelectedValue = IIf(.nationalityId = "", "(Select One)", .nationalityId)
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
              chkHusbandApplied.SelectedValue = .husbandHasAppliedForZakat
              txtHusbandExplanation.Text = .husbandZakatExplanation
              txtMasjidtName.Text = .primaryMasjidName
              txtMasjidPhone.Text = .primaryMasjidPhone
            End With

            'check if applciation data has been saved.  if so load it, if not do nothing
            If (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId And APPLICATION.isSaved = True And APPLICATION.isSubmitted <> True).Any Then
              'load application data
              Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId And APPLICATION.isSaved = True And APPLICATION.isSubmitted <> True).First

            End If

            'load the dependents repeater
            setDependents()
            'load the references repeater
            setReferences()
          End If
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

  Public Function GetDate(ByVal month As Short, ByVal day As Short) As Date
    GetDate = CDate(month.ToString + day.ToString + Today.Year.ToString)
  End Function

  Sub RefreshApplicantProgress()
    Try
      Dim v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27 As Boolean
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
      If (chkHusbandApplied.SelectedIndex = -1) Then
        v26 = False
      Else
        v26 = True
      End If
      If (txtHusbandExplanation.Text = "") Then
        v27 = False
      Else
        v27 = True
      End If


      Dim vProgress As Decimal
      Dim vPossible As Int16 = IIf(chkGender.SelectedValue = "Female" And drpMaritalStatus.SelectedValue = "Married", 26, 22)
      vPossible = IIf(drpHomeType.SelectedValue = "Other" And txtHomeType.Text <> "", vPossible + 1, vPossible)
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
      If (chkGender.SelectedValue = "Female" And drpMaritalStatus.SelectedValue = "Married") Then
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
      If (chkInsurance.SelectedIndex = -1) Then
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
        Dim oDependent As DEPDENDENT = (From DEPDENDENT In oDB.DEPDENDENT Where DEPDENDENT.dependentId = vDependentId).First
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
      Dim vUserId As Int32 = Session("sUserId")
      'If vUserId <> 0 Then
      Using oDB As New zakatEntities
        'update repeater
        Dim oReference_List As List(Of REFERENCE) = (From REFERENCE In oDB.REFERENCE Where REFERENCE.userId = vUserId).ToList
        rptReferences.DataSource = oReference_List
        rptReferences.DataBind()
        'set the badge
        lblReferences.Text = oReference_List.Count
      End Using
      'End If
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
        Dim oDependent As New DEPDENDENT

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
        oDB.DEPDENDENT.Add(oDependent)
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
      If chkGender.SelectedValue = "Female" And drpMaritalStatus.SelectedValue = "Married" Then
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
      If chkGender.SelectedValue = "Female" And drpMaritalStatus.SelectedValue = "Married" Then
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

      Using oDB As New zakatEntities
        Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vUserId).First
        'set session variables:
        Session("sUserId") = vUserId
        Session("sIsApplicant") = True
        Session("sUserFirstName") = oUser.firstName
      End Using

      'update all the values stored in the form by calling a common sub routine
      SaveZakatForm(vUserId)

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub SaveZakatForm(pUserId As Int32)
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
          .socialSecurityNumber = txtSocialSecurity.Text
          .firstName = txtFirstName.Text
          .middleName = txtMiddleName.Text
          .lastName = txtLastName.Text
          .dob = IIf(IsDate(txtDOB.Text), txtDOB.Text, Nothing)
          .phone = Base.getFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip)
          .gender = chkGender.SelectedValue
          .maritalStatus = drpMaritalStatus.SelectedValue
          .street = txtStreet.Text
          .city = txtCity.Text
          .stateAbbr = drpState.SelectedValue
          .zip = txtZip.Text
          .beganLivingDate = IIf(IsDate(txtBeganLiving.Text), txtBeganLiving.Text, Nothing)
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
          .husbandHasAppliedForZakat = chkHusbandApplied.SelectedValue
          .husbandZakatExplanation = txtHusbandExplanation.Text
          .primaryMasjidName = txtMasjidtName.Text
          .primaryMasjidPhone = txtMasjidPhone.Text
        End With

        ' Add to Memory
        oDB.SaveChanges()

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

        'check if an application has been start or not.  If so, load application data, if not create application data
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = pUserId And APPLICATION.isSaved = True).Any Then
          'application already exists so save application
          Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = pUserId And APPLICATION.isSaved = True).First
          With oApplication
            .userId = pUserId
            .organizationId = drpOrganization.SelectedValue
            .isSaved = True
            .isSubmitted = False
            .isValidated = False
            .isInvestigated = False
            .isQualified = False
            .approvalStatus = "Not Submitted"
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
            .hasHealthInsurance = IIf(chkInsurance.SelectedValue <> "", chkInsurance.SelectedValue, "")
            .healthInsuranceProviderName = txtInsuranceProvider.Text
            .healthInsuranceProviderPolicyNumber = txtPolicyNumber.Text
            .medicareNumber = txtMedicare.Text
            .medicaidNumber = txtMedicaid.Text
            .employerName = txtEmployerName.Text
            .employmentStartDate = IIf(IsDate(txtEmploymentStart.Text), txtEmploymentStart.Text, Nothing)
            .employmentEndtDate = IIf(IsDate(txtEmploymentEnd.Text), txtEmploymentEnd.Text, Nothing)
            .positionTitle = txtPosition.Text
            .employerPhone = txtEmployerPhone.Text
            .totalMonthlyGrossSalary = txtMonthlySalary.Text
            .employerStreet = txtEmployerStreet.Text
            .employerCity = txtEmployerCity.Text
            .employerStateAbbr = drpEmployerState.SelectedValue
            .employerZip = txtEmployerZip.Text
            .personalNeedStatement = txtPersonalStatement.Text
            .submittedDate = Date.Now()
          End With
          'update db
          oDB.SaveChanges()
        Else
          'application does not exist so create new application
          Dim oApplication As New APPLICATION

          With oApplication
            .userId = pUserId
            .organizationId = drpOrganization.SelectedValue
            .isSaved = True
            .isSubmitted = False
            .isValidated = False
            .isInvestigated = False
            .isQualified = False
            .approvalStatus = "Not Submitted"
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
            .hasHealthInsurance = IIf(chkInsurance.SelectedValue <> "", chkInsurance.SelectedValue, "")
            .healthInsuranceProviderName = txtInsuranceProvider.Text
            .healthInsuranceProviderPolicyNumber = txtPolicyNumber.Text
            .medicareNumber = txtMedicare.Text
            .medicaidNumber = txtMedicaid.Text
          End With
          'create in db
          oDB.APPLICATION.Add(oApplication)
          oDB.SaveChanges()
        End If
      End Using

      'redirect home
      'Response.Redirect("/")

    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

End Class