<%@ Page Title="Bitacora" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bitacora.aspx.cs" Inherits="TPMarketingComercialArqWeb.Bitacora" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .bitacora-header {
        background: linear-gradient(135deg, #1a1a2e 0%, #0f3460 100%);
        color: white;
        padding: 30px 40px;
        border-radius: 10px;
        margin-bottom: 28px;
    }
    .bitacora-header h1 { margin: 0 0 6px 0; font-size: 2rem; letter-spacing: 1px; }
    .bitacora-header p  { margin: 0; color: #a0c4ff; }

    .filtros-panel {
        background: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 10px;
        padding: 20px 24px;
        margin-bottom: 24px;
    }
    .filtros-panel h5 { color: #0f3460; margin-bottom: 16px; font-weight: 600; }

    .table thead { background-color: #0f3460; color: white; }
    .table thead th { border: none; padding: 12px 16px; }
    .table tbody tr:hover { background-color: #f0f4ff; }
    .table tbody td { padding: 10px 16px; vertical-align: middle; }

    .btn-imprimir {
        background: #0f3460;
        color: white;
        border: none;
        border-radius: 8px;
        padding: 8px 20px;
        font-weight: 600;
        float: right;
        margin-bottom: 12px;
    }
    .btn-imprimir:hover { background: #e94560; color: white; }

    @media print {
        .filtros-panel, .btn-imprimir, .bitacora-header p,
        nav, footer, hr, .pagination-row { display: none !important; }
        .bitacora-header { background: none !important; color: black !important; padding: 0 !important; }
        .bitacora-header h1 { color: black !important; font-size: 1.4rem !important; }
        body { font-size: 12px; }
    }
</style>

<main>
    <section class="row" aria-labelledby="aspnetTitle">

        <div class="bitacora-header">
            <h1 id="aspnetTitle">📋 Bitácora</h1>
            <p>Registro de eventos del sistema ordenados por fecha descendente.</p>
        </div>

        <!-- Panel de filtros -->
        <div class="filtros-panel">
            <h5>🔍 Filtrar registros</h5>
            <div class="row g-3">
                <div class="col-md-3">
                    <label class="form-label fw-semibold">Usuario</label>
                    <asp:TextBox ID="txtFiltroUsuario" runat="server" CssClass="form-control" placeholder="Nombre de usuario" />
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-semibold">Acción</label>
                    <asp:TextBox ID="txtFiltroAccion" runat="server" CssClass="form-control" placeholder="Ej: Log In, Abrió..." />
                </div>
                <div class="col-md-2">
                    <label class="form-label fw-semibold">Fecha desde</label>
                    <asp:TextBox ID="txtFiltroDesde" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-md-2">
                    <label class="form-label fw-semibold">Fecha hasta</label>
                    <asp:TextBox ID="txtFiltroHasta" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-md-2 d-flex align-items-end gap-2">
                    <asp:Button ID="btnFiltrar" runat="server" CssClass="btn btn-primary w-100"
                        Text="Filtrar" OnClick="btnFiltrar_Click" CausesValidation="false" />
                    <asp:Button ID="btnLimpiar" runat="server" CssClass="btn btn-secondary w-100"
                        Text="Limpiar" OnClick="btnLimpiar_Click" CausesValidation="false" />
                </div>
            </div>
            <div class="mt-2">
                <asp:Label ID="lblResultados" runat="server" CssClass="text-muted" />
            </div>
        </div>

        <!-- Botón imprimir -->
        <div class="col-md-12">
            <button type="button" class="btn btn-imprimir" onclick="imprimirBitacora()">
                🖨️ Imprimir / Exportar PDF
            </button>
        </div>

        <!-- Grilla -->
        <div class="col-md-12" id="divBitacora">
            <asp:GridView ID="gvBitacora" runat="server" CssClass="table table-striped table-bordered"
                AutoGenerateColumns="False" DataKeyNames="Id"
                AllowPaging="True" PageSize="20"
                OnPageIndexChanging="gvBitacora_PageIndexChanging"
                OnSelectedIndexChanged="gvBitacora_SelectedIndexChanged">
                <PagerSettings Mode="Numeric" PageButtonCount="5" />
                <PagerStyle CssClass="pagination-row" HorizontalAlign="Center" />
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="#" ReadOnly="True" ItemStyle-Width="50px" />
                    <asp:TemplateField HeaderText="Usuario">
                        <ItemTemplate><%# Eval("Usuario.NombreDeUsuario") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Correo">
                        <ItemTemplate><%# Eval("Usuario.Correo") %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}" />
                    <asp:BoundField DataField="Accion" HeaderText="Acción" />
                </Columns>
            </asp:GridView>
        </div>

    </section>
</main>

<script>
    function imprimirBitacora() {
        window.print();
    }
</script>

</asp:Content>