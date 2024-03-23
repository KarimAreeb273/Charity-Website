<%@ Page Title="User Forum" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Discussion.aspx.vb" Inherits="zakat.icclmd.org.Discussion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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
        <asp:Panel ID="pnlBody" runat="server" Visible="true" Width="1000px" Height="800px" BorderStyle="Solid" ScrollBars="None">

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
                          <asp:LinkButton ID="btnCreatePost" runat="server" data-toggle="modal" data-target="#myModal" Style="white-space: nowrap" Text=""></asp:LinkButton>
                          <%--<asp:Button ID="btnQuestion" runat="server" Text="Create a Post" CssClass="btn btn-primary" TabIndex="1" Width="150" data-toggle="modal" data-target="#myModal" />--%>
                          <%-- Modal start --%>
                          <div class="modal fade" id="myModal" role="dialog">
                            <div class="modal-dialog modal-md">
                              <!-- Modal content-->
                              <div class="modal-content">
                                <%-- Modal header --%>
                                <div class="modal-header">
                                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                                  <h4 class="modal-title"><b><asp:Label ID="lblModalHeader" runat="server" Text="Create a Post"></asp:Label></b></h4>
                                </div>
                                <%-- Modal body --%>
                                <div class="modal-body">
                                  <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="txtPostTitle" CssClass="col-lg-2 control-label" ToolTip="Post Title">Title:<span style="color: red">*</span></asp:Label>
                                    <div class="col-lg-10">
                                      <asp:TextBox ID="txtPostTitle" runat="server" CssClass="form-control" ValidationGroup="Save" AutoCompleteType="Disabled"></asp:TextBox>
                                      <asp:RequiredFieldValidator runat="server" ID="valPostTitle" ControlToValidate="txtPostTitle" CssClass="text-danger" ErrorMessage="The Post Title is required." ValidationGroup="Save" />
                                    </div>
                                  </div>
                                  <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="drpPostCategory" CssClass="col-lg-2 control-label" ToolTip="Post Category">Category:<span style="color: red">*</span></asp:Label>
                                    <div class="col-lg-10">
                                      <asp:DropDownList ID="drpPostCategory" runat="server" CssClass="form-control" ValidationGroup="Save"></asp:DropDownList>
                                      <asp:RequiredFieldValidator runat="server" ID="valPostCategory" ControlToValidate="drpPostCategory" CssClass="text-danger" ErrorMessage="The Post Category is required." InitialValue="(Select One)" ValidationGroup="Save" />
                                    </div>
                                  </div>
                                  <table class="table table-condensed table-striped" style="width: 100%;">
                                    <tr>
                                      <td>
                                        <asp:TextBox ID="txtPostContent" runat="server" CssClass="form-control" Width="100%" Rows="10" Visible="true" ValidationGroup="Save" TextMode="MultiLine" AutoCompleteType="Disabled"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ID="valPostContent" ControlToValidate="txtPostContent" CssClass="text-danger" ErrorMessage="The Post Content is required." ValidationGroup="Save" />
                                      </td>
                                    </tr>
                                  </table>
                                </div>
                                <%-- modal footer --%>
                                <div class="modal-footer">
                                  <div class="row" runat="server" id="divNotLoggedInPost" visible="false">
                                    <div class="col-lg-6">
                                      <div style="width: 100%; text-align: left">
                                        <asp:Button ID="btnLogInPost" runat="server" Text="Log in to reply as User" CssClass="btn btn-link" TabIndex="2" Width="200" />
                                      </div>
                                    </div>
                                    <div class="col-lg-6">
                                      <div style="width: 100%; text-align: right">
                                        <asp:Button ID="btnGuestSubmitPost" runat="server" Text="Reply as a Guest" CssClass="btn btn-primary" TabIndex="3" Width="200" ValidationGroup="Save" />
                                      </div>
                                    </div>
                                  </div>
                                  <div class="row" runat="server" id="divLoggedInPost" visible="false">
                                    <div class="col-lg-12">
                                      <div style="width: 100%; text-align: right">
                                        <asp:Button ID="btnUserSubmitPost" runat="server" Text="Submit Post" CssClass="btn btn-primary" TabIndex="4" Width="200" ValidationGroup="Save" />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <%-- modal end --%>
                        </td>
                      </tr>
                    </table>
                    <h4></h4>
                    <hr />

                    <hr />
                    <%--<asp:LinkButton ID="btnAddComment" runat="server">Reply to Post</asp:LinkButton>--%>
                    <asp:LinkButton ID="btnReplyPost" runat="server" data-toggle="modal" data-target="#myModalReply">&nbsp; Reply to Post</asp:LinkButton>
                    <!-- Start Modal -->
                    <div class="modal fade" id="myModalReply" role="dialog">
                      <div class="modal-dialog modal-md">
                        <!-- Modal content-->
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Reply to Post</b></h4>
                          </div>
                          <div class="modal-body">
                            <table class="table table-condensed table-striped" style="width: 100%;">
                              <tr>
                                <td>
                                  <textarea id="txtAnswer" runat="server" style="width: 100%; -webkit-box-sizing: border-box; -moz-box-sizing: border-box; box-sizing: border-box;" rows="10" visible="true"></textarea>
                                </td>
                              </tr>
                            </table>
                          </div>
                          <div class="modal-footer">
                            <div class="row" runat="server" id="divNotLoggedIn" visible="false">
                              <div class="col-lg-6">
                                <div style="width: 100%; text-align: left">
                                  <asp:Button ID="btnLogIn" runat="server" Text="Log in to reply as User" CssClass="btn btn-primary" TabIndex="2" Width="200" />
                                </div>
                              </div>
                              <div class="col-lg-6">
                                <div style="width: 100%; text-align: right">
                                  <asp:Button ID="btnGuestSubmit" runat="server" Text="Reply as a Guest" CssClass="btn btn-primary" TabIndex="3" Width="200" />
                                </div>
                              </div>
                            </div>
                            <div class="row" runat="server" id="divLoggedIn" visible="false">
                              <div class="col-lg-12">
                                <div style="width: 100%; text-align: right">
                                  <asp:Button ID="btnUserSubmit" runat="server" Text="Submit Comment" CssClass="btn btn-primary" TabIndex="4" Width="200" />
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!--  End  Modal -->
                    <hr />
                    <h2>Answers</h2>
                    <br />
                    <br />
                  </div>
                </td>
              </tr>
            </table>
            <table class="table table-table" border="0" style="font-size: 14px">
              <asp:Repeater ID="rptPosts" runat="server">
                <%--                <HeaderTemplate>
                  <tr style="height: 30px; border: solid solid solid solid">
                    <th style="text-align: left; width: 30%">Name</th>
                    <th style="text-align: left; width: 10%">Phone</th>
                    <th style="text-align: left; width: 20%">Email</th>
                    <th style="text-align: left; width: 30%">Website</th>
                    <th style="text-align: center; width: 5%;">Edit</th>
                  </tr>
                </HeaderTemplate>--%>
                <ItemTemplate>
                  <tr>
                    <td style="text-align: left" colspan="1">
                      <b>Category:&nbsp;</b><%# DataBinder.Eval(Container.DataItem, "POST_CATEGORY.name")%>
                    </td>
                    <td style="text-align: left" colspan="2">
                      <b>Title:&nbsp;</b><%# DataBinder.Eval(Container.DataItem, "postTitle")%>
                    </td>
                  </tr>
                  <tr>
                    <td style="text-align: left" colspan="3">
                      <hr />
                      <%# DataBinder.Eval(Container.DataItem, "postContent")%>
                    </td>
                  </tr>
                  <tr>
                    <td style="text-align: left; white-space: nowrap" colspan="2">
                      <b>Created on &nbsp;</b><%# FormatDateTime(DataBinder.Eval(Container.DataItem, "postCreatedOn"), DateFormat.GeneralDate)%> by <%# DataBinder.Eval(Container.DataItem, "postCreatedBy")%> 
                    </td>
                    <td style="text-align: right" colspan="1">
                      <asp:LinkButton ID="btnReplyPost" runat="server" data-toggle="modal" data-target="#myModalReply" Style="white-space: nowrap" OnClick="btnReplyPost_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "postId")%>'>Reply to Post &nbsp;</asp:LinkButton>
                    </td>
                  </tr>
                </ItemTemplate>
              </asp:Repeater>
            </table>
          </asp:Panel>
        </asp:Panel>
      </td>
    </tr>
  </table>
  <br />
  <br />
</asp:Content>

