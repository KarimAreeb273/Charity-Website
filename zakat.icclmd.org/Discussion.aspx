<%@ Page Title="User Forum" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Discussion.aspx.vb" Inherits="zakat.icclmd.org.Discussion" MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <style type="text/css">
    body {
      font-family: inherit;
      font-size: 12px;
    }
    /* Accordion */
    .accordionHeader {
      border: 1px solid #2F4F4F;
      color: black;
      background-color: #f5f5f5;
      font-family: inherit;
      font-size: 12px;
      font-weight: bold;
      padding: 5px;
      margin-top: 5px;
      cursor: pointer;
      overflow: hidden;
    }

    #master_content .accordionHeader a {
      color: #FFFFFF;
      background: none;
      text-decoration: none;
    }

      #master_content .accordionHeader a:hover {
        background: none;
        text-decoration: underline;
      }

    .accordionHeaderSelected {
      border: 1px solid #2F4F4F;
      color: white;
      background-color: black;
      font-family: inherit;
      font-size: 12px;
      font-weight: bold;
      padding: 5px;
      margin-top: 5px;
      cursor: pointer;
      overflow: hidden;
    }

    .accordionContent {
      overflow: hidden;
    }
  </style>
  <br />
  <br />
  <br />
  <table style="width: 100%" border="0">
    <tr>
      <td style="width: 20%;">
        <asp:Panel ID="pnlNavigateShow" runat="server" Visible="true" Width="170px" Height="800px" BorderStyle="Solid">
          <table style="width: 100%" border="0">
            <tr>
              <td style="width: 100%">&nbsp;&nbsp;
              </td>
              <td style="width: 1%">
                <asp:LinkButton ID="btnCollapse" runat="server" Visible="true" ToolTip="Collapse Navigation Bar"><img src="Images/double.left.png" style="width:15px; height: 15px" /></asp:LinkButton>&nbsp;
              </td>
              <td style="width: 1%">&nbsp;&nbsp;
              </td>
            </tr>
          </table>
          <div class="well well-sm">
            <table style="width: 100%">
              <tr>
                <td style="text-align: center; width: 100%">
                  <b>Post Search Tools</b>
                </td>
              </tr>
            </table>
          </div>
          <b>Search By Keyword(s):</b><br />
          <table>
            <tr>
              <td>&nbsp;</td>
              <td style="text-align: center">
                <div class="form-group has-feedback has-search">
                  <span class="glyphicon glyphicon-search form-control-feedback"></span>
                  <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="type & click enter" AutoPostBack="True" AutoCompleteType="Disabled" Width="155px"></asp:TextBox>
                </div>
              </td>
              <td>&nbsp;</td>
            </tr>
          </table>
          <br />
          <b>Search By Category:</b><br />
          <table class="table table-hover" border="0" style="font-size: 14px">
            <asp:Repeater ID="rptPostCategories" runat="server">
              <ItemTemplate>
                <tr>
                  <td style="text-align: left; vertical-align: middle">
                    <asp:LinkButton ID="btnViewPostCategory" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "postCategoryId")%>' runat="server" CausesValidation="false" OnClick="btnViewPostCategory_Click" ToolTip='<%# "View more details about " & DataBinder.Eval(Container.DataItem, "name") & " posts"  %>'>
                      <%# DataBinder.Eval(Container.DataItem, "name")%> <%# " (" & DataBinder.Eval(Container.DataItem, "countOfPosts") & ")"%>
                    </asp:LinkButton>
                  </td>
                  <td style="vertical-align: middle"></td>
                </tr>
              </ItemTemplate>
            </asp:Repeater>
          </table>
        </asp:Panel>
      </td>
      <td style="width: 20%;">
        <asp:Panel ID="pnlNavigateHide" runat="server" Visible="false" Width="40px" Height="800px" BorderStyle="Solid">
          <table style="width: 100%" border="0">
            <tr>
              <td style="width: 100%">&nbsp;&nbsp;</td>
              <td style="width: 1%">
                <asp:LinkButton ID="btnExpand" runat="server" Visible="false" ToolTip="Expand Navigation Bar"><img src="Images/double.right.png" style="width:15px; height: 15px" /></asp:LinkButton>
              </td>
              <td style="width: 1%">&nbsp;&nbsp;</td>
            </tr>
          </table>
        </asp:Panel>
      </td>
      <td style="width: 80%">
        <asp:Panel ID="pnlBody" runat="server" Visible="true" Width="1000px" Height="800px" BorderStyle="Solid" ScrollBars="Vertical">

          <asp:Panel ID="pnlSearch" runat="server" Visible="false" Width="100%" Height="100%">
          </asp:Panel>
          <asp:Panel ID="pnlCategories" runat="server" Visible="false" Width="100%" Height="100%">
          </asp:Panel>
          <asp:Panel ID="pnlPosts" runat="server" Visible="true" Width="100%" Height="100%">
            <table style="width: 100%" border="0">
              <tr>
                <td colspan="3">
                  <div>
                    <table style="width: 100%;">
                      <tr>
                        <td style="width: 100%; text-align: left">
                          <h1></h1>
                        </td>
                        <td style="width: 100%; text-align: left">
                          <asp:LinkButton ID="btnCreatePost" runat="server" data-toggle="modal" data-target="#myModalCreate" Style="white-space: nowrap" Text="Create a Post"></asp:LinkButton>
                          <%--<asp:Button ID="btnQuestion" runat="server" Text="Create a Post" CssClass="btn btn-primary" TabIndex="1" Width="150" data-toggle="modal" data-target="#myModal" />--%>
                        </td>
                        <td>&nbsp;
                        </td>
                      </tr>
                    </table>
                    <h4></h4>
                  </div>
                </td>
              </tr>
            </table>
