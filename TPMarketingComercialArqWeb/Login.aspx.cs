using BE;
using BE.BITACORAYCAMBIOS;
using BE.PERMISOS;
using BE.SESION;
using BLL;
using BLL.BITACORAYCAMBIOS;
using BLL.DIGITOVERIFICADOR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPMarketingComercialArqWeb
{
    public partial class Login : System.Web.UI.Page
    {
        BLL_SESION bllsesion = new BLL_SESION();
        BLL_BITACORA_EVENTOS bllbitacoraeventos = new BLL_BITACORA_EVENTOS();
        BLL_DIGITOVERIFICADOR blldigitoverificador = new BLL_DIGITOVERIFICADOR();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Visible = false;

                if (BE_SESION.ObtenerInstancia.Logueado())
                {
                    lblError.Visible = true;
                    lblError.Text = $"Ya hay una sesión activa. Debe cerrar sesión antes de ingresar.";
                    btnLogin.Enabled = false;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblError.Visible = false;

            if (BE_SESION.ObtenerInstancia.Logueado())
            {
                lblError.Visible = true;
                lblError.Text = "Ya hay una sesión activa. Debe cerrar sesión antes de ingresar.";
                return;
            }

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            try
            {
                if (bllsesion.LogIn(username, password) == BE_LOGIN_RESULTADO_ENUM.LogInCorrecto)
                {
                    var usuario = BE_SESION.ObtenerInstancia.Usuario;
                    var roles = usuario.ListaDePermisos
                                       .OfType<BE_ROL>()
                                       .Select(r => r.Nombre)
                                       .ToList();
                    string rolTexto = roles.Any() ? string.Join(", ", roles) : "Sin rol";

                    // Mostrar mensaje en la página en lugar del alert
                    pnlExito.Visible = true;
                    lblExito.Text = $"✅ Bienvenido, {usuario.Nombre}! Rol: {rolTexto}.";

                    bllbitacoraeventos.GuardarBitacoraEvento(new BE_BITACORA_EVENTOS(
                        BE_SESION.ObtenerInstancia.Usuario, DateTime.Now, "Log In"));

                    // validar integridad de la base
                    var inconsistencias = blldigitoverificador.ObtenerInconsistencias();
                    if (inconsistencias != null && inconsistencias.Any())
                    {
                        // Hay inconsistencias
                        var isAdmin = usuario.ListaDePermisos.OfType<BE_ROL>().Any(r => r.Nombre == "Administrador");

                        if (isAdmin)
                        {
                            // preparar mensaje detallado (tabla: ids...)
                            var detalles = new StringBuilder();
                            foreach (var kv in inconsistencias)
                            {
                                detalles.AppendLine($"{kv.Key}: {string.Join(", ", kv.Value)}");
                            }
                            // mostrar al admin y bloquear navegación excepto Backup y Logout
                            Session["DV_LockedMode"] = "admin";
                            pnlInconsistencia.Visible = true;
                            lblInconsistencia.Text = "Inconsistencia en integridad detectada. Tablas/registros:\n" + HttpUtility.HtmlEncode(detalles.ToString());
                        }
                        else
                        {
                            // usuario no admin -> mensaje genérico y bloquear todo salvo Logout
                            Session["DV_LockedMode"] = "user";
                            pnlInconsistencia.Visible = true;
                            lblInconsistencia.Text = "Inconsistencia detectada en los datos. Contacte al Administrador.";
                        }
                    }
                    else
                    {
                        // sin inconsistencias -> normal
                        Session.Remove("DV_LockedMode");
                    }

                    int delayMs = 6000; // tiempo en ms
                    string delayscript = $@"
                        (function(){{
                          var delay = {delayMs};
                          var seconds = Math.ceil(delay/1000);
                          var el = document.getElementById('{lblExito.ClientID}');
                          if (!el) el = document.getElementById('{lblInconsistencia.ClientID}');
                          if (el) {{
                            var countEl = document.createElement('span');
                            countEl.style.marginLeft = '8px';
                            countEl.style.fontWeight = '600';
                            el.appendChild(countEl);
                            countEl.innerText = 'Redirigiendo en ' + seconds + 's...';
                            var iv = setInterval(function() {{
                              seconds--;
                              if (seconds >= 0) {{
                                countEl.innerText = 'Redirigiendo en ' + seconds + 's...';
                              }} else {{
                                clearInterval(iv);
                              }}
                            }}, 1000);
                          }}
                          setTimeout(function(){{ window.location.href = '/Default.aspx'; }}, delay);
                        }})();
                        ";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "redir", delayscript, true);
                }
            }
            catch (BE_LOGIN_EXCEPCION ex)
            {
                lblError.Visible = true;
                switch (ex.Resultado)
                {
                    case BE_LOGIN_RESULTADO_ENUM.NombreDeUsuarioIncorrecto:
                        lblError.Text = "Usuario incorrecto.";
                        break;
                    case BE_LOGIN_RESULTADO_ENUM.ContraseniaIncorrecta:
                        lblError.Text = "Contraseña incorrecta.";
                        break;
                }
            }
            catch (Exception ex)
            {
                // Cubre "Ya hay un usuario logueado" y cualquier otro error inesperado
                lblError.Visible = true;
                lblError.Text = ex.Message;
            }
        }
    }
}