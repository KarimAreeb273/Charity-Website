Imports System.IO

Public Class Application1
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      Dim vApplicationId As Int32 = Session("sApplicationId")
      If vUserId = 0 Or vApplicationId = 0 Then Response.Redirect("/", False)

      If Not IsPostBack Then
        Using oDB As New zakatEntities
          Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First

          'obtain aggregates related to the users actions
          Dim oApplicationsDrafted As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDrafted = True).ToList
          Dim oApplicationsSubmitted As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isSubmitted = True).ToList
          Dim oApplicationsValidated As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isValidated = True).ToList
          Dim oApplicationsInvestigated As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isInvestigated = True).ToList
          Dim oApplicationsQualified1 As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isQualified1 = True).ToList
          Dim oApplicationsQualified2 As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isQualified2 = True).ToList
          Dim oApplicationsDispersed As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True).ToList
          Dim oApplicationsRejected As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isRejected = True).ToList

          'set aggregate values
          txtApplicationsSubmitted.Text = oApplicationsSubmitted.Count
          txtApplicationsApproved.Text = oApplicationsQualified2.Count
          txtApplicationsRejected.Text = oApplicationsRejected.Count

          'verify if the user is a reviewer otherwise redirect home
          If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId AndAlso (USER_ROLE.ROLE.name = "Administrator" OrElse (USER_ROLE.organizationId = oApplication.organizationId AndAlso (USER_ROLE.ROLE.name = "Validator" OrElse USER_ROLE.ROLE.name = "Investigator" OrElse USER_ROLE.ROLE.name = "Qualifier" OrElse USER_ROLE.ROLE.name = "Financier")))).Any Then
            Response.Redirect("/", False)
          End If

          'get the reviewer roles for displaying the correct review panel or none if a role has not been granted
          Dim oReviewer As List(Of USER_ROLE) = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId AndAlso (USER_ROLE.organizationId = oApplication.organizationId OrElse USER_ROLE.ROLE.name = "Administrator")).ToList
          Dim isValidator As Boolean = False
          Dim isInvestigator As Boolean = False
          Dim isQualifier As Boolean = False
          Dim isFinancier As Boolean = False

          For Each item In oReviewer
            Select Case item.roleId
              Case Base.enumRole.Validator
                isValidator = True
              Case Base.enumRole.Investigator
                isInvestigator = True
              Case Base.enumRole.Qualifier
                isQualifier = True
              Case Base.enumRole.Financier
                isFinancier = True
            End Select
          Next

          'load form with application data
          With oApplication
            btnEmail.NavigateUrl = "mailto:" & .USER.email
            txtUserId.Text = Base.GetFormattedNumber(.userId)
            btnEmail.Text = .USER.email
            txtEmail.Text = .USER.email
            txtFirstName.Text = .USER.firstName
            txtMiddleName.Text = .USER.middleName
            txtLastName.Text = .USER.lastName
            txtSocialSecurity.Text = Base.GetFormattedSSN(Base.DecryptString(.USER.socialSecurityNumberEncrypted), Base.enumFormatSSN.Format)
            txtDOB.Text = .USER.dob
            txtPhone.Text = Base.GetFormattedPhone(.USER.phone, Base.enumFormatPhone.Format)
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
            txtSchoolIsInternational.Text = IIf(.USER.isInternationalSchool, "Yes", "No")
            txtSchoolCountry.Text = IIf(.USER.isInternationalSchool, .USER.COUNTRY.name, "United States")
            txtSchoolName.Text = .USER.schoolName
            txtSchoolStreet.Text = .USER.schoolStreet
            txtSchoolCity.Text = .USER.schoolCity
            txtSchoolState.Text = .USER.STATE.stateName
            txtSchoolZip.Text = .USER.schoolZip
            txtHusbandFirstName.Text = .USER.husbandFirstName
            txtHusbandMiddleName.Text = .USER.husbandMiddleName
            txtHusbandLastName.Text = .USER.husbandLastName
            txtMasjidName.Text = .USER.primaryMasjidName
            txtMasjidPhone.Text = Base.GetFormattedPhone(.USER.primaryMasjidPhone, Base.enumFormatPhone.Format)

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

            'get previous applied date by getting the last submitted
            If (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId <> .applicationId And APPLICATION.userId = oApplication.userId And APPLICATION.isSubmitted = True Order By APPLICATION.submittedOn Descending).Any Then
              Dim oPreviousSubmitted As APPLICATION = (From APPLICATION In oDB.APPLICATION
                                                       Where APPLICATION.applicationId <> .applicationId And
                                                              APPLICATION.userId = oApplication.userId And
                                                              APPLICATION.isSubmitted = True
                                                       Order By APPLICATION.submittedOn Descending).First
              txtPreviouslyApplied.Text = FormatDateTime(oPreviousSubmitted.submittedOn, DateFormat.LongDate)
            Else
              txtPreviouslyApplied.Text = "N/A"
            End If

            'get previous applied date by getting the last submitted
            If (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId <> .applicationId And APPLICATION.userId = oApplication.userId And APPLICATION.isQualified2 = True Order By APPLICATION.qualified2On Descending).Any Then
              Dim oPreviousApproved As APPLICATION = (From APPLICATION In oDB.APPLICATION
                                                      Where APPLICATION.applicationId <> .applicationId And
                                                              APPLICATION.userId = oApplication.userId And
                                                              APPLICATION.isQualified2 = True
                                                      Order By APPLICATION.qualified2On Descending).First
              txtLastDateAssisted.Text = FormatDateTime(oPreviousApproved.qualified2On, DateFormat.LongDate)
            Else
              txtLastDateAssisted.Text = "N/A"
            End If

            txtApplicationId.Text = Base.GetFormattedNumber(.applicationId)
            txtOrganizationId.Value = .organizationId
            txtApplicationStatus.Text = .applicationStatus
            txtOrganization.Text = .ORGANIZATION.name
            txtHusbandApplied.Text = .husbandHasAppliedForZakat
            txtHusbandExplanation.Text = .husbandZakatExplanation
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
            If Not IsNothing(.isNotEmployed) Then
              txtNotEmployed.Text = IIf(.isNotEmployed, "No", "Yes")
            End If
            txtEmployerName.Text = .employerName
            txtEmploymentStart.Text = IIf(IsDate(.employmentStartDate), .employmentStartDate, "")
            txtEmploymentEnd.Text = IIf(IsDate(.employmentEndtDate), .employmentEndtDate, "")
            txtPosition.Text = .positionTitle
            txtEmployerPhone.Text = Base.GetFormattedPhone(.employerPhone, Base.enumFormatPhone.Format)
            txtMonthlySalary.Text = FormatCurrency(.totalMonthlyGrossSalary)
            txtEmployerStreet.Text = .employerStreet
            txtEmployerCity.Text = .employerCity
            txtEmployerState.Text = .employerStateAbbr
            txtEmployerZip.Text = .employerZip
            txtPersonalStatement.Text = .personalNeedStatement
            txtDispersedAmount.Text = IIf(.dispersedAmount Is Nothing, "", FormatCurrency(.dispersedAmount))
            txtDispersedAmount2.Text = IIf(.dispersedAmount Is Nothing, "", FormatCurrency(.dispersedAmount))
            lblDispersedAmount.Text = IIf(.dispersedAmount Is Nothing, "", FormatCurrency(.dispersedAmount))

            'set review panels; if isDispersed = true visible is already set to false so do nothing:
            If .isRejected = True Then
              pnlReviewComments.Visible = False
            ElseIf .isDispersed = True Then
              pnlReviewComments.Visible = False
            ElseIf .isQualified2 = True Then
              If isFinancier Then
                pnlDispersed.Visible = True
              Else
                pnlReviewComments.Visible = False
              End If
            ElseIf .isQualified1 = True Then
              If isQualifier Then
                pnlQualified2.Visible = True
              Else
                pnlReviewComments.Visible = False
              End If
            ElseIf .isInvestigated = True Then
              If isQualifier Then
                pnlQualified1.Visible = True
              Else
                pnlReviewComments.Visible = False
              End If
            ElseIf .isValidated = True Then
              If isInvestigator Then
                pnlInvestigated.Visible = True
              Else
                pnlReviewComments.Visible = False
              End If
            ElseIf .isSubmitted = True Then
              If isValidator Then
                pnlValidated.Visible = True
              Else
                pnlReviewComments.Visible = False
              End If
            ElseIf .isDrafted = True Then
              pnlReviewComments.Visible = False
            End If

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
            Dim oReferences As List(Of REFERENCE) = (From REFERENCE In oDB.REFERENCE Where REFERENCE.userId = .userId).ToList
            rptReferences.DataSource = oReferences
            rptReferences.DataBind()

            'add review history to the page and update the badge
            Dim oReviews As List(Of REVIEW) = (From REVIEW In oDB.REVIEW Where REVIEW.applicationId = vApplicationId).ToList
            rptReviewHistory.DataSource = oReviews
            rptReviewHistory.DataBind()
            lblReviewsCountBadge.Text = oReviews.Count

            'populate the artifact 
            Dim oArtifacts As List(Of ARTIFACT) = (From ARTIFACT In oDB.ARTIFACT Where ARTIFACT.applicationId = vApplicationId).ToList
            rptArtifacts.DataSource = oArtifacts
            rptArtifacts.DataBind()
            lblApplicationArtifacts.Text = oArtifacts.Count
          End With
        End Using

        'set the default date of dispersion to today
        txtDispersedDate.Text = CStr(FormatDateTime(Date.Now, DateFormat.ShortDate))

        'set charts
        setReport1(vApplicationId)
        setReport2(vApplicationId)
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnValidated_Click(sender As Object, e As EventArgs) Handles btnValidated.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      Dim vApplicationId As Int32 = Session("sApplicationId")
      If vUserId = 0 Or vApplicationId = 0 Then Response.Redirect("/", False)
      Dim vApplicationIdFormatted As String = Base.GetFormattedNumber(vApplicationId)

      Using oDB As New zakatEntities
        'check if an application exists.  If so, update data, if not redirect home
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).Any Then
          'application already exists so save application
          Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First
          With oApplication
            .isDrafted = True
            .isSubmitted = True
            .isValidated = True
            .isInvestigated = False
            .isQualified1 = False
            .isQualified2 = False
            .isDispersed = False
            .isRejected = False
            .applicationStatus = "Validated"
            .validatedBy = vUserId
            .validatedOn = Date.Now
            .updatedBy = vUserId
            .updatedOn = Date.Now
          End With
          ' Save in DB
          oDB.SaveChanges()
        Else
          Response.Redirect("/", False)
        End If

        'add a review action
        Dim oReview As New REVIEW
        With oReview
          .userId = vUserId
          .applicationId = vApplicationId
          .reviewAction = "Validated"
          .reviewDate = Date.Now
          .reviewComment = txtReviewComments.Text
        End With

        ' Add to DB
        oDB.REVIEW.Add(oReview)
        oDB.SaveChanges()

        'email the user about progess application
        Dim vTo As String = txtEmail.Text
        Dim vSubject As String = "Online Zakat - Application #: " & vApplicationIdFormatted & " Validated"
        Dim vMsgText As New StringBuilder
        Dim vSend As Boolean

        vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
        vMsgText.Append("Assalaamu Alaikum " & txtFirstName.Text & ",<br /><br />")
        vMsgText.Append("Your Zakat Application has been reviewed. The application was just validated. We will notify you when the application progresses past the next steps. You can also review the progress of your application online by logging in and either click or copy/paste the activity link below:<br /><br />")
        vMsgText.Append("<b>Activity Link: </b> <a target='_blank' href='https://zakat.icclmd.org/activity'>https://zakat.icclmd.org/activity</a><br /><br />")
        vMsgText.Append("If you have questions regarding the progress of your application, please don’t hesitate to contact us using the information below.<br /><br />")
        vMsgText.Append("Jazakum Allahu Khairan,<br /><br />")
        vMsgText.Append("ICCL Zakat Administrator<br />")
        vMsgText.Append("<a target='_blank' href='mailto:zakat@icclmd.org'>zakat@icclmd.org</a><br />")
        vMsgText.Append("301-317-4584<br />")
        vMsgText.Append("7306 Contee Road<br />")
        vMsgText.Append("Laurel, MD 20707<br />")
        vMsgText.Append("<a href='https://zakat.icclmd.org'>https://zakat.icclmd.org</a>")
        vMsgText.Append("</span>")
        vSend = Base.SendEmail(vTo, vSubject, vMsgText.ToString)

        'email the investigators that an application requires reviewing
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.roleId = Base.enumRole.Investigator And USER_ROLE.organizationId = CInt(txtOrganizationId.Value)).Any Then
          Dim oUserRoles As List(Of USER_ROLE) = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.roleId = Base.enumRole.Investigator And USER_ROLE.organizationId = CInt(txtOrganizationId.Value)).ToList
          vTo = ""
          For Each item In oUserRoles
            vTo = IIf(vTo = "", item.USER.email, vTo + "," + item.USER.email)
          Next

          vMsgText.Clear()
          vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
          vMsgText.Append("Assalaamu Alaikum Investigator(s),<br /><br />")
          vMsgText.Append("Zakat Application #: " & vApplicationIdFormatted & " has been reviewed. The application was just validated and now requires investigation. Please login and perform the necessary action by clicking or copying/pasting the inbox link below:<br /><br />")
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
          vSend = Base.SendEmail(vTo, vSubject, vMsgText.ToString)
        End If
      End Using

      'redirect back to the inbox
      Response.Redirect("inbox", False)

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnInvestigated_Click(sender As Object, e As EventArgs) Handles btnInvestigated.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      Dim vApplicationId As Int32 = Session("sApplicationId")
      If vUserId = 0 Or vApplicationId = 0 Then Response.Redirect("/", False)
      Dim vApplicationIdFormatted As String = Base.GetFormattedNumber(vApplicationId)

      Using oDB As New zakatEntities
        'check if an application exists.  If so, update data, if not redirect home
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).Any Then
          'application already exists so save application
          Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First
          With oApplication
            .isDrafted = True
            .isSubmitted = True
            .isValidated = True
            .isInvestigated = True
            .isQualified1 = False
            .isQualified2 = False
            .isDispersed = False
            .isRejected = False
            .applicationStatus = "Investigated"
            .investigatedBy = vUserId
            .investigatedOn = Date.Now
            .updatedBy = vUserId
            .updatedOn = Date.Now
          End With
          ' Save in DB
          oDB.SaveChanges()
        Else
          Response.Redirect("/", False)
        End If

        'add a review action
        Dim oReview As New REVIEW
        With oReview
          .userId = vUserId
          .applicationId = vApplicationId
          .reviewAction = "Investigated"
          .reviewDate = Date.Now
          .reviewComment = txtReviewComments.Text
        End With

        ' Add to Memory
        oDB.REVIEW.Add(oReview)
        oDB.SaveChanges()

        'email the user about progess application
        Dim vTo As String = txtEmail.Text
        Dim vSubject As String = "Online Zakat - Application #: " & vApplicationIdFormatted & " Investigated"
        Dim vMsgText As New StringBuilder
        Dim vSend As Boolean

        vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
        vMsgText.Append("Assalaamu Alaikum " & txtFirstName.Text & ",<br /><br />")
        vMsgText.Append("Your Zakat Application has been reviewed. The application was just investigated. We will notify you when the application progresses past the next steps. You can also review the progress of your application online by logging in and either click or copy/paste the activity link below:<br /><br />")
        vMsgText.Append("<b>Activity Link: </b> <a target='_blank' href='https://zakat.icclmd.org/activity'>https://zakat.icclmd.org/activity</a><br /><br />")
        vMsgText.Append("If you have questions regarding the progress of your application, please don’t hesitate to contact us using the information below.<br /><br />")
        vMsgText.Append("Jazakum Allahu Khairan,<br /><br />")
        vMsgText.Append("ICCL Zakat Administrator<br />")
        vMsgText.Append("<a target='_blank' href='mailto:zakat@icclmd.org'>zakat@icclmd.org</a><br />")
        vMsgText.Append("301-317-4584<br />")
        vMsgText.Append("7306 Contee Road<br />")
        vMsgText.Append("Laurel, MD 20707<br />")
        vMsgText.Append("<a href='https://zakat.icclmd.org'>https://zakat.icclmd.org</a>")
        vMsgText.Append("</span>")
        vSend = Base.SendEmail(vTo, vSubject, vMsgText.ToString)

        'email the qualifiers that an application requires reviewing
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.roleId = Base.enumRole.Qualifier And USER_ROLE.organizationId = CInt(txtOrganizationId.Value)).Any Then
          Dim oUserRoles As List(Of USER_ROLE) = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.roleId = Base.enumRole.Qualifier And USER_ROLE.organizationId = CInt(txtOrganizationId.Value)).ToList
          vTo = ""
          For Each item In oUserRoles
            vTo = IIf(vTo = "", item.USER.email, vTo + "," + item.USER.email)
          Next

          vMsgText.Clear()
          vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
          vMsgText.Append("Assalaamu Alaikum Qualifer(s),<br /><br />")
          vMsgText.Append("Zakat Application #: " & vApplicationIdFormatted & " has been reviewed. The application was just investigated and now requires initial qualifiation. Please login and perform the necessary action by clicking or copying/pasting the inbox link below:<br /><br />")
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
          vSend = Base.SendEmail(vTo, vSubject, vMsgText.ToString)
        End If
      End Using

      'redirect back to the inbox
      Response.Redirect("inbox", False)

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnQualified1_Click(sender As Object, e As EventArgs) Handles btnQualified1.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      Dim vApplicationId As Int32 = Session("sApplicationId")
      If vUserId = 0 Or vApplicationId = 0 Then Response.Redirect("/", False)
      Dim vApplicationIdFormatted As String = Base.GetFormattedNumber(vApplicationId)

      Using oDB As New zakatEntities
        'check if an application exists.  If so, update data, if not redirect home
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).Any Then
          'application already exists so save application
          Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First
          With oApplication
            .isDrafted = True
            .isSubmitted = True
            .isValidated = True
            .isInvestigated = True
            .isQualified1 = True
            .isQualified2 = False
            .isDispersed = False
            .isRejected = False
            .applicationStatus = "Qualified (Initial)"
            .qualified1By = vUserId
            .qualified1On = Date.Now
            .dispersedAmount = txtDispersedAmount1.Text
            .updatedBy = vUserId
            .updatedOn = Date.Now
          End With
          ' Save in DB
          oDB.SaveChanges()
        Else
          Response.Redirect("/", False)
        End If

        'add a review action
        Dim oReview As New REVIEW
        With oReview
          .userId = vUserId
          .applicationId = vApplicationId
          .reviewAction = "Qualified (Initial)"
          .reviewDate = Date.Now
          .reviewComment = txtReviewComments.Text
        End With

        ' Add to Memory
        oDB.REVIEW.Add(oReview)
        oDB.SaveChanges()

        'email the user about progess application
        Dim vTo As String = txtEmail.Text
        Dim vSubject As String = "Online Zakat - Application #: " & vApplicationIdFormatted & " Qualified (Initial)"
        Dim vMsgText As New StringBuilder
        Dim vSend As Boolean

        'email the validators that an application requires reviewing
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.roleId = Base.enumRole.Qualifier).Any Then
          Dim oUserRoles As List(Of USER_ROLE) = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.roleId = Base.enumRole.Qualifier And USER_ROLE.organizationId = CInt(txtOrganizationId.Value)).ToList
          vTo = ""
          For Each item In oUserRoles
            vTo = IIf(vTo = "", item.USER.email, vTo + "," + item.USER.email)
          Next

          vMsgText.Clear()
          vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
          vMsgText.Append("Assalaamu Alaikum Qualifier(s),<br /><br />")
          vMsgText.Append("Zakat Application #: " & vApplicationIdFormatted & " has been reviewed. The application was just initially qualified and now requires final qualification. Please login and perform the necessary action by clicking or copying/pasting the inbox link below:<br /><br />")
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
          vSend = Base.SendEmail(vTo, vSubject, vMsgText.ToString)
        End If
      End Using

      'redirect back to the inbox
      Response.Redirect("inbox", False)

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnQualified2_Click(sender As Object, e As EventArgs) Handles btnQualified2.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      Dim vApplicationId As Int32 = Session("sApplicationId")
      If vUserId = 0 Or vApplicationId = 0 Then Response.Redirect("/", False)
      Dim vApplicationIdFormatted As String = Base.GetFormattedNumber(vApplicationId)

      Using oDB As New zakatEntities
        'check if an application exists.  If so, update data, if not redirect home
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).Any Then
          'verify that qualifier 2 is not the same as qualifier 1
          Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First
          valQualifier.IsValid = True
          If vUserId = oApplication.qualified1By Then
            valQualifier.IsValid = False
            Exit Sub
          End If

          'application already exists so save application
          With oApplication
            .isDrafted = True
            .isSubmitted = True
            .isValidated = True
            .isInvestigated = True
            .isQualified1 = True
            .isQualified2 = True
            .isDispersed = False
            .isRejected = False
            .applicationStatus = "Qualified (Final)"
            .qualified2By = vUserId
            .qualified2On = Date.Now
            .dispersedAmount = txtDispersedAmount2.Text
            .updatedBy = vUserId
            .updatedOn = Date.Now
          End With
          ' Save in DB
          oDB.SaveChanges()
        Else
          Response.Redirect("/", False)
        End If

        'add a review action
        Dim oReview As New REVIEW
        With oReview
          .userId = vUserId
          .applicationId = vApplicationId
          .reviewAction = "Qualified (Final)"
          .reviewDate = Date.Now
          .reviewComment = txtReviewComments.Text
        End With

        ' Add to Memory
        oDB.REVIEW.Add(oReview)
        oDB.SaveChanges()

        'email the user about progess application
        Dim vTo As String = txtEmail.Text
        Dim vSubject As String = "Online Zakat - Application #: " & vApplicationIdFormatted & " Qualified"
        Dim vMsgText As New StringBuilder
        Dim vSend As Boolean

        vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
        vMsgText.Append("Assalaamu Alaikum " & txtFirstName.Text & ",<br /><br />")
        vMsgText.Append("Your Zakat Application has been reviewed. The application was just qualified. We will notify you when the application progresses past the next step. You can also review the progress of your application online by logging in and either click or copy/paste the activity link below:<br /><br />")
        vMsgText.Append("<b>Activity Link: </b> <a target='_blank' href='https://zakat.icclmd.org/activity'>https://zakat.icclmd.org/activity</a><br /><br />")
        vMsgText.Append("If you have questions regarding the progress of your application, please don’t hesitate to contact us using the information below.<br /><br />")
        vMsgText.Append("Jazakum Allahu Khairan,<br /><br />")
        vMsgText.Append("ICCL Zakat Administrator<br />")
        vMsgText.Append("<a target='_blank' href='mailto:zakat@icclmd.org'>zakat@icclmd.org</a><br />")
        vMsgText.Append("301-317-4584<br />")
        vMsgText.Append("7306 Contee Road<br />")
        vMsgText.Append("Laurel, MD 20707<br />")
        vMsgText.Append("<a href='https://zakat.icclmd.org'>https://zakat.icclmd.org</a>")
        vMsgText.Append("</span>")
        vSend = Base.SendEmail(vTo, vSubject, vMsgText.ToString)

        'email the validators that an application requires reviewing
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.roleId = Base.enumRole.Financier And USER_ROLE.organizationId = CInt(txtOrganizationId.Value)).Any Then
          Dim oUserRoles As List(Of USER_ROLE) = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.roleId = Base.enumRole.Financier And USER_ROLE.organizationId = CInt(txtOrganizationId.Value)).ToList
          vTo = ""
          For Each item In oUserRoles
            vTo = IIf(vTo = "", item.USER.email, vTo + "," + item.USER.email)
          Next

          vMsgText.Clear()
          vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
          vMsgText.Append("Assalaamu Alaikum Financier(s),<br /><br />")
          vMsgText.Append("Zakat Application #: " & vApplicationIdFormatted & " has been reviewed. The application was just qualified and now requires dispersion. Please login and perform the necessary action by clicking or copying/pasting the inbox link below:<br /><br />")
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
          vSend = Base.SendEmail(vTo, vSubject, vMsgText.ToString)
        End If
      End Using

      'redirect back to the inbox
      Response.Redirect("inbox", False)

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnDispersed_Click(sender As Object, e As EventArgs) Handles btnDispersed.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      Dim vApplicationId As Int32 = Session("sApplicationId")
      If vUserId = 0 Or vApplicationId = 0 Then Response.Redirect("/", False)
      Dim vApplicationIdFormatted As String = Base.GetFormattedNumber(vApplicationId)

      Using oDB As New zakatEntities
        'check if an application exists.  If so, update data, if not redirect home
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).Any Then
          'application already exists so save application
          Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First
          With oApplication
            .isDrafted = True
            .isSubmitted = True
            .isValidated = True
            .isInvestigated = True
            .isQualified1 = True
            .isQualified2 = True
            .isDispersed = True
            .isRejected = False
            .applicationStatus = "Dispersed"
            .dispersedBy = vUserId
            .dispersedOn = Date.Now
            .dispersedAmount = txtDispersedAmount.Text
            .updatedBy = vUserId
            .updatedOn = Date.Now
          End With
          ' Save in DB
          oDB.SaveChanges()
        Else
          Response.Redirect("/", False)
        End If

        'add a review action
        Dim oReview As New REVIEW
        With oReview
          .userId = vUserId
          .applicationId = vApplicationId
          .reviewAction = "Dispersed"
          .reviewDate = CDate(txtDispersedDate.Text)
          .reviewComment = txtReviewComments.Text
        End With

        ' Add to Memory
        oDB.REVIEW.Add(oReview)
        oDB.SaveChanges()

        'email the user about progess application
        Dim vTo As String = txtEmail.Text
        Dim vSubject As String = "Online Zakat - Application #: " & vApplicationIdFormatted & " Funds Dispersed"
        Dim vMsgText As New StringBuilder
        Dim vSend As Boolean

        vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
        vMsgText.Append("Assalaamu Alaikum " & txtFirstName.Text & ",<br /><br />")
        vMsgText.Append("The funds related to this application were just dispersed. As a result, we are closing the case related to your Zakat Application. This is the final message related to your Zakat Application. <br /><br />")
        vMsgText.Append("If you have questions regarding your application, please don’t hesitate to contact us using the information below.<br /><br />")
        vMsgText.Append("Jazakum Allahu Khairan,<br /><br />")
        vMsgText.Append("ICCL Zakat Administrator<br />")
        vMsgText.Append("<a target='_blank' href='mailto:zakat@icclmd.org'>zakat@icclmd.org</a><br />")
        vMsgText.Append("301-317-4584<br />")
        vMsgText.Append("7306 Contee Road<br />")
        vMsgText.Append("Laurel, MD 20707<br />")
        vMsgText.Append("<a href='https://zakat.icclmd.org'>https://zakat.icclmd.org</a>")
        vMsgText.Append("</span>")
        vSend = Base.SendEmail(vTo, vSubject, vMsgText.ToString)
      End Using

      'redirect back to the inbox
      Response.Redirect("inbox", False)

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnRejected_Click(sender As Object, e As EventArgs) Handles btnRejected.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      Dim vApplicationId As Int32 = Session("sApplicationId")
      If vUserId = 0 Or vApplicationId = 0 Then Response.Redirect("/", False)
      Dim vApplicationIdFormatted As String = Base.GetFormattedNumber(vApplicationId)

      Using oDB As New zakatEntities
        'check if an application exists.  If so, update data, if not redirect home
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).Any Then
          'application already exists so save application
          Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First
          With oApplication
            .isRejected = True
            .applicationStatus = "Rejected"
            .rejectedBy = vUserId
            .rejectedOn = Date.Now
            .updatedBy = vUserId
            .updatedOn = Date.Now
          End With
          ' Save in DB
          oDB.SaveChanges()
        Else
          Response.Redirect("/", False)
        End If

        'add a review action
        Dim oReview As New REVIEW
        With oReview
          .userId = vUserId
          .applicationId = vApplicationId
          .reviewAction = "Rejected"
          .reviewDate = Date.Now
          .reviewComment = txtReviewComments.Text
        End With

        ' Add to Memory
        oDB.REVIEW.Add(oReview)
        oDB.SaveChanges()

        'email the user about progess application
        Dim vTo As String = txtEmail.Text
        Dim vSubject As String = "Online Zakat - Application #: " & vApplicationIdFormatted & " Rejected"
        Dim vMsgText As New StringBuilder
        Dim vSend As Boolean

        vMsgText.Append("<span style='font-family: Calibri; font-size: 11pt'>")
        vMsgText.Append("Assalaamu Alaikum " & txtFirstName.Text & ",<br /><br />")
        vMsgText.Append("Your Zakat Application has been rejected for the following reason(s):<br /><br />")
        vMsgText.Append("<table style='width: 100%'><tr><td style='text-align: left; width: 50px'>&nbsp;</td><td style='text-align: left; width: 100%'><i style='color:red;font-family: Calibri; font-size: 11pt''>")
        vMsgText.Append(txtReviewComments.Text)
        vMsgText.Append("</i></td></tr></table><br />")
        vMsgText.Append("If you have questions regarding your application, please don’t hesitate to contact us using the information below.<br /><br />")
        vMsgText.Append("Jazakum Allahu Khairan,<br /><br />")
        vMsgText.Append("ICCL Zakat Administrator<br />")
        vMsgText.Append("<a target='_blank' href='mailto:zakat@icclmd.org'>zakat@icclmd.org</a><br />")
        vMsgText.Append("301-317-4584<br />")
        vMsgText.Append("7306 Contee Road<br />")
        vMsgText.Append("Laurel, MD 20707<br />")
        vMsgText.Append("<a href='https://zakat.icclmd.org'>https://zakat.icclmd.org</a>")
        vMsgText.Append("</span>")
        vSend = Base.SendEmail(vTo, vSubject, vMsgText.ToString)
      End Using

      'redirect back to the inbox
      Response.Redirect("inbox", False)

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    Try
      getFormattedPhone = Base.GetFormattedPhone(pPhone, Base.enumFormatPhone.Format)
    Catch ex As Exception
      Return Nothing
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Function

  Public Function getFormattedNumber(ByVal pNumber As Int32) As String
    Try
      getFormattedNumber = Base.GetFormattedNumber(pNumber)
    Catch ex As Exception
      Return Nothing
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Function

  Protected Sub btnDownloadArtifact_Click(sender As Object, e As System.EventArgs) Handles btnDownloadArtifact.Click
    Try
      'if artifact id = 0, redirect home
      Dim vArtifactId As Int32 = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
      If vArtifactId = 0 Then Response.Redirect("/", False)

      'Dim vBytes As Byte()
      Dim vFileName As String, vContentType As String

      Using oDB As New zakatEntities
        Dim oArtifact As ARTIFACT
        oArtifact = (From ARTIFACT In oDB.ARTIFACT Where ARTIFACT.artifactId = vArtifactId).First
        With oArtifact
          'vBytes = DirectCast(.data, Byte())
          vContentType = .contentType
          vFileName = .filename
        End With
        'perform download
        Response.Clear()
        Response.Buffer = True
        Response.Charset = ""
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.ContentType = vContentType
        'get the server artifact path
        Dim aArtifactPath As String = System.Configuration.ConfigurationManager.AppSettings("ArtifactPath")
        Dim vFilePath As String = Server.MapPath(aArtifactPath) + vFileName
        Response.AppendHeader("Content-Disposition", ("attachment; filename=" + Path.GetFileName(vFilePath)))
        Response.WriteFile(vFilePath)
        'Response.AppendHeader("Content-Disposition", "attachment; filename=" + vFileName)
        'Response.BinaryWrite(vBytes)
        Response.Flush()
        Response.End()
      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub txtReviewComments_TextChanged(sender As Object, e As EventArgs) Handles txtReviewComments.TextChanged
    Try
      updateForm()
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub txtDispersedAmount1_TextChanged(sender As Object, e As EventArgs) Handles txtDispersedAmount1.TextChanged
    Try
      updateForm()
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub txtDispersedAmount2_TextChanged(sender As Object, e As EventArgs) Handles txtDispersedAmount2.TextChanged
    Try
      updateForm()
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Sub updateForm()
    Try
      If txtReviewComments.Text <> "" Then
        If pnlValidated.Visible = True Then
          btnValidated.Enabled = True
          btnRejected1.Disabled = False
        ElseIf pnlInvestigated.Visible = True Then
          btnInvestigated.Enabled = True
          btnRejected2.Disabled = False
        ElseIf pnlQualified1.Visible = True Then
          If txtDispersedAmount1.Text <> "" Then
            btnQualified1.Enabled = True
            btnRejected3.Disabled = False
          Else
            btnQualified1.Enabled = False
            btnRejected3.Disabled = True
          End If
        ElseIf pnlQualified2.Visible = True Then
          If txtDispersedAmount2.Text <> "" Then
            btnQualified2.Enabled = True
            btnRejected4.Disabled = False
          Else
            btnQualified2.Enabled = False
            btnRejected4.Disabled = True
          End If
        ElseIf pnlDispersed.Visible = True Then
          If txtDispersedAmount.Text <> "" And txtDispersedDate.Text <> "" Then
            btnDispersed.Enabled = True
            btnRejected5.Disabled = False
          Else
            btnDispersed.Enabled = False
            btnRejected5.Disabled = True
          End If
        End If
      Else
        btnValidated.Enabled = False
        btnInvestigated.Enabled = False
        btnQualified1.Enabled = False
        btnQualified2.Enabled = False
        btnDispersed.Enabled = False
        btnRejected1.Disabled = True
        btnRejected2.Disabled = True
        btnRejected3.Disabled = True
        btnRejected4.Disabled = True
        btnRejected5.Disabled = True
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub txtDispersedAmount_TextChanged(sender As Object, e As EventArgs) Handles txtDispersedAmount.TextChanged
    Try
      updateForm()
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub txtDispersedDate_TextChanged(sender As Object, e As EventArgs) Handles txtDispersedDate.TextChanged
    Try
      updateForm()
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Sub setReport1(vApplicationId As Int32)
    Try
      'create a pie chart of zakat applications approved vs rejected
      Using oDB As New zakatEntities
        Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First

        'obtain aggregates related to the users actions
        Dim oApplicationsApproved As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isQualified2 = True).ToList
        Dim oApplicationsRejected As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isRejected = True).ToList

        Dim vJscript As New StringBuilder
        vJscript.Append("google.charts.load('current', {'packages':['corechart']});")
        vJscript.Append("google.charts.setOnLoadCallback(drawChart);")
        vJscript.Append("function drawChart() {")
        vJscript.Append("var data = google.visualization.arrayToDataTable([")
        vJscript.Append("['Status', 'Count'],")
        vJscript.Append("['Approved'," & oApplicationsApproved.Count & "],")
        vJscript.Append("['Rejected'," & oApplicationsRejected.Count & "]")
        vJscript.Append("]);")
        vJscript.Append("var options = {")
        vJscript.Append(" title: ''")
        lblReport1.Text = oApplication.USER.firstName & " " & oApplication.USER.middleName & " " & oApplication.USER.lastName & " - Final Application Status"
        vJscript.Append("};")
        vJscript.Append("var chart = new google.visualization.PieChart(document.getElementById('divReport1'));")
        vJscript.Append("chart.draw(data, options);")
        vJscript.Append("}")

        'begin load values from the list
        Dim cScript As New HtmlGenericControl
        cScript.TagName = "script"
        cScript.Attributes.Add("type", "text/javascript")
        cScript.InnerHtml = vJscript.ToString
        phReport1.Controls.Add(cScript)
      End Using

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Sub setReport2(vApplicationId As Int32)
    Try
      'create a bar chart of zakat applications approved by period
      Using oDB As New zakatEntities
        Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = vApplicationId).First
        lblReport2.Text = oApplication.USER.firstName & " " & oApplication.USER.middleName & " " & oApplication.USER.lastName & " - Zakat Approved By Period"
        Dim vCurrentMonth As Int32 = Date.Now.Month
        Dim vMonthName1 As String = ""
        Dim vMonthName2 As String = ""
        Dim vMonthName3 As String = ""
        Dim vMonthAmount1 As Int32 = 0
        Dim vMonthAmount2 As Int32 = 0
        Dim vMonthAmount3 As Int32 = 0
        Dim vTotalAmount As Int32 = 0

        Dim oAppTotal As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True).ToList
        For Each item In oAppTotal
          vTotalAmount = vTotalAmount + item.dispersedAmount
        Next

        Dim oAppMonth1 As List(Of APPLICATION)
        Dim oAppMonth2 As List(Of APPLICATION)
        Dim oAppMonth3 As List(Of APPLICATION)

        If vCurrentMonth = 1 Then
          vMonthName1 = "Nov " & (Date.Now.Year - 1).ToString
          vMonthName2 = "Dec " & (Date.Now.Year - 1).ToString
          vMonthName3 = "Jan " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("11/01/" & (Date.Now.Year - 1).ToString) And APPLICATION.dispersedOn <= CDate("11/30/" & (Date.Now.Year - 1).ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("12/01/" & (Date.Now.Year - 1).ToString) And APPLICATION.dispersedOn <= CDate("12/31/" & (Date.Now.Year - 1).ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("01/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("01/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 2 Then
          vMonthName1 = "Dec " & (Date.Now.Year - 1).ToString
          vMonthName2 = "Jan " & Date.Now.Year.ToString
          vMonthName3 = "Feb " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("12/01/" & (Date.Now.Year - 1).ToString) And APPLICATION.dispersedOn <= CDate("12/31/" & (Date.Now.Year - 1).ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("01/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("01/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("02/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("02/28/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 3 Then
          vMonthName1 = "Jan " & Date.Now.Year.ToString
          vMonthName2 = "Feb " & Date.Now.Year.ToString
          vMonthName3 = "Mar " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("01/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("01/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("02/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("02/28/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("03/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("03/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 4 Then
          vMonthName1 = "Feb " & Date.Now.Year.ToString
          vMonthName2 = "Mar " & Date.Now.Year.ToString
          vMonthName3 = "Apr " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("02/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("02/28/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("03/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("03/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("04/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("04/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 5 Then
          vMonthName1 = "Mar " & Date.Now.Year.ToString
          vMonthName2 = "Apr " & Date.Now.Year.ToString
          vMonthName3 = "May " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("03/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("03/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("04/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("04/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("05/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("05/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 6 Then
          vMonthName1 = "Apr " & Date.Now.Year.ToString
          vMonthName2 = "May " & Date.Now.Year.ToString
          vMonthName3 = "Jun " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("04/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("04/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("05/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("05/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("06/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("06/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 7 Then
          vMonthName1 = "May " & Date.Now.Year.ToString
          vMonthName2 = "Jun " & Date.Now.Year.ToString
          vMonthName3 = "Jul " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("05/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("05/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("06/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("06/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("07/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("07/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 8 Then
          vMonthName1 = "Jun " & Date.Now.Year.ToString
          vMonthName2 = "Jul " & Date.Now.Year.ToString
          vMonthName3 = "Aug " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("06/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("06/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("07/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("07/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("08/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("08/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 9 Then
          vMonthName1 = "Jul " & Date.Now.Year.ToString
          vMonthName2 = "Aug " & Date.Now.Year.ToString
          vMonthName3 = "Sep " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("07/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("07/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("08/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("08/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("09/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("09/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 10 Then
          vMonthName1 = "Aug " & Date.Now.Year.ToString
          vMonthName2 = "Sep " & Date.Now.Year.ToString
          vMonthName3 = "Oct " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("08/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("08/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("09/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("09/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("10/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("10/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 11 Then
          vMonthName1 = "Sep " & Date.Now.Year.ToString
          vMonthName2 = "Oct " & Date.Now.Year.ToString
          vMonthName3 = "Nov " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("09/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("09/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("10/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("10/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("11/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("11/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        ElseIf vCurrentMonth = 12 Then
          vMonthName1 = "Oct " & Date.Now.Year.ToString
          vMonthName2 = "Nov " & Date.Now.Year.ToString
          vMonthName3 = "Dec " & Date.Now.Year.ToString
          oAppMonth1 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("10/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("10/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth1
            vMonthAmount1 = vMonthAmount1 + item.dispersedAmount
          Next
          oAppMonth2 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("11/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("11/30/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth2
            vMonthAmount2 = vMonthAmount2 + item.dispersedAmount
          Next
          oAppMonth3 = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = oApplication.userId And APPLICATION.isDispersed = True And APPLICATION.dispersedOn >= CDate("12/01/" & Date.Now.Year.ToString) And APPLICATION.dispersedOn <= CDate("12/31/" & Date.Now.Year.ToString)).ToList
          For Each item In oAppMonth3
            vMonthAmount3 = vMonthAmount3 + item.dispersedAmount
          Next
        End If

        Dim vJscript As New StringBuilder
        vJscript.Append("google.charts.load('current', {packages: ['corechart', 'bar']});")
        vJscript.Append("google.charts.setOnLoadCallback(drawBasic);")
        vJscript.Append("function drawBasic() {")
        vJscript.Append("var data = google.visualization.arrayToDataTable([")
        vJscript.Append("['Period', 'Amount', { role: 'style' }, { role: 'annotation' } ],")
        vJscript.Append("['All Time', " & vTotalAmount & ", 'color: blue', 'All Time'],")
        vJscript.Append("['" & vMonthName1 & "', " & vMonthAmount1 & ", 'color: blue', '" & vMonthName1 & "'],")
        vJscript.Append("['" & vMonthName2 & "', " & vMonthAmount2 & ", 'color: blue', '" & vMonthName2 & "'],")
        vJscript.Append("['" & vMonthName3 & "', " & vMonthAmount3 & ", 'color: blue', '" & vMonthName3 & "']")
        vJscript.Append("]);")
        vJscript.Append("var options = {")
        vJscript.Append("title: '',")
        vJscript.Append("chartArea: {width: '50%'},")
        vJscript.Append("hAxis: {")
        vJscript.Append("title: 'Total Amount Approved ($)',")
        vJscript.Append("minValue: 0")
        vJscript.Append("},")
        vJscript.Append("vAxis: {")
        vJscript.Append("title: 'Period of Time'")
        vJscript.Append("}")
        vJscript.Append("};")
        vJscript.Append("var chart = new google.visualization.BarChart(document.getElementById('divReport2'));")
        vJscript.Append("chart.draw(data, options);")
        vJscript.Append("}")

        'begin load values from the list
        Dim cScript As New HtmlGenericControl
        cScript.TagName = "script"
        cScript.Attributes.Add("type", "text/javascript")
        cScript.InnerHtml = vJscript.ToString
        phReport2.Controls.Add(cScript)
      End Using

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

End Class