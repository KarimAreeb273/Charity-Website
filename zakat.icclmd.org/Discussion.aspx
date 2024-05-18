<%@ Page Title="User Forum" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Discussion.aspx.vb" Inherits="zakat.icclmd.org.Discussion" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <br />
  <br />
  <br />
  <br />
  <table style="width: 100%" border="0">
    <tr>
      <td style="width: 20%;">
        <asp:Panel ID="pnlNavigateShow" runat="server" Visible="true" Width="170px" Height="750px" BorderStyle="Solid">
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
          <table style="width: 100%">
            <tr>
              <td style="text-align: center">
                <b>
                  <asp:LinkButton ID="btnCreatePost" runat="server" data-toggle="modal" data-target="#myModalCreate" Style="white-space: nowrap" Text="Create a Post"></asp:LinkButton></b>
                <br />
                <br />
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
          <b>Search Post Content:</b><br />
          <table>
            <tr>
              <td>&nbsp;</td>
              <td style="text-align: center">
                <div class="form-group has-feedback has-search">
                  <%--<span class="glyphicon glyphicon-search form-control-feedback"></span>--%>
                  <%--<asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="type & click enter" AutoPostBack="True" AutoCompleteType="Disabled" Width="155px"></asp:TextBox>--%>
                  <%--start search section--%>
                  <table style="width: 100%">
                    <tr>
                      <td>
                        <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="type & click enter" AutoPostBack="True" AutoCompleteType="Disabled" Width="155px"></asp:TextBox>
                        <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                          <ContentTemplate>--%>
                            <%--<div class="form-group has-feedback has-search" style="position: relative; top: 9px">
                              <span class="glyphicon glyphicon-search form-control-feedback"></span>
                              
                            </div>
                            <ajaxToolkit:PopupControlExtender ID="ajaxTxtSearch" runat="server" TargetControlID="txtSearch" Position="Bottom" PopupControlID="pnlSearchResults" Enabled="true"></ajaxToolkit:PopupControlExtender>
                            <asp:Panel ID="pnlSearchResults" runat="server" BackColor="#F8F8F8">
                              <table class="table table-hover">
                                <asp:Repeater ID="rptSearchResultsDropdown" runat="server">
                                  <ItemTemplate>
                                    <tr>
                                      <td style="font-size: 10pt">
                                        <asp:LinkButton ID="btnViewContent" runat="server" OnClick="btnViewContent_Click" ToolTip="View Content" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "postId")%>'>
