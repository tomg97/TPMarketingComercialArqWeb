using BE;
using BE.BITACORAYCAMBIOS;
using BE.MULTIIDIOMA;
using BLL;
using BLL.BITACORAYCAMBIOS;
using BLL.MULTIIDIOMA;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPMarketingComercialArqWeb
{
    public partial class Usuarios : PaginaProtegida
    {
        protected override BE_PERMISO_TIPO_ENUM PermisoRequerido
                    => BE_PERMISO_TIPO_ENUM.ABMUsuarios;

        BLL_USUARIO bllusuario = new BLL_USUARIO();
        BLL_IDIOMA bllidioma = new BLL_IDIOMA();
        BLL_BITACORA_EVENTOS bllbitacoraeventos = new BLL_BITACORA_EVENTOS();
        BLL_SESION bllsesion = new BLL_SESION();
        BE_USUARIO usuarioaux;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bllbitacoraeventos.GuardarBitacoraEvento(
                    new BE_BITACORA_EVENTOS(BE_SESION.ObtenerInstancia.Usuario, DateTime.Now, "Abrió ABM de usuarios"));
                LlenarGrilla();
                LlenarComboBoxIdioma();
                pnlEditor.Visible = false;
            }
        }

        protected void Page_Close(object sender, EventArgs e)
        {
            bllbitacoraeventos.GuardarBitacoraEvento(new BE_BITACORA_EVENTOS(BE_SESION.ObtenerInstancia.Usuario, DateTime.Now, $"Cerró ABM de usuarios"));
        }

        private void LlenarGrilla()
        {
            gvUsuarios.DataSource = bllusuario.ListarUsuarios().OrderBy(u => u.Id).ToList();
            gvUsuarios.DataBind();
        }

        private void LlenarComboBoxIdioma()
        {
            ddlIdioma.DataSource = bllidioma.ListarIdiomas();
            ddlIdioma.DataTextField = "Nombre";
            ddlIdioma.DataValueField = "Id";
            ddlIdioma.DataBind();
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            txtId.Visible = false;
            txtUsuario.Text = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtContrasenia.Text = "";
            txtCorreo.Text = "";
            editorTitle.InnerText = "Nuevo usuario";
            pnlEditor.Visible = true;
            Session["Operacion"] = true;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            usuarioaux = new BE_USUARIO();
            usuarioaux.NombreDeUsuario = txtUsuario.Text;
            usuarioaux.Nombre = txtNombre.Text;
            usuarioaux.Apellido = txtApellido.Text;
            usuarioaux.Contrasenia = txtContrasenia.Text;
            usuarioaux.Correo = txtCorreo.Text;
            usuarioaux.Idioma.Id = Convert.ToInt32(ddlIdioma.SelectedValue);

            if ((bool)Session["Operacion"])
            {
                usuarioaux.Id = 0;
                bllusuario.GuardarUsuario(usuarioaux);
                bllbitacoraeventos.GuardarBitacoraEvento(
                    new BE_BITACORA_EVENTOS(BE_SESION.ObtenerInstancia.Usuario, DateTime.Now, "Creó un usuario"));
            }
            else
            {
                usuarioaux.Id = int.Parse(txtId.Text);
                bllusuario.GuardarUsuario(usuarioaux);
                bllbitacoraeventos.GuardarBitacoraEvento(
                    new BE_BITACORA_EVENTOS(BE_SESION.ObtenerInstancia.Usuario, DateTime.Now, "Modificó un usuario"));
            }

            LlenarGrilla();
            pnlEditor.Visible = false;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            pnlEditor.Visible = false;
        }

        protected void gvUsuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                if (int.TryParse(e.CommandArgument?.ToString(), out int rowIndex))
                {
                    txtId.Visible = true;
                    GridViewRow row = gvUsuarios.Rows[rowIndex];
                    txtId.Text = Convert.ToInt32(gvUsuarios.DataKeys[rowIndex].Value).ToString();
                    txtUsuario.Text = Server.HtmlDecode(row.Cells[1].Text);
                    txtNombre.Text = Server.HtmlDecode(row.Cells[2].Text);
                    txtApellido.Text = Server.HtmlDecode(row.Cells[3].Text);
                    txtContrasenia.Text = Server.HtmlDecode(row.Cells[4].Text);
                    txtCorreo.Text = Server.HtmlDecode(row.Cells[5].Text);
                    editorTitle.InnerText = "Editar usuario";
                    pnlEditor.Visible = true;
                    Session["Operacion"] = false;
                }
            }

            if (e.CommandName == "Eliminar")
            {
                if (int.TryParse(e.CommandArgument?.ToString(), out int rowIndex))
                {
                    int idUsuario = Convert.ToInt32(gvUsuarios.DataKeys[rowIndex].Value);
                    BE_USUARIO u = new BE_USUARIO();
                    u.Id = idUsuario;
                    bllusuario.BorrarUsuario(u);
                    bllbitacoraeventos.GuardarBitacoraEvento(
                        new BE_BITACORA_EVENTOS(BE_SESION.ObtenerInstancia.Usuario, DateTime.Now, "Borró un usuario"));
                    LlenarGrilla();
                }
            }

            if (e.CommandName == "Desbloquear")
            {
                if (int.TryParse(e.CommandArgument?.ToString(), out int id))
                {
                    bllsesion.DesbloquearUsuario(id);
                    LlenarGrilla();
                }
            }
        }
    }
} 