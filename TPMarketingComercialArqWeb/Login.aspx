<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPMarketingComercialArqWeb.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">Log In</h1>
            <p class="lead">Inicie sesión con su usuario y contraseña.</p>
        </section>

        <div class="row">
            <div class="col-md-6 offset-md-3">
                <asp:Panel CssClass="card p-4" runat="server">
                    <div class="mb-3">
                        <asp:Label AssociatedControlID="txtUsername" Text="Usuario" CssClass="form-label" runat="server" />
                        <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server" />
                        <asp:RequiredFieldValidator ControlToValidate="txtUsername" ErrorMessage="Ingrese usuario" Display="Dynamic" CssClass="text-danger" runat="server" />
                    </div>

                    <div class="mb-3">
                        <asp:Label AssociatedControlID="txtPassword" Text="Contraseña" CssClass="form-label" runat="server" />
                        <asp:TextBox ID="txtPassword" CssClass="form-control" TextMode="Password" runat="server" />
                        <asp:RequiredFieldValidator ControlToValidate="txtPassword" ErrorMessage="Ingrese contraseña" Display="Dynamic" CssClass="text-danger" runat="server" />
                    </div>

                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="text-danger mb-2" />

                    <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Ingresar" OnClick="btnLogin_Click" />
                    <asp:Label ID="lblError" runat="server" Text="Label"></asp:Label>
                </asp:Panel>
            </div>
        </div>
    </main>
</asp:Content>