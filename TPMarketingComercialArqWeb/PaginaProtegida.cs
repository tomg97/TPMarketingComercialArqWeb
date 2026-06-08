using BE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BE.PERMISOS;
using System.Web.UI;

namespace TPMarketingComercialArqWeb
{
    public class PaginaProtegida : Page
    {
        protected virtual BE_PERMISO_TIPO_ENUM PermisoRequerido => BE_PERMISO_TIPO_ENUM.SinPermisos;

        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);

            if (!BE_SESION.ObtenerInstancia.Logueado())
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (PermisoRequerido != BE_PERMISO_TIPO_ENUM.SinPermisos)
            {
                if (!BE_SESION.ObtenerInstancia.EstaEnElRol(PermisoRequerido))
                {
                    Response.Redirect("~/ErrorAcceso.aspx");
                    return;
                }
            }
        }
    }
}