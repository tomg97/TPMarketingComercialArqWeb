<%@ Page Title="Bitacora" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bitacora.aspx.cs" Inherits="TPMarketingComercialArqWeb.Bitacora" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">Bitacora</h1>
            <p class="lead">Consulte los eventos del sistema.</p>
        </section>

        <div class="row">
            <div class="col-md-12">
                <asp:GridView ID="gvBitacora" runat="server" CssClass="table table-striped"
    AutoGenerateColumns="False" DataKeyNames="Id"
    AllowPaging="True" PageSize="20" OnPageIndexChanging="gvBitacora_PageIndexChanging">
    <PagerSettings Mode="Numeric" PageButtonCount="5" />
    <Columns>
        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" />
        <asp:TemplateField HeaderText="Usuario">
            <ItemTemplate>
                <%# Eval("Usuario.NombreDeUsuario") %> 
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Correo">
            <ItemTemplate>
                <%# Eval("Usuario.Correo") %> 
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
        <asp:BoundField DataField="Accion" HeaderText="Accion" />
    </Columns>
</asp:GridView>
            </div>
        </div>

    </main>
</asp:Content>