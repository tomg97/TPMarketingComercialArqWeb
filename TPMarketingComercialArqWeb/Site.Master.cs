using BE;
using BE.BITACORAYCAMBIOS;
using BE.PERMISOS;
using BLL;
using BLL.BITACORAYCAMBIOS;
using BLL.DIGITOVERIFICADOR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPMarketingComercialArqWeb
{
    public partial class SiteMaster : MasterPage
    {
        private readonly BLL_SESION bllSesion = new BLL_SESION();
        BLL_BITACORA_EVENTOS bllbitacoraeventos = new BLL_BITACORA_EVENTOS();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                ActualizarInfoSesion();
            }
        }

        private void ActualizarInfoSesion()
        {
            // Valores por defecto: ocultar las cabeceras controladas por permisos
            liUsuarios.Visible = false;
            liBitacora.Visible = false;
            liComprar.Visible = false;
            liBackup.Visible = false;

            var sesion = BE_SESION.ObtenerInstancia;
            if (sesion != null && sesion.Logueado())
            {
                var u = sesion.Usuario;
                var roles = u.ListaDePermisos.OfType<BE_ROL>().Select(r => r.Nombre).ToList();

                // Determinar visibilidades según reglas
                bool mostrarUsuarios = false;
                bool mostrarBitacora = false;
                bool mostrarComprar = false;
                bool mostrarBackup = false;

                if (roles.Contains("Administrador"))
                {
                    mostrarUsuarios = mostrarBitacora = mostrarComprar = mostrarBackup = true;
                }
                else
                {
                    if (roles.Contains("Seguridad"))
                    {
                        mostrarBitacora = true;
                        mostrarBackup = true;
                    }
                    if (roles.Contains("Cliente"))
                    {
                        mostrarComprar = true;
                    }
                    // Si tiene SinPermisos no mostramos nada (ya queda false)
                    // Si se requieren otras combinaciones, agregar aquí.
                }

                liUsuarios.Visible = mostrarUsuarios;
                liBitacora.Visible = mostrarBitacora;
                liComprar.Visible = mostrarComprar;
                liBackup.Visible = mostrarBackup;

                // Footer y cabeceras login/logout
                string rolTexto = roles.Any() ? string.Join(", ", roles) : "Sin rol";
                lblSesion.Text = $"Sesión iniciada - {HttpUtility.HtmlEncode(u.Nombre)} {HttpUtility.HtmlEncode(u.Apellido)} - {HttpUtility.HtmlEncode(u.Correo)} - {HttpUtility.HtmlEncode(rolTexto)}";

                liLogin.Visible = false;
                liLogout.Visible = true;
            }
            else
            {
                lblSesion.Text = "Sesión no iniciada";
                liLogin.Visible = true;
                liLogout.Visible = false;
                liBackup.Visible = false;
            }

            var dvMode = Session["DV_LockedMode"] as string;
            if (!string.IsNullOrEmpty(dvMode))
            {
                // Bloqueo por inconsistencia
                // Ocultar todo por defecto
                liUsuarios.Visible = false;
                liBitacora.Visible = false;
                liComprar.Visible = false;
                liLogin.Visible = false;

                // Mostrar logout siempre
                liLogout.Visible = true;

                if (dvMode == "admin")
                {
                    // admin puede acceder a Backup (y logout)
                    liBackup.Visible = true;
                }
                else
                {
                    // usuario no admin sólo logout
                    liBackup.Visible = false;
                }

                // Opcional: mostrar footer con aviso (lblSesion ya muestra)
                return;
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            try
            {
                bllbitacoraeventos.GuardarBitacoraEvento(new BE_BITACORA_EVENTOS(BE_SESION.ObtenerInstancia.Usuario, DateTime.Now, $"Log Out"));
                bllSesion.LogOut();
            }
            finally
            {
                ActualizarInfoSesion();
                Session["DV_LockedMode"] = string.Empty;
                Response.Redirect("~/", true);
            }
        }
    }
}