<%--            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
              <ContentTemplate>--%>
                <asp:Repeater ID="rptPosts" runat="server">
                  <ItemTemplate>
                    <table style="width: 100%">
                      <tr>
                        <td style="width: 1%">
                          <img src='<%# IIf(DataBinder.Eval(Container.DataItem, "postParentId") > 0, "Images/Reply_Arrow.png", "")%>' />
                        </td>
                        <td style="width: 99%">
                          <table class="table table-table" border="0" style="font-size: 14px">
                            <tr>
                              <td style="text-align: left; width: 25%" colspan="1">
                                <b>Category:&nbsp;</b><%# DataBinder.Eval(Container.DataItem, "POST_CATEGORY.name")%>  
                              </td>
                              <td style="text-align: left; width: 75%" colspan="1">
                                <b>Title:&nbsp;</b><%# DataBinder.Eval(Container.DataItem, "postTitle")%>
                              </td>
                            </tr>
                            <tr>
                              <td style="text-align: left" colspan="2">
                                <b>Content:&nbsp;</b><%# DataBinder.Eval(Container.DataItem, "postContent")%>
                              </td>
                            </tr>
                            <tr>
                              <td style="text-align: left; white-space: nowrap; font-size:x-small" colspan="2">
                                <a href='discussion?pid=<%# DataBinder.Eval(Container.DataItem, "postId")%>'>Post ID: <%# DataBinder.Eval(Container.DataItem, "postId")%> &nbsp; Created on &nbsp;<%# FormatDateTime(DataBinder.Eval(Container.DataItem, "postCreatedOn"), DateFormat.GeneralDate)%> by <%# getName(DataBinder.Eval(Container.DataItem, "postCreatedBy"))%> &nbsp; Total Replies: <%# DataBinder.Eval(Container.DataItem, "countOfReplies")%></a>
                              </td>

                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>

                    <table width="100%">
                      <tr>
                        <td>&nbsp; &nbsp;
                        </td>
                        <td width="100%">
                          <asp:Panel ID="pnlReplyPostForm" runat="server" Width="100%" >
                            <table border="0" width="100%">
                              <tr>
                                <td>&nbsp;
                                </td>
                                <th colspan="3">
                                  <%--<ajaxToolkit:Accordion ID="accZakat" runat="server" BorderWidth="0px" RequireOpenedPane="False" FadeTransitions="True" HeaderCssClass="accordionHeader" HeaderSelectedCssClass="accordionHeaderSelected" ContentCssClass="accordionContent" SelectedIndex="-1" BorderStyle="None" AutoSize="None" Height="625px">
                                    <Panes>
                                      <ajaxToolkit:AccordionPane runat="server" ID="paneReply" TabIndex="600">
                                        <Header>
                                          <table style="width: 100%">
                                            <tr>
                                              <th style="width: 25%; text-align: left; vertical-align: middle">Reply To The Post
                                              </th>
                                              <th style="width: 25%; text-align: right; vertical-align: middle">
                                                <span class="glyphicon glyphicon-triangle-bottom"></span>
                                              </th>
                                            </tr>
                                          </table>
                                        </Header>
                                        <Content>
                                          <br />
                                          <table style="width: 100%">
                                            <tr>
                                              <td>&nbsp;
                                              </td>
                                              <th style="text-align: right; width: 150px">Title: 
                                              </th>
                                              <td style="width: 1%">&nbsp;
                                              </td>
                                          
                                              </td>
                                              <td>&nbsp;
                                              </td>
                                            </tr>
                                            <tr>
                                              <td>&nbsp;
                                              </td>
                                              <th style="text-align: right">Category: 
                                              </th>
                                              <td style="width: 1%">&nbsp;
                                              </td>
                                              <td>
          \
                                              </td>
                                              <td>&nbsp;
                                              </td>
                                            </tr>
                                            <tr>
                                              <td>&nbsp;
                                              </td>
                                              <th style="text-align: right; vertical-align: top">Content:  
                                              </th>
                                              <td style="width: 1%">&nbsp;
                                              </td>
                                              <td>
                                              
                                              </td>
                                              <td>&nbsp;
                                              </td>
                                            </tr>
                                            <tr>
                                              <td>&nbsp;
                                              </td>
                                              <td style="white-space: nowrap">
                                              </td>
                                              <td style="width: 1%">&nbsp;
                                              </td>
                                              <td style="text-align: right">
         
                                              </td>
                                              <td>&nbsp;
                                              </td>
                                            </tr>
                                          </table>
                                        </Content>
                                      </ajaxToolkit:AccordionPane>
                                    </Panes>
                                  </ajaxToolkit:Accordion>--%>
                                  <div class="panel-group" id="accordion">
                                    <div >
                                      <div class="panel-heading" style="background-color: #f5f5f5">
                                        <h4 class="panel-title">
                                          <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%# DataBinder.Eval(Container.DataItem, "postId")%>">
                                            <table style="width: 100%">
                                              <tr>
                                                <th style="width: 25%; text-align: left; vertical-align: middle; font-size:small">Reply To The Post
                                                </th>
                                                <th style="width: 25%; text-align: right; vertical-align: middle">
                                                  <span class="glyphicon glyphicon-triangle-bottom"></span>
                                                </th>
                                              </tr>
                                            </table>
                                          </a>
                                        </h4>
                                      </div>
                                      <div id="collapse<%# DataBinder.Eval(Container.DataItem, "postId")%>" class="panel-collapse collapse">
                                        <div class="panel-body">
                                          <table style="width: 100%">
                                            <tr>
                                              <td>&nbsp;
                                              </td>
                                              <th style="text-align: right; width: 150px">Title: 
                                              </th>
                                              <td style="width: 1%">&nbsp;
                                              </td>
                                              <td style="width: 100%"><%# IIf(InStr(DataBinder.Eval(Container.DataItem, "postTitle"), "Re: ") = 0, "Re: " + DataBinder.Eval(Container.DataItem, "postTitle"), DataBinder.Eval(Container.DataItem, "postTitle"))%>
                                              </td>
                                              <td>&nbsp;
                                              </td>
                                            </tr>
                                            <tr>
                                              <td>&nbsp;
                                              </td>
                                              <th style="text-align: right">Category: 
                                              </th>
                                              <td style="width: 1%">&nbsp;
                                              </td>
                                              <td>
                                                <%# DataBinder.Eval(Container.DataItem, "POST_CATEGORY.name")%>
                                              </td>
                                              <td>&nbsp;
                                              </td>
                                            </tr>
                                            <tr>
                                              <td>&nbsp;
                                              </td>
                                              <th style="text-align: right; vertical-align: top">Content:  
                                              </th>
                                              <td style="width: 1%">&nbsp;
                                              </td>
                                              <td>
                                                <asp:TextBox ID="txtReplyContent" runat="server" CssClass="form-control" Width="100%" Rows="3" Visible="true" ValidationGroup='<%# DataBinder.Eval(Container.DataItem, "postId")%>' TextMode="MultiLine" AutoCompleteType="Disabled"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtReplyContent" CssClass="text-danger" ErrorMessage="The Reply Content is required." ValidationGroup='<%# DataBinder.Eval(Container.DataItem, "postId")%>' />
                                              </td>
                                              <td>&nbsp;
                                              </td>
                                            </tr>
                                            <tr>
                                              <td>&nbsp;
                                              </td>
                                              <td style="white-space: nowrap">
                                                <a runat="server" href="/" tabindex="2" visible='<%# IIf(getUser() = "Anonymous", True, False)%>'>Reply as User</a>
                                              </td>
                                              <td style="width: 1%">&nbsp;
                                              </td>
                                              <td style="text-align: right">
                                                <asp:Button ID="btnSubmitReply" runat="server" Text='<%#"Reply as " + getUser()%>' CssClass="btn btn-primary" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "postId")%>' TabIndex="3" ValidationGroup='<%# DataBinder.Eval(Container.DataItem, "postId")%>' OnClick="btnSubmitReply_Click" />
                                              </td>
                                              <td>&nbsp;
                                              </td>
                                            </tr>
                                          </table>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </th>

                              </tr>
                            </table>
                          </asp:Panel>
                        </td>
                        <td>&nbsp; &nbsp;
                        </td>
                      </tr>
                    </table>

                  </ItemTemplate>
                </asp:Repeater>
