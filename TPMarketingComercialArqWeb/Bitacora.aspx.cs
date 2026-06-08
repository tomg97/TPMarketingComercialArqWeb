using BE;
using BE.BITACORAYCAMBIOS;
using BE.PERMISOS;
using BLL;
using BLL.BITACORAYCAMBIOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

namespace TPMarketingComercialArqWeb
{
    public partial class Bitacora : PaginaProtegida
    {
        protected override BE_PERMISO_TIPO_ENUM PermisoRequerido
            => BE_PERMISO_TIPO_ENUM.GestionarBitacoraEventos;

        BLL_BITACORA_EVENTOS bllbitacoraeventos = new BLL_BITACORA_EVENTOS();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bllbitacoraeventos.GuardarBitacoraEvento(
                    new BE_BITACORA_EVENTOS(BE_SESION.ObtenerInstancia.Usuario, DateTime.Now, "Abrió Bitacora"));
                LlenarGrilla(ObtenerFiltrado());
            }
        }

        private List<BE_BITACORA_EVENTOS> ObtenerFiltrado()
        {
            var datos = bllbitacoraeventos.ListarBitacoraEvento()
                        .OrderByDescending(b => b.Fecha)
                        .ToList();

            // Filtro por usuario
            if (!string.IsNullOrWhiteSpace(txtFiltroUsuario.Text))
            {
                string filtro = txtFiltroUsuario.Text.Trim().ToLower();
                datos = datos.Where(b => b.Usuario != null &&
                    b.Usuario.NombreDeUsuario != null &&
                    b.Usuario.NombreDeUsuario.ToLower().Contains(filtro)).ToList();
            }

            // Filtro por acción
            if (!string.IsNullOrWhiteSpace(txtFiltroAccion.Text))
            {
                string filtro = txtFiltroAccion.Text.Trim().ToLower();
                datos = datos.Where(b => b.Accion != null &&
                    b.Accion.ToLower().Contains(filtro)).ToList();
            }

            // Filtro por fecha desde
            if (!string.IsNullOrWhiteSpace(txtFiltroDesde.Text))
            {
                if (DateTime.TryParse(txtFiltroDesde.Text, out DateTime desde))
                    datos = datos.Where(b => b.Fecha.Date >= desde.Date).ToList();
            }

            // Filtro por fecha hasta
            if (!string.IsNullOrWhiteSpace(txtFiltroHasta.Text))
            {
                if (DateTime.TryParse(txtFiltroHasta.Text, out DateTime hasta))
                    datos = datos.Where(b => b.Fecha.Date <= hasta.Date).ToList();
            }

            return datos;
        }

        private void LlenarGrilla(List<BE_BITACORA_EVENTOS> data)
        {
            gvBitacora.DataSource = data;
            gvBitacora.DataBind();
            lblResultados.Text = $"Mostrando {data.Count} registro(s).";
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            gvBitacora.PageIndex = 0;
            LlenarGrilla(ObtenerFiltrado());
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtFiltroUsuario.Text = "";
            txtFiltroAccion.Text = "";
            txtFiltroDesde.Text = "";
            txtFiltroHasta.Text = "";
            gvBitacora.PageIndex = 0;
            LlenarGrilla(ObtenerFiltrado());
        }

        protected void gvBitacora_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBitacora.PageIndex = e.NewPageIndex;
            // Re-aplica el filtro con los valores que siguen en los TextBox
            LlenarGrilla(ObtenerFiltrado());
        }

        protected void gvBitacora_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
    }
}