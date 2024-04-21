<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Temp.aspx.vb" Inherits="zakat.icclmd.org.Temp" %>

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
  <br />
  <ajaxToolkit:Accordion ID="accZakat" runat="server" BorderWidth="0px" RequireOpenedPane="False" FadeTransitions="True" HeaderCssClass="accordionHeader" HeaderSelectedCssClass="accordionHeaderSelected" ContentCssClass="accordionContent" SelectedIndex="-1" BorderStyle="None" AutoSize="None" Height="625px" Enabled="false">
    <Panes>
      <ajaxToolkit:AccordionPane runat="server" ID="paneReply" TabIndex="600">
        <Header>
          <table style="width: 100%">
            <tr>
              <th style="width: 25%; text-align: left; vertical-align: middle">Reply To The Post
              </th>
              <th style="width: 50%; text-align: center; vertical-align: middle">
                <div class="progress" style="position: relative; top: 10px;">
                  <div id="prgStatement" runat="server" class="progress-bar progress-bar-progress progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%; color: black">
                    <asp:Literal ID="ltlPercentStatement" runat="server" Text="0% Complete"></asp:Literal>
                  </div>
                </div>
              </th>
              <th style="width: 25%; text-align: right; vertical-align: middle">
                <span class="glyphicon glyphicon-triangle-bottom"></span>
              </th>
            </tr>
          </table>
        </Header>
        <Content>
          <br />
          <table border="1" style="width: 100%">
            <tr>
              <td style="width: 100%; padding: 5px">
                <asp:Label runat="server" AssociatedControlID="txtPersonalStatement" CssClass="control-label" ToolTip="Personal Statement" Style="white-space: nowrap">Briefly describe your personal and/or family needs (1000 characters max):<span style="color: red">*</span></asp:Label>
                <asp:TextBox runat="server" ID="txtPersonalStatement" AutoCompleteType="Disabled" MaxLength="1000" TabIndex="601" TextMode="MultiLine" Rows="5" Width="100%" Style="max-width: 100%" ValidationGroup="Submit" AutoPostBack="True" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPersonalStatement" CssClass="text-danger" ErrorMessage="The personal statement is required." Display="Static" ValidationGroup="Submit" />
              </td>
            </tr>
          </table>
        </Content>
      </ajaxToolkit:AccordionPane>
    </Panes>
  </ajaxToolkit:Accordion>
</asp:Content>
