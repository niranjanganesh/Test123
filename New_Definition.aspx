<%@ Page Language="C#" AutoEventWireup="true" CodeFile="New_Definition.aspx.cs" Inherits="New_Definition"
    Theme="Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ccl" %>
<%@ Register Assembly="Eliteology.Web.UI" Namespace="Eliteology.Web.UI" TagPrefix="eliteology" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Accident - New Item</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <link type="text/css" href="../App_Themes/Default/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <style type="text/css">
        html, body
        {
            overflow-x: hidden;
            overflow-y: auto;
        }
        fieldset
        {
            background-color: #fff !important;
        }
        table
        {
            table-layout: fixed;
            width: 100%;
        }
        table tr td
        {
            padding: 4px;
        }
        .ui-datepicker
        {
            left: 50% !important;
            top: 50% !important;
            margin-left: -104px !important;
            margin-top: -140px !important;
        }
        div.ajax-loading
        {
            border: 1px solid #000;
            white-space: nowrap;
            position: fixed;
            left: 2px;
            top: 100%;
            margin-top: -32px;
            color: #444444;
            z-index: 1000;
            padding: 8px 10px 8px 28px;
            font-size: 95%;
            font-weight: 600;
            background: #fff url(                            '../images/ajax-load-red.gif' ) 6px center no-repeat;
        }
        .Grid th
        {
        	text-align:left !important;
        }
        
    </style>

    <script type="text/javascript" src="../Common/js/jquery/jquery-1.6.2.min.js"></script>

    <script type="text/javascript" src="../Common/js/jquery/jquery-ui-1.8.16.custom.min.js"></script>

    <script type="text/javascript" src="../Common/js/jquery/jquery-ui-timepicker-addon.js"></script>

    <script src="../Common/js/jquery/jquery-ui-timepicker-addon-i18n.js" type="text/javascript"></script>

    <script src="../Common/js/jquery/jquery-ui-sliderAccess.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Common/js/jquery/jquery.utility.js"></script>

    <script type="text/javascript">
    
    var oldStartDate = "";
    var oldEndDate = "";
    var CountStart = 0;
    
    changeValidatePeriod();

        function preventKeyPress(e) {
            var evt = e || event;
            if ((Number(evt.keyCode) != 8) || (Number(evt.keyCode) != 46)) {
                alert("Please use date picker to select date");
                evt.returnValue = false;
                return false;
            }
            return true;
        }
        
        function NewRoadClousure(scn)
	    {
	     if(parent)
            {   
                if(parent.windows)
                {
                    parent.windows.hide();
                    window.parent.SetTimeInterval(scn,'roadclosure','');
                } 
            }      
	    }

        function CloseWindow(scn) {
            if (parent) {
                if(parent.window != null && parent.document.getElementById("ctl00_Content_hdnMoveToLocation") !=null && scn)
                    {
                       parent.document.getElementById("ctl00_Content_hdnMoveToLocation").value = "Accident&isSaveAndSetLocation=Yes";
                    }
                window.parent.Refresh();
                if (parent.windows) {
                    parent.windows.hide();
                    if (scn)
                        window.parent.MoveToLocation(scn);
                    else
                        parent.windows.dispose();
                }
            }

        }

       function EnableCalendar() {
	    $('input.DateTimePicker').cloudDatePicker();
	    }
	    
        function validateDate__(obj) {
            sVal = trim(obj.value);
            if (sVal != "") {
                if (!isValidDate(sVal)) {
                    alert("Invalid date");
                    obj.focus(); obj.select();
                    return false;
                }
            }
            return true;
        }

        function trim(sText) {
            if (sText) sText = sText.replace(/^\s+|\s+$/gi, "");
            return sText;
        }

        function isValidDate(sDate) {
            //format - dd/mm/yyyy[ hh:mm[:ss]] - 24 hrs

            var sReg = /^\d{1,2}\/\d{1,2}\/\d{4}( (([0-1]?[0-9])|([2][0-3]))\:[0-5][0-9](:[0-5][0-9])?)?$/;
            var dat;

            if (!sReg.test(sDate)) return false;

            sDate = sDate.indexOf(" ") > 0 ? sDate.substring(0, sDate.indexOf(" ")) : sDate;
            sArr = sDate.split("/");
            sArr[1] = sArr[1] - 1;
            dat = new Date(sArr[2], sArr[1], sArr[0]);

            if (dat.getDate() != sArr[0] || dat.getMonth() != sArr[1] || dat.getFullYear() != sArr[2]) return false;

            return true;
        }

        function ValidateDate(sender, args) {
            if (!isValidDate(trim(args.Value))) args.IsValid = false;
        }
        function ShowWait() {
            document.getElementById('waitImage').style.display = '';
            document.body.style.cursor = 'wait';

            //document.getElementById('btn_Save').style.cursor ='wait';
        }
        function HideWait() {
            document.getElementById('waitImage').style.visibility = 'hidden';
            document.body.style.cursor = 'default';
            // document.getElementById('btn_Save').style.cursor ='default';
        }
        $(function () {
            $('.alpha-Numeric').alphaNumeric();
            $('.input-SCN').inputSCN();
        });
        
          function restrictLegnth() {

            var field = document.getElementById('txtLongDescription');
            var max = 255;
            var len = field.value.length;
            if (len > max) {
                field.value = field.value.substr(0, max);
                return false;
            }
        }
        
        function restrictAdviceLegnth() {
 
            var field = document.getElementById('txtAdvice');
            var max = 255;
            var len = field.value.length;
            if (len > max) {
                field.value = field.value.substr(0, max);
                return false;
            }
        }
        

         
        function changeDisplay(){
            if($('input[name=rdDiversion]:checked').val() == 'N'){
                $('#txtDiversionRoute1').val("");
                $('#txtDiversionRoute2').val("");
                $('#txtDiversionRoute3').val("");
                $('#txtDiversionRoute4').val("");
                $('#trDivRouteOpt').css('display', 'none');
                $('#trDivRoute').css('display', 'none');
                $('#ddlRoadClosure').attr('selectedIndex', 0);
                $('#liDiversion').empty();
                $('#trCreateOrSelectDiversionRoute').css('display', 'none');
            }
            else{
                $('#trDivRouteOpt').css('display', 'table-row');
                $('#trDivRoute').css('display', 'table-row');
                $('#trCreateOrSelectDiversionRoute').css('display', 'table-row');
            }
        }
    