< GetHighlightedContent(DataBinder.Eval(Container.DataItem, "postContent"))%>
                                        </asp:LinkButton>
                                      </td>
                                    </tr>
                                  </ItemTemplate>
                                </asp:Repeater>
                              </table>
                            </asp:Panel>--%>
                         <%-- </ContentTemplate>
                        </asp:UpdatePanel>--%>
                      </td>
                    </tr>
                  </table>
                  <%--end search section--%>
                </div>
              </td>
              <td>&nbsp;</td>
            </tr>
          </table>
          <b>Search By Category:</b><br />
          <table class="table table-hover" border="0" style="font-size: 14px">
            <asp:Repeater ID="rptCategories" runat="server">
              <ItemTemplate>
                <tr>
                  <td style="text-align: left; vertical-align: middle">
                    <asp:LinkButton ID="btnViewPostCategory" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "postCategoryId")%>' runat="server" CausesValidation="false" OnClick="btnViewPostCategory_Click" ToolTip="View posts for this Category">
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
        <asp:Panel ID="pnlNavigateHide" runat="server" Visible="false" Width="40px" Height="750px" BorderStyle="Solid">
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
        <asp:Panel ID="pnlBody" runat="server" Visible="true" Width="1000px" Height="750px" BorderStyle="Solid" ScrollBars="None">
          <asp:Panel ID="pnlLanding" runat="server" Visible="true" Width="100%" Height="100%">
            <br />
            <table style="width: 100%">
              <tr>
                <td style="width: 1%">&nbsp;
                </td>
                <td style="width: 100%" colspan="3">
                  <p style="text-align: justify; font-size: 16pt">
                    Welcome to the Zakat Network User Forum, a place where our zakat applicants can share ideas amongst one another and gain advice prior to submitting zakat applications.  We ask that all content created by existing users to remain civil and please note we reserve the right to remove content which is not suitable for the Zakat Network User Forum.
                  </p>
                  <br />
                  <br />
                  <br />
                </td>
                <td style="width: 1%">&nbsp;
                </td>
              </tr>
              <tr>
                <td style="width: 1%">&nbsp;
                </td>
                <td style="width: 33%; text-align: center">
                  <i style="font-size: 60px" class="fas fa-list"></i>
                </td>
                <td style="width: 33%; text-align: center">
                  <i style="font-size: 60px" class="fas fa-search"></i>
                </td>
                <td style="width: 33%; text-align: center">
                  <i style="font-size: 60px" class="far fa-plus-square"></i>
                </td>
                <td style="width: 1%">&nbsp;
                </td>
              </tr>
              <tr>
                <td style="width: 1%">&nbsp;
                </td>
                <th style="width: 33%; text-align: center">
                  <h3><b>Categories</b></h3>
                </th>
                <th style="width: 33%; text-align: center">
                  <h3><b>Search</b></h3>
                </th>
                <th style="width: 33%; text-align: center">
                  <h3><b>Posts</b></h3>
                </th>
                <td style="width: 1%">&nbsp;
                </td>
              </tr>
              <tr style="font-size: 16pt">
                <td style="width: 1%">&nbsp;
                </td>
                <td style="width: 33%; text-align: center; vertical-align: top">
                  <br />
                  <br />
                  <p>See a list of posts based on category by click on the category in our navigation pane.</p>
                </td>
                <td style="width: 33%; text-align: center; vertical-align: top">
                  <br />
                  <br />
                  <p>Search for a post across all categories by entering keywords in the search textbox.</p>
                </td>
                <td style="width: 33%; text-align: center; vertical-align: top">
                  <br />
                  <br />
                  <p>If you can find an existing post based on those from other users, create your own.</p>
                </td>
                <td style="width: 1%">&nbsp;
                </td>
              </tr>
            </table>
            <%--<div class="container">
              <div class="row">
                <div class="col-lg-3">
                  <table style="width: 100%">
                    <tr>
                      <td style="width: 100%; text-align: center; color: black">
                        <i style="font-size: 60px" class="fas fa-list"></i>
                        <h2>Categories</h2>
                        <p style="font-size: 14pt">Our products prevent the capture of clear photos using all mobile phone cameras ensuring the privacy of guests.</p>
                      </td>
                    </tr>
                  </table>
                </div>
                <div class="col-lg-3">
                  <table style="width: 100%">
                    <tbody>
                      <tr>
                        <td style="width: 100%; text-align: center; color: black">
                          <i style="font-size: 60px" class="fas fa-search"></i>
                          <h2>Search</h2>
                          <p style="font-size: 14pt">Although photo taking will be disabled, guests will be able to retain and use their mobile phones for calls, texts and apps.</p>
                        </td>
                      </tr>
                  </table>
                </div>
                <div class="col-lg-3">
                  <table style="width: 100%">
                    <tbody>
                      <tr>
                        <td style="width: 100%; text-align: center; color: black">
                          <i style="font-size: 60px" class="far fa-plus-square"></i>
                          <h2>Posts</h2>
                          <p style="font-size: 14pt">In a few short steps, our scheduling system will give you peace of mind to know we will make your special event our focus.</p>
                        </td>
                      </tr>
                  </table>
                </div>
              </div>
            </div>--%>
          </asp:Panel>
          <asp:Panel ID="pnlSearch" runat="server" Visible="false" Width="100%" Height="100%">
            <div class="well well-sm">
              <table style="width:100%">
                <tr>
                  <td style="width:50%">
                    <h5><b>Showing Results For Keyword: </b>
                      <asp:Label ID="lblKeywordSearch" runat="server" Text="Label"></asp:Label></h5>
                  </td>
                  <td style="width:10%">
                    &nbsp;
                  </td>
                  <td style="width:40%">
                    <h5><b>Total Results: </b>
                      <asp:Label ID="lblSearchResults" runat="server" Text="0"></asp:Label></h5>
                  </td>
                </tr>
              </table>
            </div>
            <asp:Panel ID="pnlNoSearchMsg" runat="server" Visible="False">
              <table style="width: 100%">
                <tr>
                  <td style="text-align: center">
                    <b>
                      <asp:Label ID="lblNoSearchMsg" runat="server" Text="There are no results for the searched term(s)."></asp:Label></b>
                  </td>
                </tr>
              </table>
            </asp:Panel>
            <asp:Repeater ID="rptSearchResultsDisplay" runat="server">
              <ItemTemplate>
                <table style="width: 100%">
                  <tr>
                    <td style="width: 100%">
                      <table class="table table-table" border="0" style="font-size: 14px">
                        <tr>
                          <td style="text-align: left; width: 25%" colspan="1">
                            <b>Category:&nbsp;</b><%# DataBinder.Eval(Container.DataItem, "POST_CATEGORY.name")%>  
                          </td>
                          <td style="text-align: left; width: 75%" colspan="1">
                            <b>Title:&nbsp;</b><%# GetHighlightedContent(DataBinder.Eval(Container.DataItem, "postTitle"))%>
                          </td>
                        </tr>
                        <tr>
                          <td style="text-align: left" colspan="2">
                            <b>Content:&nbsp;</b><%# GetHighlightedContent(DataBinder.Eval(Container.DataItem, "postContent"))%>
                          </td>
                        </tr>
                        <tr>
                          <td style="text-align: left; white-space: nowrap; font-size: x-small" colspan="2">
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
                      <asp:Panel ID="pnlReplyPostForm" runat="server" Width="100%">
                        <table border="0" width="100%">
                          <tr>
                            <td>&nbsp;
                            </td>
                            <th colspan="3">
                              <div class="panel-group" id="accordion">
                                <div>
                                  <div class="panel-heading" style="background-color: #f5f5f5">
                                    <h4 class="panel-title">
                                      <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%# DataBinder.Eval(Container.DataItem, "postId")%>">
                                        <table style="width: 100%">
                                          <tr>
                                            <th style="width: 25%; text-align: left; vertical-align: middle; font-size: small">Reply To The Post
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
          </asp:Panel>
          <asp:Panel ID="pnlCategories" runat="server" Visible="true" Width="100%" Height="100%">
            <div class="well well-sm">  
            <table style="width: 100%">
              <tr>
                <td style="width:50%">
                  <h5><b>Showing Results For Category: </b>
                    <asp:Label ID="lblCategory" runat="server" Text="Label"></asp:Label></h5>
                </td>
                <td style="width:10%">&nbsp;
                </td>
                <td style="width:40%">
                  <h5><b>Total Results: </b>
                    <asp:Label ID="lblCategoryResults" runat="server" Text="0"></asp:Label></h5>
                </td>
              </tr>
            </table>
              </div>
            <asp:Panel ID="pnlNoPostCategoryMsg" runat="server" Visible="False">
              <table style="width: 100%">
                <tr>
                  <td style="text-align: center">
                    <b>
                      <asp:Label ID="lblNoPostCategoryMsg" runat="server" Text="There are no Posts under this Category at this time."></asp:Label></b>
                  </td>
                </tr>
              </table>
            </asp:Panel>
            <asp:Repeater ID="rptPostCategories" runat="server">
              <ItemTemplate>
                <table style="width: 100%">
                  <tr>
                    <td style="width: 100%">
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
                          <td style="text-align: left; white-space: nowrap; font-size: x-small" colspan="2">
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
                      <asp:Panel ID="pnlReplyPostForm" runat="server" Width="100%">
                        <table border="0" width="100%">
                          <tr>
                            <td>&nbsp;
                            </td>
                            <th colspan="3">
                              <div class="panel-group" id="accordion">
                                <div>
                                  <div class="panel-heading" style="background-color: #f5f5f5">
                                    <h4 class="panel-title">
                                      <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%# DataBinder.Eval(Container.DataItem, "postId")%>">
                                        <table style="width: 100%">
                                          <tr>
                                            <th style="width: 25%; text-align: left; vertical-align: middle; font-size: small">Reply To The Post
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
          </asp:Panel>
          <asp:Panel ID="pnlPosts" runat="server" Visible="false" Width="100%" Height="100%">
            <%--<table style="width: 100%" border="0">
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
                        </td>
                        <td>&nbsp;
                        </td>
                      </tr>
                    </table>
                    <h4></h4>
                  </div>
                </td>
              </tr>
            </table>--%>
            <div class="well well-sm">
              <table style="width: 100%">
                <tr>
                  <td style="width: 50%">
                    <h5><b>The Current Parent Post Is: </b>
                <asp:Label ID="lblPosts" runat="server" Text="Label"></asp:Label></h5>
                  </td>
                  <td style="width: 10%">&nbsp;
                  </td>
                  <td style="width: 40%">
                    <h5><b>Total Replies: </b>
                      <asp:Label ID="lblPostResults" runat="server" Text="0"></asp:Label></h5>
                  </td>
                </tr>
              </table>
            </div>
            <asp:Repeater ID="rptPosts" runat="server">
              <ItemTemplate>
                <table style="width: 100%">
                  <tr>
                    <td style="width: 1%">
                      <img src='<%# IIf(DataBinder.Eval(Container.DataItem, "postParentId") = CInt(Request.QueryString("pid")), "Images/Reply_Arrow.png", "")%>' />
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
                          <td style="text-align: left; white-space: nowrap; font-size: x-small" colspan="2">
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
                      <asp:Panel ID="pnlReplyPostForm" runat="server" Width="100%">
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
                                <div>
                                  <div class="panel-heading" style="background-color: #f5f5f5">
                                    <h4 class="panel-title">
                                      <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%# DataBinder.Eval(Container.DataItem, "postId")%>">
                                        <table style="width: 100%">
                                          <tr>
                                            <th style="width: 25%; text-align: left; vertical-align: middle; font-size: small">Reply To The Post
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
          </asp:Panel>

        </asp:Panel>
      </td>
    </tr>
  </table>
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
  <br />
  <br />
  <br />
</asp:Content>

