<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Donate.aspx.vb" Inherits="zakat.icclmd.org.Donate" %>

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
                      <asp:Label runat="server" AssociatedControlID="txtPaymentMethod" CssClass="col-lg-3 control-label" ToolTip="Payment Method" Style="white-space: nowrap">Payment Method:</asp:Label>
                      <div class="col-lg-9">
                          <asp:TextBox Text="PayPal" runat="server" ID="txtPaymentMethod" CssClass="form-control" autocomplete="off" type="tel" ToolTip="Payment Amount" MaxLength="3" TabIndex="3" Enabled="false" />
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPaymentMethod" CssClass="text-danger" ErrorMessage="The payment method is required." InitialValue="(Select One)" />
                      </div>
                  </div>
                  <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtPaymentAmount" CssClass="col-lg-3 control-label" ToolTip="Payment Amount" Style="white-space: nowrap">Payment Amount:</asp:Label>
                      <div class="col-lg-9">
                          <table style="width: 280px" border="0">
                              <tr>
                                  <td>$</td>
                                  <td>
                                      <asp:TextBox runat="server" ID="txtPaymentAmount" CssClass="form-control" autocomplete="off" type="tel" ToolTip="Payment Amount" MaxLength="3" placeholder="" TabIndex="4" Style="text-align: right" Enabled="true" /></td>
                                  <td>.00</td>
                              </tr>
                          </table>
                          <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPaymentAmount" CssClass="text-danger" ValidationExpression="^[0-9]*$" ErrorMessage="A valid payment amount is required." Display="Dynamic"></asp:RegularExpressionValidator>
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPaymentAmount" CssClass="text-danger" ErrorMessage="The payment amount is required." Display="Static" />
                      </div>
                  </div>
                  </div>
          </div>
          <div class="col-lg-6">
              <div class="form-horizontal">
                  <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtPaymentDate" CssClass="col-lg-3 control-label" ToolTip="Payment Date">Payment Date:</asp:Label>
                      <div class="col-lg-9">
                          <asp:TextBox runat="server" ID="txtPaymentDate" CssClass="form-control" ToolTip="Payment Date" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="2" Enabled="true" />
                          <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter a valid payment date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtPaymentDate"></asp:RegularExpressionValidator>
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPaymentDate" CssClass="text-danger" ErrorMessage="The payment date is required." Display="Static" />
                          <ajaxToolkit:CalendarExtender ID="calPaymentDate" runat="server" TargetControlID="txtPaymentDate" PopupButtonID="lnkCalendar" />
                      </div>
                  </div>
                  <div class="form-group">
                     <div class="col-lg-3"></div>
                      <div class="col-lg-9">
                         <asp:Button ID="Button1" runat="server" Text="Make Payment" CssClass="btn btn-success" TabIndex="5" Width="150" />
                      </div>
                  </div>
              </div>
          </div>
      </div>
      <br />
      <br />
      <br />
  </div>
</asp:Content>