function changeValidatePeriod(){

if($('input[name=rdbtnValidityPeriod]:checked').val() == 'N')
{
var txt;
var rowCount = $('#gvRecurrent tr').length;
if(rowCount > 0)
{
var r = confirm("Changing recurring validity period to 'No' and clicking save button will delete the existing recurring records ");
 
debugger;
if (r == true) {

ShowRecurringDetails();
}


else
{


var RB1 = document.getElementById("rdbtnValidityPeriod");
var radio = RB1.getElementsByTagName("input");


for (var i = 0; i < radio.length; i++) {

if (radio[i].value == "Y") {
radio[i].checked = true;
}
}
}
HideRecurringDetails()


}


else{

HideRecurringDetails();
}

}
else
{
ShowRecurringDetails();
}

}

        
        function ShowRecurringDetails()
        {
            $('#trValidateStartDate').css('display', 'table-row');
                $('#trValidateEndDate').css('display', 'table-row');
                $('#trGvRecurrent').css('display', 'table-row');
                $('#trRecurrentDays').css('display', 'table-row');
                $('#trAddRecurringDetails').css('display', 'table-row');
        }
        
        function HideRecurringDetails()
        {
         $('#trValidateStartDate').css('display', 'none');
                $('#trValidateEndDate').css('display', 'none');
                $('#trGvRecurrent').css('display', 'none');
                $('#trRecurrentDays').css('display', 'none');
                   $('#lblerr').css('display', 'none');
                    $('#trAddRecurringDetails').css('display', 'none');
        }
        function clearSelection(el){
            var lb = (el.id == 'btnClearRecurrent') ? "lbRecurrent" : "lbCarPark";
            $("#" + lb).find("option:selected").attr("selected", false);
            return false;
        }
        
        function selectAll(){
            $("#lbRecurrent option").prop("selected",true);
        }

    </script>

    <script type="text/javascript">
    function checkDelete()
    {
     var s = confirm("Are you sure you want to delete?");
     document.getElementById('hdnDelete').value = s;
    }
    
    function createSummary()
    {
     var summary = "";
     if ($("#ddlDataSource option:selected").text() != "Please Select")
     {
        summary = $("#txtName").val() + "," + $("#txtShortDescription").val() + "," +$("#ddlDataSource option:selected").text();
     }
     else
     {
        summary = $("#txtName").val() + "," + $("#txtShortDescription").val();
     }
     if ($("#ddlType option:selected").text() != "Please Select")
     {
        summary = summary + "," +$("#ddlType option:selected").text();
     }
     
     $("#txtSummary").val(summary);
    }
    
    function CheckDateRange()
    {
      var s = confirm("Start/End Date changed. Do you want to continue?");
      document.getElementById('hdnDatecheck').value = s;      
    }
    </script>