<%--              </ContentTemplate>
            </asp:UpdatePanel>--%>
          </asp:Panel>
        </asp:Panel>
      </td>
    </tr>
  </table>

  <br />
  <br />
  <%-- Start Post Modal --%>
  <div class="modal fade" id="myModalCreate" role="dialog">
    <div class="modal-dialog modal-md">
      <!-- Modal content-->
      <div class="modal-content">
        <%-- Modal header --%>
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"><b>
            <asp:Label ID="lblModalHeader" runat="server" Text="Create a Post"></asp:Label></b></h4>
        </div>
        <%-- Modal body --%>
        <div class="modal-body">
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtPostTitle" CssClass="col-lg-2 control-label" ToolTip="Post Title">Title:<span style="color: red">*</span></asp:Label>
            <div class="col-lg-10">
              <asp:TextBox ID="txtPostTitle" runat="server" CssClass="form-control" ValidationGroup="Save" AutoCompleteType="Disabled"></asp:TextBox>
              <asp:RequiredFieldValidator runat="server" ID="valPostTitle" ControlToValidate="txtPostTitle" CssClass="text-danger" ErrorMessage="The Post Title is required." ValidationGroup="Create" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="drpPostCategory" CssClass="col-lg-2 control-label" ToolTip="Post Category">Category:<span style="color: red">*</span></asp:Label>
            <div class="col-lg-10">
              <asp:DropDownList ID="drpPostCategory" runat="server" CssClass="form-control" ValidationGroup="Save"></asp:DropDownList>
              <asp:RequiredFieldValidator runat="server" ID="valPostCategory" ControlToValidate="drpPostCategory" CssClass="text-danger" ErrorMessage="The Post Category is required." InitialValue="(Select One)" ValidationGroup="Create" />
            </div>
          </div>
          <table class="table table-condensed table-striped" style="width: 100%;">
            <tr>
              <td>
                <asp:TextBox ID="txtPostContent" runat="server" CssClass="form-control" Width="100%" Rows="10" Visible="true" ValidationGroup="Save" TextMode="MultiLine" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="valPostContent" ControlToValidate="txtPostContent" CssClass="text-danger" ErrorMessage="The Post Content is required." ValidationGroup="Create" />
              </td>
            </tr>
          </table>
        </div>
        <%-- modal footer --%>
        <div class="modal-footer">
          <div class="row" runat="server" id="divNotLoggedInPost" visible="true">
            <div class="col-lg-6">
              <div style="width: 100%; text-align: left">
                <asp:Button ID="btnLogInPost" runat="server" Text="Log in to post as User" CssClass="btn btn-link" TabIndex="2" Width="200" />
              </div>
            </div>
            <div class="col-lg-6">
              <div style="width: 100%; text-align: right">
                <asp:Button ID="btnSubmitPost" runat="server" Text="Submit Post" CssClass="btn btn-primary" TabIndex="3" Width="200" ValidationGroup="Create" />
              </div>
            </div>
          </div>
          <%--          <div class="row" runat="server" id="divLoggedInPost" visible="false">
            <div class="col-lg-12">
              <div style="width: 100%; text-align: right">
                <asp:Button ID="btnUserSubmitPost" runat="server" Text="Submit Post" CssClass="btn btn-primary" TabIndex="4" Width="200" ValidationGroup="Save" />
              </div>
            </div>
          </div>--%>
        </div>
      </div>
    </div>
  </div>
  <%-- End Post Modal --%>
</asp:Content>

