<%@ Page Title="Acceso Denegado" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ErrorAcceso.aspx.cs" Inherits="TPMarketingComercialArqWeb.ErrorAcceso" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .error-box {
        text-align: center;
        padding: 80px 40px;
        background: #fff5f5;
        border-radius: 12px;
        border: 2px solid #e94560;
        margin-top: 40px;
    }
    .error-box h1 {
        font-size: 5rem;
        color: #e94560;
        margin-bottom: 0;
    }
    .error-box h2 {
        color: #333;
        margin-bottom: 16px;
    }
    .error-box p {
        color: #666;
        font-size: 1.1rem;
        margin-bottom: 30px;
    }
</style>

<main>
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="error-box">
                <h1>🚫</h1>
                <h2>Acceso Denegado</h2>
                <p>No tenés permisos para acceder a esta sección.<br/>Contactá al administrador del sistema si creés que esto es un error.</p>
                <asp:HyperLink runat="server" NavigateUrl="~/Default.aspx" Text="Volver al inicio" CssClass="btn btn-primary btn-md" />
            </div>
        </div>
    </div>
</main>
</asp:Content>