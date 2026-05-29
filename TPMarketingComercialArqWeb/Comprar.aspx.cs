using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPMarketingComercialArqWeb
{
    public partial class Comprar : PaginaProtegida
    {
        protected override BE_PERMISO_TIPO_ENUM PermisoRequerido
            => BE_PERMISO_TIPO_ENUM.Comprar;

        BLL_PRODUCTO bllproducto = new BLL_PRODUCTO();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LLenarTargetas();
            }
        }
        private void LLenarTargetas()
        {
            // Le pasamos la lista unificada al Repeater
            rptProductos.DataSource = bllproducto.ListarProductos();
            rptProductos.DataBind();
        }

        protected string ObtenerImagenBase64(object imagenObj)
        {
            // Si la base de datos devuelve null
            if (imagenObj == null || imagenObj == DBNull.Value)
            {
                return "https://via.placeholder.com/250x200?text=Sin+Imagen";
            }

            try
            {
                byte[] bytes = (byte[])imagenObj;
                string base64String = Convert.ToBase64String(bytes);

                // Formateamos la cadena para que el src del img la entienda
                return "data:image/jpeg;base64," + base64String;
            }
            catch
            {
                // Fallback por si la conversión falla
                return "https://via.placeholder.com/250x200?text=Error";
            }
        }
    }
}