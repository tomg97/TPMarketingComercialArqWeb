<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPMarketingComercialArqWeb.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .login-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px 0;
    }
    .login-box {
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 24px rgba(0,0,0,0.10);
        padding: 48px 40px;
        width: 100%;
        max-width: 420px;
    }
    .login-box .login-logo {
        text-align: center;
        margin-bottom: 8px;
        font-size: 2.4rem;
    }
    .login-box h2 {
        text-align: center;
        color: #0f3460;
        font-weight: 700;
        margin-bottom: 4px;
    }
    .login-box .login-sub {
        text-align: center;
        color: #888;
        font-size: 0.95rem;
        margin-bottom: 28px;
    }
    .login-box .form-label {
        color: #333;
        font-weight: 600;
    }
    .login-box .form-control {
        border-radius: 8px;
        padding: 10px 14px;
    }
    .login-box .btn-ingresar {
        width: 100%;
        background: #0f3460;
        color: white;
        border: none;
        border-radius: 8px;
        padding: 12px;
        font-size: 1rem;
        font-weight: 600;
        margin-top: 8px;
        transition: background 0.3s;
    }
    .login-box .btn-ingresar:hover { background: #e94560; }
    .login-box .btn-ingresar:disabled { background: #aaa; cursor: not-allowed; }
    .error-msg {
        color: #e94560;
        font-size: 0.92rem;
        margin-top: 12px;
        text-align: center;
        display: block;
    }
    .exito-msg {
        background: #d4edda;
        border: 1px solid #28a745;
        border-radius: 8px;
        padding: 14px 18px;
        text-align: center;
        color: #155724;
        font-weight: 600;
    }
    .inconsistencia-msg{
        background: #ffe1e0;
        border: 1px solid #f40800;
        border-radius: 8px;
        padding: 14px 18px;
        text-align: center;
        color: #fff4f4;
        font-weight: 600;
    }
</style>

<main>
    <div class="login-wrapper">
        <div class="login-box">

            <div class="login-logo">🖨️</div>
            <h2>3D Shop</h2>
            <p class="login-sub">Ingresá con tu usuario y contraseña</p>

            <div class="mb-3">
                <asp:Label AssociatedControlID="txtUsername" Text="Usuario" CssClass="form-label" runat="server" />
                <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server" placeholder="Nombre de usuario" />
                <asp:RequiredFieldValidator ControlToValidate="txtUsername" ErrorMessage="Ingrese usuario"
                    Display="Dynamic" CssClass="text-danger" runat="server" ValidationGroup="loginGroup" />
            </div>

            <div class="mb-3">
                <asp:Label AssociatedControlID="txtPassword" Text="Contraseña" CssClass="form-label" runat="server" />
                <asp:TextBox ID="txtPassword" CssClass="form-control" TextMode="Password" runat="server" placeholder="Contraseña" />
                <asp:RequiredFieldValidator ControlToValidate="txtPassword" ErrorMessage="Ingrese contraseña"
                    Display="Dynamic" CssClass="text-danger" runat="server" ValidationGroup="loginGroup" />
            </div>

            <asp:RegularExpressionValidator 
                ID="RegularExpressionValidator1" 
                runat="server" 
                ControlToValidate="txtPassword" 
                ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$" 
                ErrorMessage="La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial (@$!%*?&)." 
                ForeColor="Red"
                Display="Dynamic">
            </asp:RegularExpressionValidator>

            <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                CssClass="text-danger mb-2" ValidationGroup="loginGroup" />

            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-ingresar" 
                Text="Ingresar" OnClick="btnLogin_Click" ValidationGroup="loginGroup" />

            <asp:Label ID="lblError" runat="server" CssClass="error-msg" Visible="false" />

            <asp:Panel ID="pnlExito" runat="server" Visible="false" CssClass="exito-msg mt-3">
                <asp:Label ID="lblExito" runat="server" />
            </asp:Panel>

            <asp:Panel ID="pnlInconsistencia" runat="server" Visible="false" CssClass="inconsistencia-msg mt-3">
                <asp:Label ID="lblInconsistencia" runat="server" />
            </asp:Panel>

        </div>
    </div>
</main>
</asp:Content>