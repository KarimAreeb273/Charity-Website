<%@ Page Title="Zakat Donations" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Donate.aspx.vb" Inherits="zakat.icclmd.org.Donate" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h4><b>Zakat Donations</b></h4>
        <div class="row">
            <div class="col-lg-12">
                <div class="well well-sm">
                    <h5><b>NOTE: All donations made on this site are done anonymously but you may have to provide personal information with PayPal. </b>
                    </h5>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div class="form-horizontal">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtDonationMethod" CssClass="col-lg-3 control-label" ToolTip="Donation Method" Style="white-space: nowrap">Donation Method:</asp:Label>
                        <div class="col-lg-9">
                            <asp:TextBox Text="PayPal" runat="server" ID="txtDonationMethod" CssClass="form-control" autocomplete="off" type="tel" ToolTip="Donation Amount" TabIndex="1" MaxLength="3" Enabled="false" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDonationMethod" CssClass="text-danger" ErrorMessage="The Donation method is required." InitialValue="(Select One)" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="col-lg-3 control-label" ToolTip="First Name" Style="white-space: nowrap">First Name:</asp:Label>
                        <div class="col-lg-9">
                            <asp:TextBox runat="server" ID="txtFirstName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="2" AutoPostBack="False" ValidationGroup="Submit" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" ValidationGroup="donate" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtLastName" CssClass="col-lg-3 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
                        <div class="col-lg-9">
                            <asp:TextBox runat="server" ID="txtLastName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="3" AutoPostBack="False" ValidationGroup="Submit" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger" Display="Static" ErrorMessage="The last name is required." ValidationGroup="donate" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-horizontal">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtDonationDate" CssClass="col-lg-3 control-label" ToolTip="Donation Date">Donation Date:</asp:Label>
                        <div class="col-lg-9">
                            <asp:TextBox runat="server" ID="txtDonationDate" CssClass="form-control" ToolTip="Donation Date" placeholder="mm/dd/yyyy" TabIndex="4" Enabled="False" />
                            <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter a valid Donation date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtDonationDate"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDonationDate" CssClass="text-danger" ErrorMessage="The Donation date is required." Display="Static" />
                            <ajaxToolkit:CalendarExtender ID="calDonationDate" runat="server" TargetControlID="txtDonationDate" PopupButtonID="lnkCalendar" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="drpOrganization" CssClass="col-lg-3 control-label" ToolTip="Organization">Organization:</asp:Label>
                        <div class="col-lg-9">
                            <asp:DropDownList ID="drpOrganization" runat="server" ToolTip="Organization" CssClass="form-control" Style="max-width: 100%; padding-left: 0px; padding-right: 0px" TabIndex="5" Width="280px"></asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="drpOrganization" CssClass="text-danger" ErrorMessage="The organization is required." Display="Static" InitialValue="0" ValidationGroup="donate" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtDonationAmount" CssClass="col-lg-3 control-label" ToolTip="Donation Amount" Style="white-space: nowrap">Donation Amount:</asp:Label>
                        <div class="col-lg-9">
                            <table style="width: 280px" border="0">
                                <tr>
                                    <td>$</td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtDonationAmount" CssClass="form-control" autocomplete="off" type="tel" ToolTip="Donation Amount" MaxLength="3" placeholder="" TabIndex="6" Style="text-align: right" Enabled="true" /></td>
                                    <td>.00</td>
                                </tr>
                            </table>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDonationAmount" CssClass="text-danger" ValidationExpression="^[0-9]*$" ErrorMessage="A valid Donation amount is required." Display="Dynamic"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDonationAmount" CssClass="text-danger" ErrorMessage="The donation amount is required." Display="Static" ValidationGroup="donate" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    &nbsp;
                </div>
                <div class="col-lg-6">
                    <div class="form-group">
                        <div class="col-lg-3"></div>
                        <div class="col-lg-9">
                            <asp:Button ID="btnDonation" runat="server" Text="Make Donation" CssClass="btn btn-success" TabIndex="7" Width="150" ValidationGroup="donate" />
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <div class="well well-sm">
                        <h5><b>NOTE: This is a disclaimer that this site is not responsible for providing any end of year tax information. Please coordinate with the organization you are donating to in order to receive these documents.</b>
                        </h5>
                    </div>
                </div>
            </div>
            <br />
            <br />
            <br />
        </div>
    </div>
</asp:Content>
