using BE;
using BE.BITACORAYCAMBIOS;
using BLL.BACKUP;
using BLL.BITACORAYCAMBIOS;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPMarketingComercialArqWeb
{
    public partial class Backup : System.Web.UI.Page
    {

        BLL_BITACORA_EVENTOS bllbitacoraeventos = new BLL_BITACORA_EVENTOS();
        BLL_BACKUP bllbackup = new BLL_BACKUP();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bllbitacoraeventos.GuardarBitacoraEvento(new BE_BITACORA_EVENTOS(
                            BE_SESION.ObtenerInstancia.Usuario, DateTime.Now, "Entró a backup"));

            }
        }

        protected void btnBackup_Click(object sender, EventArgs e)
        {
            try
            {
                string ruta = bllbackup.CrearBackup();
                if (!string.IsNullOrEmpty(ruta))
                {
                    lblStatus.CssClass = "text-success mt-3";
                    lblStatus.Text = $"Backup realizado correctamente en: {ruta}";

                    // Guardar en bitácora
                    if (BE_SESION.ObtenerInstancia?.Usuario != null)
                    {
                        bllbitacoraeventos.GuardarBitacoraEvento(new BE_BITACORA_EVENTOS(
                            BE_SESION.ObtenerInstancia.Usuario, DateTime.Now, $"Realizó backup de la base"));
                    }
                }
                else
                {
                    lblStatus.CssClass = "text-danger mt-3";
                    lblStatus.Text = "Error al realizar el backup.";
                }
            }
            catch (Exception ex)
            {
                lblStatus.CssClass = "text-danger mt-3";
                lblStatus.Text = $"Excepción al realizar backup: {HttpUtility.HtmlEncode(ex.Message)}";
            }
        }

        protected void btnRestore_Click(object sender, EventArgs e)
        {
            try
            {
                if (!fuRestore.HasFile)
                {
                    lblStatus.CssClass = "text-warning mt-3";
                    lblStatus.Text = "Seleccione un archivo .bak para restaurar.";
                    return;
                }

                const int maxBytes = 104_857_600;
                if (fuRestore.PostedFile.ContentLength > maxBytes)
                {
                    lblStatus.CssClass = "text-danger mt-3";
                    lblStatus.Text = "El archivo es demasiado grande. Tamaño máximo: 100 MB.";
                    return;
                }

                if (!string.Equals(Path.GetExtension(fuRestore.FileName), ".bak", StringComparison.OrdinalIgnoreCase))
                {
                    lblStatus.CssClass = "text-warning mt-3";
                    lblStatus.Text = "El archivo debe tener extensión .bak";
                    return;
                }

                // 1. Creamos una carpeta puente ÚNICA para este intento
                string carpetaPuente = @"C:\TempBackups_" + Guid.NewGuid().ToString("N");

                if (!System.IO.Directory.Exists(carpetaPuente))
                {
                    System.IO.Directory.CreateDirectory(carpetaPuente);
                }

                string rutaFisicaServidor = System.IO.Path.Combine(carpetaPuente, fuRestore.FileName);

                try
                {
                    // 2. Guardamos el archivo físicamente en la carpeta puente
                    fuRestore.SaveAs(rutaFisicaServidor);

                    // 3. Le pasamos la ruta física real a tu DAL
                    bllbackup.RestaurarBackup(rutaFisicaServidor);

                    lblStatus.CssClass = "text-success mt-3";
                    lblStatus.Text = "Restauración completada con éxito.";
                }
                finally
                {
                    // 4. Borramos la CARPETA completa (el parámetro 'true' elimina los archivos de adentro)
                    // Al estar en el finally, se ejecuta sí o sí, haya error o éxito.
                    if (System.IO.Directory.Exists(carpetaPuente))
                    {
                        System.IO.Directory.Delete(carpetaPuente, true);
                    }
                }
            }
            catch (Exception ex)
            {
                lblStatus.CssClass = "text-danger mt-3";
                lblStatus.Text = $"Excepción al restaurar: {HttpUtility.HtmlEncode(ex.Message)}";
            }
        }
    }
}