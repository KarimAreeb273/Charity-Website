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
        End With

      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

End Class