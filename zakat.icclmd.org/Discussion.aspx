<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Discussion.aspx.vb" Inherits="zakat.icclmd.org.Discussion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <br />
    <br />
    <table style="width: 100%" border="0">
        <tr>
            <td style="width: 20%;">
                <asp:Panel ID="pnlNavigate" runat="server" Visible="true" Width="170px" Height="800px" BorderStyle="Solid">
                    <b>Search By Keywords</b><br />
                    <table>
                        <tr>
                            <td>&nbsp;</td>
                            <td style="text-align: center">
                                <div class="form-group has-feedback has-search">
                                    <span class="glyphicon glyphicon-search form-control-feedback"></span>
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="" AutoPostBack="True" AutoCompleteType="Disabled" Width="150px"></asp:TextBox>
                                </div>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <br />
                    <b>Search By Category</b><br />

                </asp:Panel>
            </td>
            <td style="width: 80%">
                <asp:Panel ID="pnlBody" runat="server" Visible="true" Width="1000px" Height="800px" BorderStyle="Solid">
                    <table style="width: 100%" border="0">
                        <tr>
                            <td style="width: 1%">&nbsp;
                            </td>
                            <td style="width: 1%">
                                <asp:LinkButton ID="btnCollapse" runat="server" Visible="true" ToolTip="Collapse Navigation Bar"><img src="Images/double.left.png" style="width:15px; height: 15px" /></asp:LinkButton>
                                <asp:LinkButton ID="btnExpand" runat="server" Visible="false" ToolTip="Expand Navigation Bar"><img src="Images/double.right.png" style="width:15px; height: 15px" /></asp:LinkButton>
                            </td>
                            <td style="width: 100%">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <div>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 100%; text-align: left">
                                                <h1>Important Question</h1>
                                            </td>
                                            <td style="width: 100%; text-align: left">
                                                <asp:Button ID="btnQuestion" runat="server" Text="Ask a Question" CssClass="btn btn-primary" TabIndex="1" Width="150" />
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    My question is very simple, I would like to know WHY
                                    <hr />
                                    <asp:LinkButton ID="btnAddComment" runat="server">Add a comment</asp:LinkButton>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <textarea id="txtAnswer" runat="server" style="width: 100%; -webkit-box-sizing: border-box; -moz-box-sizing: border-box; box-sizing: border-box;" rows="10" visible="false"></textarea>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div style="width: 100%; text-align: left">
                                                <asp:Button ID="btnNoComment" runat="server" Text="Cancel" CssClass="btn btn-primary" TabIndex="4" Width="150" Visible="false" />
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div style="width: 100%; text-align: right">
                                                <asp:Button ID="btnSubmit" runat="server" Text="Submit Comment" CssClass="btn btn-primary" TabIndex="5" Width="150" Visible="false" />
                                            </div>
                                        </div>
                                    </div>
                                    <hr />
                                    <h2>Answers</h2>
                                    <br />
                                    <br />
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
