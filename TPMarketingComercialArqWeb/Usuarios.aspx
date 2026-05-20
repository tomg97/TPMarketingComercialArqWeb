<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="TPMarketingComercialArqWeb.Usuarios" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">Usuarios</h1>
            <p class="lead">ABM de usuarios.</p>
        </section>

        <div class="row mb-3">
            <div class="col-md-12">
                <asp:Button ID="btnNuevo" runat="server" CssClass="btn btn-success" Text="Nuevo usuario" OnClick="btnNuevo_Click" />
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <asp:GridView ID="gvUsuarios" runat="server" CssClass="table table-striped"
                    AutoGenerateColumns="False" DataKeyNames="Id" OnRowCommand="gvUsuarios_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" />
                        <asp:BoundField DataField="NombreDeUsuario" HeaderText="Usuario" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                        <asp:BoundField DataField="Contrasenia" HeaderText="Contraseña" />
                        <asp:BoundField DataField="Correo" HeaderText="Correo" />
                        <asp:TemplateField HeaderText="Idioma">
                            <ItemTemplate>
                                <%# Eval("Idioma.Nombre") %> 
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:Button ID="btnEditar" runat="server" CssClass="btn btn-sm btn-primary me-1"
                                CommandName="Editar" CommandArgument='<%# Container.DataItemIndex %>' Text="Editar" />
                                <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-sm btn-danger"
                                CommandName="Eliminar" CommandArgument='<%# Container.DataItemIndex %>' Text="Eliminar" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- Panel para Crear / Editar -->
        <asp:Panel ID="pnlEditor" runat="server" CssClass="card p-3 mt-3" Visible="false">
            <h4 id="editorTitle" runat="server">Nuevo usuario</h4>

            <div class="mb-3">
                <asp:Label AssociatedControlID="txtId" Text="Id" CssClass="form-label" runat="server" />
                <asp:TextBox ID="txtId" runat="server" CssClass="form-control" ReadOnly="True" />
            </div>

            <div class="mb-3">
                <asp:Label AssociatedControlID="txtUsuario" Text="Usuario" CssClass="form-label" runat="server" />
                <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ControlToValidate="txtUsuario" ErrorMessage="Requerido" Display="Dynamic" CssClass="text-danger" runat="server" />
            </div>

            <div class="mb-3">
                <asp:Label AssociatedControlID="txtNombre" Text="Nombre" CssClass="form-label" runat="server" />
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
            </div>

            <div class="mb-3">
                <asp:Label AssociatedControlID="txtApellido" Text="Apellido" CssClass="form-label" runat="server" />
                <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
            </div>

            <div class="mb-3">
                <asp:Label AssociatedControlID="txtContrasenia" Text="Contraseña" CssClass="form-label" runat="server" />
                <asp:TextBox ID="txtContrasenia" runat="server" CssClass="form-control" />
            </div>

            <div class="mb-3">
                <asp:Label AssociatedControlID="txtCorreo" Text="Correo" CssClass="form-label" runat="server" />
                <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" />
            </div>

            <div>
                <asp:DropDownList ID="ddlIdioma" runat="server" CssClass="form-select">
                </asp:DropDownList>
            </div>

            <asp:HiddenField ID="hfEditingId" runat="server" />

            <div class="d-flex gap-2">
                <asp:Button ID="btnGuardar" runat="server" CssClass="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnCancelar" runat="server" CssClass="btn btn-secondary" Text="Cancelar" OnClick="btnCancelar_Click" />
            </div>
        </asp:Panel>
    </main>
</asp:Content>