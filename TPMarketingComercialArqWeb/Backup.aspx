<%@ Page Title="Backup" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Backup.aspx.cs" Inherits="TPMarketingComercialArqWeb.Backup" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .backup-header {
        background: linear-gradient(135deg, #1a1a2e 0%, #0f3460 100%);
        color: white;
        padding: 30px 40px;
        border-radius: 10px;
        margin-bottom: 28px;

        }
        .backup-header h1 { margin: 0 0 6px 0; font-size: 2rem; letter-spacing: 1px; }
        .backup-header p  { margin: 0; color: #a0c4ff; }
    </style>

<main>

    <div class="backup-header">
        <h1 id="aspnetTitle">🖨️ Backup & Restore</h1>
        <p>Guardar un backup y restaurar la base de datos.</p>
    </div>

    <div>
        <div>

            <asp:Button ID="btnBackup" runat="server" CssClass="btn btn-sm btn-primary me-1" 
                Text="Backup" OnClick="btnBackup_Click"/>

            <asp:FileUpload ID="fuRestore" runat="server" CssClass="form-control mt-2" />

            <asp:Button ID="btnRestore" runat="server" CssClass="btn btn-sm btn-primary me-1 mt-2" 
                Text="Restore" OnClick="btnRestore_Click" />

            <asp:Label ID="lblStatus" runat="server" CssClass="mt-3 text-info"></asp:Label>

        </div>
    </div>
</main>
</asp:Content>