</head>
<body>
    <form method="post" runat="server" id="main" enctype="multipart/form-data">
    <%--<div id="waitImage" style="border: solid 1px black; padding: 10px 10px 10px 10px;background-color: White; position: absolute; z-index: 50; top: 45%; right: 45%;display:none">
            <img alt="Please wait" src="../images/wait.gif" />
        </div>--%>
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="updatePanel1" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" width="100%" id="tblRecord" runat="server">
                <tr>
                    <td>
                        <h1>
                            <asp:Label ID="lblPageHeading" runat="server" Text="Accident - Creation"></asp:Label></h1>
                    </td>
                </tr>
                <tr>
                    <td>
                        <fieldset style="border: 1px solid #FF6600; width: 95%">
                            <legend style="font-weight: bold; color: Red">Definition</legend>
                            <table>
                                <tr id="trSCN" runat="server" visible="false">
                                    <td width="34%" valign="top">
                                        System Code Number
                                        <br />
                                        (Alpha Numeric 32 Chars)
                                    </td>
                                    <td style="padding-bottom: 1.8em;">
                                        <asp:TextBox CssClass="input-SCN" ID="txtSCN" runat="server" MaxLength="32" Width="98%"></asp:TextBox>
                                        <%--  </td>
                                    <td>--%>
                                        <%--<asp:RequiredFieldValidator ID="requiredFieldValidatorShortDesc" runat="server" ControlToValidate="txtShortDescription" ErrorMessage="Enter short description"></asp:RequiredFieldValidator>--%>
                                        <label id="lblSCN" runat="server" class="lblAlert" visible="false">
                                            System Code Number already exists</label>
                                        <input type="hidden" id="hdnExistingSCN" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="34%" valign="top">
                                        * Name(32 Chars)
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtName" runat="server" MaxLength="32" Width="98%" onkeyup="createSummary();"></asp:TextBox>
                                        <%-- </td>
                                    <td>--%>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidatorName" runat="server" ControlToValidate="txtName"
                                            ErrorMessage="Enter name"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="34%" valign="top">
                                        * Short Description(32 Chars)
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtShortDescription" runat="server" MaxLength="32" Width="98%" onkeyup="createSummary();"></asp:TextBox>
                                        <%--   </td>
                                    <td>--%>
                                        <asp:RequiredFieldValidator ID="requiredFieldValidatorShortDesc" runat="server" ControlToValidate="txtShortDescription"
                                            ErrorMessage="Enter short description"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="34%" valign="top">
                                        Long Description(255 Chars)
                                    </td>
                                    <td style="padding-bottom: 1.8em;">
                                        <asp:TextBox ID="txtLongDescription" runat="server" TextMode="MultiLine" MaxLength="255"
                                            Width="98%" onkeyup="return restrictLegnth()"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="34%" valign="top">
                                        Location(255 Chars)
                                    </td>
                                    <td style="padding-bottom: 1.8em;">
                                        <asp:TextBox ID="txtLocationDescription" runat="server" MaxLength="255" Width="98%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="34%" valign="top">
                                        * Data Source
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDataSource" runat="server" Width="99%" onchange="createSummary();">
                                        </asp:DropDownList>
                                        <%-- </td>
                                    <td>--%>
                                        <asp:CustomValidator ID="CustomDataSource" runat="server" OnServerValidate="CustomDdl_ServerValidate"
                                            ErrorMessage="Please Select" ControlToValidate="ddlDataSource"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="34%" valign="top">
                                        <%--* Severity--%>
                                        * Traffic Impact
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSeverity" runat="server" Width="99%">
                                        </asp:DropDownList>
                                        <%--  </td>
                                    <td>--%>
                                        <asp:CustomValidator ID="CustomSeverity" runat="server" OnServerValidate="CustomDdl_ServerValidate"
                                            ErrorMessage="Please Select" ControlToValidate="ddlSeverity"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="34%" valign="top">
                                        * Type
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlType" runat="server" Width="99%" onchange="createSummary();">
                                        </asp:DropDownList>
                                        <%--   </td>
                                    <td>--%>
                                        <asp:CustomValidator ID="CustomType" runat="server" OnServerValidate="CustomDdl_ServerValidate"
                                            ErrorMessage="Please Select" ControlToValidate="ddlType"></asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="34%" valign="top">
                                        * Quality Statement
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlQualityStatement" runat="server" Width="99%">
                                        </asp:DropDownList>
                                        <%-- </td>
                                    <td>--%>
                                        <asp:CustomValidator ID="CustomQualityStatement" runat="server" OnServerValidate="CustomDdl_ServerValidate"
                                            ErrorMessage="Please Select" ControlToValidate="ddlQualityStatement"></asp:CustomValidator>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr id="trVoyager" runat="server">
                                    <td width="34%" valign="top">
                                        Publication on voyager
                                    </td>
                                    <td valign="top">
                                        <asp:DropDownList ID="ddlvoyager" runat="server" Width="99%">
                                            <asp:ListItem Text="Please Select" Value="1" Selected="True"></asp:ListItem>
                                            <%-- <asp:ListItem Text="Not yet classified for publication on Voyager" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Publish on Voyager" Value="1000"></asp:ListItem>
                                            <asp:ListItem Text=",Do not publish on Voyager" Value="1001"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                        <span style="visibility: hidden">*</span>
                                    </td>
                                </tr>
                                <tr id="trSummary" runat="server">
                                    <td width="32%" valign="top">
                                        Summary
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSummary" runat="server" TextMode="MultiLine" Width="98%" MaxLength="255"
                                            Enabled="false"></asp:TextBox>
                                        <span style="visibility: hidden">*</span>
                                    </td>
                                </tr>
                                <tr id="trAdvice" runat="server">
                                    <td width="32%" valign="top">
                                        Advice Information(255 Chars)
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAdvice" runat="server" TextMode="MultiLine" Width="98%" MaxLength="255"
                                            onkeyup="return restrictAdviceLegnth();"></asp:TextBox>
                                        <span style="visibility: hidden">*</span>
                                    </td>
                                </tr>
                                <tr id="trStatus" runat="server">
                                    <td width="32%" valign="top">
                                        Status
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlStatus" runat="server" Width="99%">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset style="border: 1px solid #FF6600; width: 95%">
                            <legend style="font-weight: bold; color: Red">Dates and Times</legend>
                            <table>
                                <tr>
                                    <td valign="top">
                                        * Start
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtStart" CssClass="DateTimePicker" onkeypress="return preventKeyPress();"
                                            onpaste="return false" runat="server" Width="80%" CausesValidation="true" Style="vertical-align: top"></asp:TextBox>
                                    </td>
                                    <td>
                                        <%--                                            <asp:CustomValidator ID="customStartDate" runat="server" ControlToValidate="txtStart" ErrorMessage="Invalid Date" ClientValidationFunction="ValidateDate" ></asp:CustomValidator>     
                                        --%>
                                        <asp:Label ID="lblStartDateAlert" runat="server" Visible="false" Style="color: Red"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        End
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtE" class="DateTimePicker" onkeypress="return preventKeyPress();"
                                            onpaste="return false" runat="server" Width="80%" Style="vertical-align: top"
                                            CausesValidation="true"></asp:TextBox>
                                    </td>
                                    <td>
                                        <%--                                            <asp:CustomValidator ID="customEndDate" runat="server" ControlToValidate="txtEnd" ErrorMessage="Invalid Date" ClientValidationFunction="ValidateDate" ></asp:CustomValidator>     
                                        --%>
                                        <asp:Label ID="lblEndDateAlert" runat="server" Visible="false" Style="color: Red"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset style="border: 1px solid #FF6600; width: 95%">
                            <legend style="font-weight: bold; color: Red">Diversions</legend>
                            <table  width="100%">
                                <tr>
                                    <td width="33%" colspan="1">
                                        &nbsp;Diversion In Force
                                    </td>
                                    <td  width ="66%" colspan="1">
                                        <asp:RadioButtonList ID="rdDiversion" runat="server" onclick="javascript:changeDisplay()">
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="N" Selected="True"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                  </table>
                                <table width="100%">
                                <tr id="trDivRouteOpt" runat="server" width="100%">
                                    <td  width="33%" colspan="1">
                                        &nbsp;Diversion Route Options
                                    </td>
                                    <td width ="67%" colspan="1" >
                                        <asp:RadioButtonList ID="rdoDiversionRoute" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rdoDiversionRoute_SelectedIndexChanged">
                                            <asp:ListItem Text="Enter Diversion Route" Value="1" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Create Or Select Diversion Route" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                             
                                <tr  id="trDivRoute" runat="server"  width="100%">
                                    <td colspan="2" >
                                        <table cellpadding="0" cellspacing="0" width="100%" id="tblDiversionRoute" runat="server">
                                            <tr>
                                                <td width="34%" valign="top">
                                                    Diversion Route 1(254 Chars)
                                                </td>
                                                <td width ="66%" >
                                                    <asp:TextBox ID="txtDiversionRoute1" runat="server" MaxLength="254" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="34%" valign="top">
                                                    Diversion Route 2(254 Chars)
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDiversionRoute2" runat="server" MaxLength="254" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="34%" valign="top">
                                                    Diversion Route 3(254 Chars)
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDiversionRoute3" runat="server" MaxLength="254" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="34%" valign="top">
                                                    Diversion Route 4(254 Chars)
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtDiversionRoute4" runat="server" MaxLength="254" Width="98%"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trCreateOrSelectDiversionRoute" runat="server">
                                    <td colspan="2">
                                        <table cellpadding="0" cellspacing="0" width="100%" id="rowDiversionRoute" runat="server">
                                            <tr>
                                                <td width="34%">
                                                    Road Closure
                                                </td>
                                                <td width="66%">
                                                    <asp:DropDownList ID="ddlRoadClosure" runat="server" Width="100%" OnSelectedIndexChanged="ddlRoadClosure_SelectedIndexChanged"
                                                        AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Diversion Routes (Select Diversion routes from list item by single click. For multiple
                                                    selection press Ctrl + Click)
                                                </td>
                                                <td>
                                                    <asp:ListBox ID="liDiversion" runat="server" Height="100%" SelectionMode="Multiple" Width="100%">
                                                    </asp:ListBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:CustomValidator ID="cvListDiversion" runat="server" OnServerValidate="CustomList_ServerValidate"
                                                        ErrorMessage="Please Select Diversion Route" ControlToValidate="liDiversion"
                                                        ValidateEmptyText="true"></asp:CustomValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset style="border: 1px solid #FF6600; width: 95%">
                            <legend style="font-weight: bold; color: Red">Optional Values</legend>
                            <table  width="100%">
                                <tr>
                                    <td width="34%" valign="top">
                                        Phase
                                    </td>
                                    <td width="66%" style="padding-bottom: 1.8em;">
                                        <asp:TextBox ID="txtPhase" runat="server" MaxLength="254" Width="97%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td  width="34%" valign="top">
                                        Lanes Affected
                                    </td>
                                    <td  width="66%">
                                        <asp:TextBox ID="txtLanesAffected" runat="server" MaxLength="2" Width="97%"></asp:TextBox>
                                        <%--  </td>
                                    <td>--%>
                                        <asp:RangeValidator ID="rangeLanesAffected" runat="server" ControlToValidate="txtLanesAffected"
                                            MinimumValue="0" MaximumValue="10" Type="Integer" ErrorMessage="Please enter values between 0 and 10"></asp:RangeValidator>
                                    </td>
                                </tr>
                                <tr id="trTwitter" runat="server">
                                    <td  width="34%">
                                        Send to Twitter?
                                    </td>
                                    <td  width="34%">
                                        <%--<asp:CheckBox ID="chktwitter" runat="server" MaxLength="2" Width="97%"></asp:CheckBox>--%>
                                        <%--<asp:CheckBox ID="chktwitter" runat="server"  style=" position:relative;left:-2%;" />--%>
                                        <asp:CheckBox ID="chktwitter" runat="server" Style="margin-left: -4px;" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <%-- Recurrent incidents --%>
                        <div id="divRecurrent" runat="server" >
                            <fieldset style="border: 1px solid #FF6600; width: 95%">
                            
                                <legend style="font-weight: bold; color: Red">Recurring Accidents</legend>
                                <table>
                                    <tr>
                                    
                                        <%--<td width="32%" valign="top">
                                            Date Range
                                        </td>
                                        <td valign="bottom">
                                            <asp:DropDownList ID="ddlDateRange" runat="server" Width="99%" OnSelectedIndexChanged="ddlDateRange_SelectedIndexChanged"
                                                AutoPostBack="true">
                                            </asp:DropDownList>
                                        </td>--%>
                                        <td width="32%">
                                            Validity Period
                                        </td>
                                        <td valign="bottom">
                                            <asp:RadioButtonList ID="rdbtnValidityPeriod" runat="server">
                                                <asp:ListItem Text="Yes" onclick="javascript:changeValidatePeriod()" Value="Y"></asp:ListItem>
                                                <asp:ListItem Text="No" onclick="javascript:changeValidatePeriod()" Value="N" Selected="True"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr id="trValidateStartDate" runat="server">
                                        <td width="32%" valign="top">
                                            Validity Start
                                        </td>
                                        <td>
                                         
                                            <asp:TextBox ID="txtValidityStartDate" CssClass="DateTimePicker" onkeypress="return preventKeyPress();"
                                                onpaste="return false" runat="server" CausesValidation="true" Width="80%" 
                                                Style="vertical-align: top"></asp:TextBox>
                                        </td>
                              
                                    </tr>
                                    <tr id="trValidateEndDate" runat="server">
                                        <td valign="top">
                                            Validity End
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtValidityEDate" CssClass="DateTimePicker" onkeypress="return preventKeyPress();"
                                                onpaste="return false" runat="server" Width="80%" Style="vertical-align: top"
                                                 CausesValidation="true"></asp:TextBox>
                                            <%--<asp:TextBox ID="txtValidityEDate" class="DateTimePicker" onkeypress="return preventKeyPress();"
                                            onpaste="return false" runat="server" Width="80%" Style="vertical-align: top"
                                             CausesValidation="true" OnTextChanged="txtedate_TextChanged"></asp:TextBox>--%>
                                        </td>
                                    
                                    </tr>
                                    <tr id="trRecurrentDays" runat="server">
                                        <td valign="top" width="32%">
                                            Select Recurring Days<br />
                                            (For multiple selection
                                            <br />
                                            press Ctrl + Click)
                                        </td>
                                        <td colspan="2">
                                            <asp:ListBox ID="lbRecurrent" Rows="4" runat="server" Width="99%" Height="100%" SelectionMode="Multiple">
                                            </asp:ListBox>
                                            <a id="btnClearRecurrent" style="cursor: pointer" onclick="javascript:clearSelection(this);">
                                                <b>Clear All Selection </b></a>
                                        </td>
                                    </tr>
                                
                                    <tr id="trAddRecurringDetails" runat="server">
                                        <td align="left" style="word-wrap:break-word">
                                            <asp:Label ID="lblerr" Text="" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                                        </td>
                                        <td align="left" style="margin-right: 20px;">
                                           
                                            <asp:ImageButton ID="btnAdd" runat="server" Text="Add" ToolTip="Add Recurring accident" ImageUrl="~/Common/images/OKLargeNEW.GIF"
                                                CausesValidation="false" OnClick="btnAdd_Click" />
                                            <asp:HiddenField ID="hdnStartDate" runat="server" />
                                            <asp:HiddenField ID="hdnEndDate" runat="server" />
                                            <asp:HiddenField ID="hdnDelete" runat="server" />
                                            <asp:HiddenField ID="hdnDatecheck" runat="server" />
                                            <asp:HiddenField ID="hdnStart" runat="server" />
                                            <asp:HiddenField ID="hdnEnd" runat="server" />
                                            <cc1:ConfirmButtonExtender ID="cbe" runat="server" DisplayModalPopupID="mpe" TargetControlID="hdnAdd">
                                            </cc1:ConfirmButtonExtender>
                                            <asp:LinkButton ID="hdnAdd" runat="server" Style="display: none"></asp:LinkButton>
                                            <asp:LinkButton ID="hdnYes" runat="server" Style="display: none"></asp:LinkButton>
                                            <asp:LinkButton ID="hdnNo" runat="server" Style="display: none"></asp:LinkButton>
                                            <cc1:ModalPopupExtender ID="mpe" runat="server" PopupControlID="pnlPopup" TargetControlID="hdnAdd"
                                                OkControlID="hdnYes" CancelControlID="hdnNo" BackgroundCssClass="popupBackground">
                                            </cc1:ModalPopupExtender>
                                            <asp:Panel ID="pnlPopup" runat="server" Style="display: none; background-color: White;
                border: 1px solid #FF6600; padding: 20px 20px 10px 20px; text-align: center;
                width: 420px;">
                     <h1>
                        Delete Recurring Records</h1>
                                                <div>
                                                    Changing accident date period will add new recurring records and delete the invalid records.Are you sure you want to delete?
                                                </div>
                                                <br />
                                                <div style="text-align: center">
                                                    <asp:ImageButton ID="btnYes" runat="server" ToolTip="Yes" SkinID="btnOKLarge"  OnClick="btnYes_Click" />
                                                    <asp:ImageButton ID="btnNo" runat="server" ToolTip="No" SkinID="btnCancelLarge"  OnClick="btnNo_Click" />
                                                </div>
                                                
                                                   
                   
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                   
                                    <tr id="trGvRecurrent" runat="server">
                                        <td colspan="3">
                                            <asp:GridView ID="gvRecurrent" runat="server" SkinID="GridView" EnableViewState="true"
                                                AllowPaging="True" AllowSorting="True" Width="99%" AutoGenerateColumns="False"
                                                DataKeyNames="ValidateStartDate,RecurrentDay" OnRowDeleting="gvRecurrent_RowDeleting"
                                                OnRowCommand="gvRecurrent_RowCommand" OnRowDataBound="gvRecurrent_RowDataBound"
                                                OnRowEditing="gvRecurrent_RowEditing">
                                                <Columns>
                                                   
                                                    <asp:TemplateField HeaderText="Validate StartDate">
                                                        <ItemTemplate>
                                                            
                                                            <asp:Label ID="lblRangeID" runat="server" Text='<%# Bind("ValidateStartDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                      
                                                        <HeaderStyle HorizontalAlign="Left" Width="30%" />
                                                        <ItemStyle Width="30%" />
                                                    </asp:TemplateField>
                                                  
                                                    <asp:TemplateField HeaderText="Validate EndDate">
                                                        <ItemTemplate>
                                                        
                                                            <asp:Label ID="lblRange" runat="server" Text='<%# Bind("ValidateEndDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    
                                                        <HeaderStyle HorizontalAlign="Left" Width="30%" />
                                                        <ItemStyle Width="30%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Recurring Day">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDay" runat="server" Text='<%# Bind("RecurrentDay") %>' Visible="false"></asp:Label>
                                                            <asp:Label ID="lblDayname" runat="server" Text='<%# Bind("DayName") %>'></asp:Label>
                                                        </ItemTemplate>


                                                        <HeaderStyle HorizontalAlign="Left" Width="29%" />
                                                        <ItemStyle Width="29%" />
                                                    </asp:TemplateField>

                                                    <%--  <asp:TemplateField HeaderText="Edit" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkBtnEdit" Text="Edit" runat="server" CommandName="Select"></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" />
                                               
                                                    </asp:TemplateField>--%>
                                                    <asp:TemplateField HeaderText="Delete">
                                                        <ItemTemplate>


                                                            <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" OnClientClick="return checkDelete();return false;"
                                                                CausesValidation="False" CommandArgument='<%# Container.DataItemIndex %>' CommandName="Delete"></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" Width="10%" />
                                                        <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField ID="hdnSave" runat="server" Value="" />
                        <asp:Button ID="btnSave" runat="server" Text="Save and close without setting a location"
                            CausesValidation="true" OnClick="btnSave_Click" />
                        &nbsp;
                        <asp:Button ID="btnSaveAndSetLocation" runat="server" Text="Set a location and Save"
                            OnClick="btnSaveAndSetLocation_Click" CausesValidation="true" />
                             <asp:LinkButton ID="hdBtnSave" runat="server" Style="display: none"></asp:LinkButton>
                                            <asp:LinkButton ID="hdnBtnCancel" runat="server" Style="display: none"></asp:LinkButton>
                                            <asp:LinkButton ID="hdnTargetSave" runat="server" Style="display: none"></asp:LinkButton>
                                            <asp:LinkButton ID="hdnTargetSaveLocation" runat="server" Style="display: none"></asp:LinkButton>
                             <cc1:ModalPopupExtender ID="MpeSave" runat="server" PopupControlID="pnlSavePopup" TargetControlID="hdnTargetSave"
                                                OkControlID="hdBtnSave" CancelControlID="hdnBtnCancel" BackgroundCssClass="popupBackground">
                                            </cc1:ModalPopupExtender>
                                          
                                            <asp:Panel ID="pnlSavePopup" runat="server" Style="display: none; background-color: White;
                border: 1px solid #FF6600; padding: 20px 20px 10px 20px; text-align: center;
                width: 420px;">
                                                 <h1>
                        Delete Recurring Records</h1>
                                                <div>
                                                    Changing accident date period will delete the invalid recurring records.Are you sure you want to delete?
                                                </div>
                                                <br />
                                                <div style="text-align: center">
                                                    <asp:ImageButton ID="BtnDeleteInvalidRecurring" ToolTip="Yes" runat="server" SkinID="btnOKLarge" 
                                                        onclick="BtnDeleteInvalidRecurring_Click" />
                                                    <asp:ImageButton ID="BtnCancelInvalidRecurring" ToolTip ="No" runat="server" SkinID="btnCancelLarge" 
                                                        onclick="BtnCancelInvalidRecurring_Click"  />
                                                </div>
                                            </asp:Panel>
                                             <cc1:ModalPopupExtender ID="MpeSaveLocation" runat="server" PopupControlID="pnlSaveLocationPopup" TargetControlID="hdnTargetSaveLocation"
                                                OkControlID="hdBtnSave" CancelControlID="hdnBtnCancel" BackgroundCssClass="popupBackground">
                                            </cc1:ModalPopupExtender>
                                          
                                            <asp:Panel ID="pnlSaveLocationPopup" runat="server"  Style="display: none; background-color: White;
                border: 1px solid #FF6600; padding: 20px 20px 10px 20px; text-align: center;
                width: 420px;">
                                        <h1>
                        Delete Recurring Records</h1>
                                                <div>
                                                    Changing accident date period will add new recurring records and delete the invalid recurring records.Are you sure you want to delete?
                                                </div>
                                                <br />
                                                <div style="text-align: center">
                                                    <asp:ImageButton ID="BtnLocationDeleteInvalidRecurring" runat="server" ToolTip="Yes" SkinID="btnOKLarge" onclick="BtnLocationDeleteInvalidRecurring_Click" 
                                                         />
                                                    <asp:ImageButton ID="BtnLocationCancelInvalidRecurring" runat="server" ToolTip="No" SkinID="btnCancelLarge"  onclick="BtnLocationCancelInvalidRecurring_Click" 
                                                         />
                                                </div>
                                            </asp:Panel>
                    </td>
                </tr>
            </table>
            <table id="tbl_Result" style="margin-top: 100px" runat="server" cellpadding="0" align="center"
                cellspacing="0" width="60%" class="RolesTableBorder" visible="false">
                <tr>
                    <td align="center" valign="middle" style='text-align: center; vertical-align: middle'>
                        <p>
                            <p style='text-align: center;'>
                                Accident saved successfully. You may now close this window.</p>
                    </td>
                </tr>
            </table>
            <%-- Recurrent incidents --%>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="updatepanel1"
        DisplayAfter="100" DynamicLayout="true">
        <ProgressTemplate>
            <div id="ProgressBar" class="ajax-loading">
                Working on your request...</div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    </form>
</body>

<script type="text/javascript">
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (sender, args) {
            EnableCalendar();
            $('.alpha-Numeric').alphaNumeric();
            $('.input-SCN').inputSCN();     
        });
        
        function ConfirmApproval(objMsg)
    {
        if(confirm(objMsg))
        {
            
            return true;
        }    
        else
            return false;    
    }
</script>

</html>
