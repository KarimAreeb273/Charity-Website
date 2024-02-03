<%@ Page Title="Zakat Eligibility" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Eligible.aspx.vb" Inherits="zakat.icclmd.org.Eligible" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Zakat Eligibility</h3>
    <div class="row">
        <div class="col-lg-12">
            <div class="well well-sm">
                <h5><b>In Sharia law, niṣāb is the maximum amount of wealth a Muslim must have before becoming eligble to receive zakat. The Prophet Muhammad (PBUH) set the niṣāb at 87.48 grams of gold and 612.36 grams of
silver, which is equal to 7.5 tola and 52.5 tola, respectively. </b>
                </h5>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="form-group">
                <div class="col-lg-6">
                    <div class="well well-sm">
                        <h5><b>Personal Wealth </b>
                        </h5>
                    </div>
                    <br />
                    <div class="row">
                        <div class="form-vertical">
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtSavings" CssClass="col-lg-3 control-label" ToolTip="Savings" Style="white-space: nowrap">Amount of Cash and Savings at home or in the bank:</asp:Label>
                                <br />
                                <div class="col-lg-12">
                                    <asp:TextBox runat="server" ID="txtSavings" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Savings" TabIndex="1" AutoPostBack="True" Placeholder="$" Text="0.00" />
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtJewelry" CssClass="col-lg-3 control-label" ToolTip="Jewelry" Style="white-space: nowrap">Current value of any gold and silver jewelry, coins, utensils etc:</asp:Label>
                                <div class="col-lg-12">
                                    <asp:TextBox runat="server" ID="txtJewelry" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Jewelry" TabIndex="2" AutoPostBack="True" Placeholder="$"  Text="0.00" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtJewelry" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" ValidationGroup="donate" />
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtValue" CssClass="col-lg-3 control-label" ToolTip="Value" Style="white-space: nowrap">Value of  assets and merchandise for trade:</asp:Label>
                                <div class="col-lg-12">
                                    <asp:TextBox runat="server" ID="txtValue" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Value" TabIndex="3" AutoPostBack="True" Placeholder="$"  Text="0.00" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValue" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" ValidationGroup="donate" />
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtLoans" CssClass="col-lg-3 control-label" ToolTip="Loans" Style="white-space: nowrap">Receivables and loaned amounts to others:</asp:Label>
                                <div class="col-lg-12">
                                    <asp:TextBox runat="server" ID="txtLoans" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Loans" TabIndex="4" AutoPostBack="True" Placeholder="$"  Text="0.00" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLoans" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" ValidationGroup="donate" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="well well-sm">
                        <h5><b>Personal Debts </b>
                        </h5>
                    </div>
                    <br />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtDebt" CssClass="col-lg-3 control-label" ToolTip="Debt" Style="white-space: nowrap">Amount Debts to be paid:</asp:Label>
                        <div class="col-lg-12">
                            <asp:TextBox runat="server" ID="txtDebt" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Debt" TabIndex="5" AutoPostBack="True" Placeholder="$" Text="0.00" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDebt" CssClass="text-danger" ErrorMessage="Error" Display="Static" ValidationGroup="donate" />
                        </div>
                    </div>
                    <br />
                    <br />
                    <br />
                    <br />
                    <div class="well well-sm">
                        <h5><b>Net Total Zakatable Wealth </b>
                        </h5>
                    </div>
                    <div class="col-lg-12">
                        <asp:TextBox runat="server" ID="txtNet" CssClass="form-control" ToolTip="Net" TabIndex="6" AutoPostBack="True" Enabled="True" Text="0.00" BackColor="#f5f5f5" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNet" CssClass="text-danger" Display="Static" />
                    </div>
                    <br />
                    <br />
                    <br />
                    <h3>
                        <asp:Button ID="btnDonation" runat="server" Text="Am I Eligible?" CssClass="btn btn-success" TabIndex="7" Width="150" />
                        <i class='fas fa-check-circle' style='color:darkgreen'> Yes you are</i> <i class='glyphicon glyphicon-remove' style='color:red'> No you are not</i></h3>
                </div>
            </div>
        </div>
</asp:Content>



