Public Class Users
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      Response.Write("")

      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")
      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId And USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/")
        End If
      End Using

      'set users repeater
      setUsers()
      'set applicant repeater
      setApplicants()
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
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setUsers()
    Try
      'update user repeater and update the badge
      Using oDB As New zakatEntities
        rptUsers.DataSource = (From USER_ROLE In oDB.USER_ROLE
                               Where USER_ROLE.roleId <> Base.enumRole.Appliciant
                               Select New With {Key .userId = USER_ROLE.userId,
                                                Key .phone = USER_ROLE.USER.phone,
                                                Key .fullName = USER_ROLE.USER.firstName & " " & USER_ROLE.USER.middleName & " " & USER_ROLE.USER.lastName,
                                                Key .email = USER_ROLE.USER.email}).Distinct.ToList
        rptUsers.DataBind()
        lblUsersCountBadge.Text = rptUsers.Items.Count
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub setApplicants()
    Try
      'update user repeater and update the badge
      Using oDB As New zakatEntities
        rptApplicant.DataSource = (From USER_ROLE In oDB.USER_ROLE
                                   Where USER_ROLE.roleId = Base.enumRole.Appliciant
                                   Select New With {Key .userId = USER_ROLE.userId,
                                                Key .phone = USER_ROLE.USER.phone,
                                                Key .fullName = USER_ROLE.USER.firstName & " " & USER_ROLE.USER.middleName & " " & USER_ROLE.USER.lastName,
                                                Key .email = USER_ROLE.USER.email}).ToList
        rptApplicant.DataBind()
        lblApplicantsCountBadge.Text = rptApplicant.Items.Count
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Protected Sub btnEdit_Click(sender As Object, e As EventArgs) Handles btnEdit.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = sender.CommandArgument
      If vUserId = 0 Then Response.Redirect("/")
      'set org session id and redirect
      Session("sOtherUserId") = vUserId
      'redirect to users edit
      Response.Redirect("useredit")
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnAddUser_Click(sender As Object, e As EventArgs) Handles btnAddUser.Click
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      If vUserId = 0 Then Response.Redirect("/")

      Using oDB As New zakatEntities
        'check if the user has admin role
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId And USER_ROLE.ROLE.name = "Administrator").Any Then
          'reset validator
          valDuplicateEmail.IsValid = True
          'validate that its not already registered by a user
          If (From USER In oDB.USER Where USER.email = txtEmail.Text).Any Then
            valDuplicateEmail.IsValid = False
            Exit Sub
          End If

          'get the "Placeholder" organization
          Dim oOrganization As ORGANIZATION = (From ORGANIZATION In oDB.ORGANIZATION Where ORGANIZATION.name = "Placeholder").First
          Dim vOrganizationId As Int32 = oOrganization.organizationId

          'add new user
          Dim vNewUserId As Int32
          vNewUserId = Base.createUser(Base.enumRole.General, vOrganizationId, txtEmail.Text, txtFirstName.Text, txtLastName.Text, txtMiddleName.Text, Base.getFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip))

          'update the org repeater
          setUsers()

          'clear fields
          txtEmail.Text = ""
          txtFirstName.Text = ""
          txtMiddleName.Text = ""
          txtLastName.Text = ""
          txtPhone.Text = ""
        Else
          'redirect home
          Response.Redirect("/")
        End If
      End Using

      'refresh page
      Response.Redirect("users")
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function getFormattedPhone(ByVal pPhone As String) As String
    getFormattedPhone = Base.getFormattedPhone(pPhone, Base.enumFormatPhone.Format)
  End Function

  Protected Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
    Try
      Dim vMyUserId As Int32 = Session("sUserId")
      'go home if no session/user
      Dim vUserId As Int32 = sender.CommandArgument
      If vUserId = 0 Then Response.Redirect("/")

      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vMyUserId And USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/")
        End If

        'delete all certificates/skills
        If (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oCertSkills As List(Of CERTIFICATION_SKILL) = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vUserId).ToList
          For Each item In oCertSkills
            ' delete the record
            Dim oCertSkill As CERTIFICATION_SKILL = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.certificationSkillId = item.certificationSkillId).First
            oDB.CERTIFICATION_SKILL.Remove(oCertSkill)
            oDB.SaveChanges()
          Next
        End If

        'delete all user roles
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oUserRoles As List(Of USER_ROLE) = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId).ToList
          For Each item In oUserRoles
            ' delete the record
            Dim oUserRole As USER_ROLE = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userRoleId = item.userRoleId).First
            oDB.USER_ROLE.Remove(oUserRole)
            oDB.SaveChanges()
          Next
        End If

        'delete user languages
        If (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oUserLanguages As List(Of USER_LANGUAGE) = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vUserId).ToList
          For Each item In oUserLanguages
            ' delete the record
            Dim oUserLanguage As USER_LANGUAGE = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userLanguageId = item.userLanguageId).First
            oDB.USER_LANGUAGE.Remove(oUserLanguage)
            oDB.SaveChanges()
          Next
        End If

        'delete references
        If (From REFERENCE In oDB.REFERENCE Where REFERENCE.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oReferences As List(Of REFERENCE) = (From REFERENCE In oDB.REFERENCE Where REFERENCE.userId = vUserId).ToList
          For Each item In oReferences
            ' delete the record
            Dim oReference As REFERENCE = (From REFERENCE In oDB.REFERENCE Where REFERENCE.referenceId = item.referenceId).First
            oDB.REFERENCE.Remove(oReference)
            oDB.SaveChanges()
          Next
        End If

        'delete reviews
        If (From REVIEW In oDB.REVIEW Where REVIEW.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oReviews As List(Of REVIEW) = (From REVIEW In oDB.REVIEW Where REVIEW.userId = vUserId).ToList
          For Each item In oReviews
            ' delete the record
            Dim oReview As REVIEW = (From REVIEW In oDB.REVIEW Where REVIEW.reviewId = item.reviewId).First
            oDB.REVIEW.Remove(oReview)
            oDB.SaveChanges()
          Next
        End If

        'delete applications
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oApplications As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId).ToList
          For Each applicationItem In oApplications
            'delete artifacts
            If (From ARTIFACT In oDB.ARTIFACT Where ARTIFACT.applicationId = applicationItem.applicationId).Any Then
              'get all the records related to the application
              Dim oArtifacts As List(Of ARTIFACT) = (From ARTIFACT In oDB.ARTIFACT Where ARTIFACT.applicationId = applicationItem.applicationId).ToList
              For Each artifactItem In oArtifacts
                ' delete the related record
                Dim oArtifact As ARTIFACT = (From ARTIFACT In oDB.ARTIFACT Where ARTIFACT.artifactId = artifactItem.artifactId).First
                oDB.ARTIFACT.Remove(oArtifact)
                oDB.SaveChanges()
              Next
            End If

            ' delete the record
            Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = applicationItem.applicationId).First
            oDB.APPLICATION.Remove(oApplication)
            oDB.SaveChanges()
          Next
        End If

        'delete user
        If (From USER In oDB.USER Where USER.userId = vUserId).Any Then
          ' delete the record
          Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vUserId).First
          oDB.USER.Remove(oUser)
          oDB.SaveChanges()
        End If
      End Using
      'redirect to users
      Response.Redirect("users")
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Public Function GetFormattedNumber(ByVal pMemberId As Int32) As String
    Try
      GetFormattedNumber = Base.getFormattedNumber(pMemberId)
    Catch ex As Exception
      Return Nothing
      Response.Write(ex.Message)
    End Try
  End Function

  Protected Sub btnEditApplicant_Click(sender As Object, e As EventArgs)
    Try
      'go home if no session/user
      Dim vUserId As Int32 = sender.CommandArgument
      If vUserId = 0 Then Response.Redirect("/")
      'set org session id and redirect
      Session("sOtherUserId") = vUserId
      'redirect to users edit
      Response.Redirect("useredit")
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Protected Sub btnDeleteApplicant_Click(sender As Object, e As EventArgs)
    Try
      Dim vMyUserId As Int32 = Session("sUserId")
      'go home if no session/user
      Dim vUserId As Int32 = sender.CommandArgument
      If vUserId = 0 Then Response.Redirect("/")

      Using oDB As New zakatEntities
        'verify if the user is an administrator otherwise redirect home
        If Not (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vMyUserId And USER_ROLE.ROLE.name = "Administrator").Any Then
          Response.Redirect("/")
        End If

        'delete all certificates/skills
        If (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oCertSkills As List(Of CERTIFICATION_SKILL) = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.userId = vUserId).ToList
          For Each item In oCertSkills
            ' delete the record
            Dim oCertSkill As CERTIFICATION_SKILL = (From CERTIFICATION_SKILL In oDB.CERTIFICATION_SKILL Where CERTIFICATION_SKILL.certificationSkillId = item.certificationSkillId).First
            oDB.CERTIFICATION_SKILL.Remove(oCertSkill)
            oDB.SaveChanges()
          Next
        End If

        'delete user languages
        If (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oUserLanguages As List(Of USER_LANGUAGE) = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userId = vUserId).ToList
          For Each item In oUserLanguages
            ' delete the record
            Dim oUserLanguage As USER_LANGUAGE = (From USER_LANGUAGE In oDB.USER_LANGUAGE Where USER_LANGUAGE.userLanguageId = item.userLanguageId).First
            oDB.USER_LANGUAGE.Remove(oUserLanguage)
            oDB.SaveChanges()
          Next
        End If

        'delete dependents
        If (From DEPENDENT In oDB.DEPENDENT Where DEPENDENT.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oDependents As List(Of DEPENDENT) = (From DEPENDENT In oDB.DEPENDENT Where DEPENDENT.userId = vUserId).ToList
          For Each item In oDependents
            ' delete the record
            Dim oDependent As DEPENDENT = (From DEPENDENT In oDB.DEPENDENT Where DEPENDENT.dependentId = item.dependentId).First
            oDB.DEPENDENT.Remove(oDependent)
            oDB.SaveChanges()
          Next
        End If

        'delete references
        If (From REFERENCE In oDB.REFERENCE Where REFERENCE.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oReferences As List(Of REFERENCE) = (From REFERENCE In oDB.REFERENCE Where REFERENCE.userId = vUserId).ToList
          For Each item In oReferences
            ' delete the record
            Dim oReference As REFERENCE = (From REFERENCE In oDB.REFERENCE Where REFERENCE.referenceId = item.referenceId).First
            oDB.REFERENCE.Remove(oReference)
            oDB.SaveChanges()
          Next
        End If

        'delete applications
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oApplications As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.userId = vUserId).ToList
          For Each applicationItem In oApplications
            'delete related artifacts
            If (From ARTIFACT In oDB.ARTIFACT Where ARTIFACT.applicationId = applicationItem.applicationId).Any Then
              'get all the records related to the application
              Dim oArtifacts As List(Of ARTIFACT) = (From ARTIFACT In oDB.ARTIFACT Where ARTIFACT.applicationId = applicationItem.applicationId).ToList
              For Each artifactItem In oArtifacts
                ' delete the related record
                Dim oArtifact As ARTIFACT = (From ARTIFACT In oDB.ARTIFACT Where ARTIFACT.artifactId = artifactItem.artifactId).First
                oDB.ARTIFACT.Remove(oArtifact)
                oDB.SaveChanges()
              Next
            End If

            'delete related reviews
            If (From REVIEW In oDB.REVIEW Where REVIEW.applicationId = applicationItem.applicationId).Any Then
              'get all the records related to the user
              Dim oReviews As List(Of REVIEW) = (From REVIEW In oDB.REVIEW Where REVIEW.applicationId = applicationItem.applicationId).ToList
              For Each reviewItem In oReviews
                ' delete the record
                Dim oReview As REVIEW = (From REVIEW In oDB.REVIEW Where REVIEW.reviewId = reviewItem.reviewId).First
                oDB.REVIEW.Remove(oReview)
                oDB.SaveChanges()
              Next
            End If

            ' delete the record
            Dim oApplication As APPLICATION = (From APPLICATION In oDB.APPLICATION Where APPLICATION.applicationId = applicationItem.applicationId).First
            oDB.APPLICATION.Remove(oApplication)
            oDB.SaveChanges()
          Next
        End If

        'delete all user roles
        If (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId).Any Then
          'get all the records related to the user
          Dim oUserRoles As List(Of USER_ROLE) = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = vUserId).ToList
          For Each item In oUserRoles
            ' delete the record
            Dim oUserRole As USER_ROLE = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userRoleId = item.userRoleId).First
            oDB.USER_ROLE.Remove(oUserRole)
            oDB.SaveChanges()
          Next
        End If

        'delete user
        If (From USER In oDB.USER Where USER.userId = vUserId).Any Then
          ' delete the record
          Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vUserId).First
          oDB.USER.Remove(oUser)
          oDB.SaveChanges()
        End If
      End Using
      'redirect to users
      Response.Redirect("users")
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

End Class