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

        protected string CartStateClass = "";
        BLL_PRODUCTO bllproducto = new BLL_PRODUCTO();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Inicializar el carrito en sesión si no existe
                if (Session["Carrito"] == null)
                    Session["Carrito"] = new List<ItemCarrito>();

                LLenarTarjetas();
                ActualizarVistaCarrito();
            }
        }

        // --- MANEJO DE EVENTOS DEL CATÁLOGO ---
        protected void rptProductos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AgregarAlCarrito")
            {
                int productoId = Convert.ToInt32(e.CommandArgument);
                var carrito = (List<ItemCarrito>)Session["Carrito"];

                // Verificar si ya está en el carrito
                var itemExistente = carrito.FirstOrDefault(x => x.Id == productoId);
                if (itemExistente != null)
                {
                    itemExistente.Cantidad++;
                }
                else
                {
                    // Buscamos el producto fresco desde la BLL/Catálogo
                    var listaCompleta = bllproducto.ListarProductos();
                    var prod = listaCompleta.FirstOrDefault(x => x.Id == productoId);

                    if (prod != null)
                    {
                        carrito.Add(new ItemCarrito
                        {
                            Id = prod.Id,
                            Nombre = prod.Nombre,
                            Precio = prod.PrecioBase,
                            Imagen = prod.Imagen,
                            Cantidad = 1,
                            TipoProducto = prod is BE_INSUMO ? "Insumo" : "PiezaImpresa"
                        });
                    }
                }

                Session["Carrito"] = carrito;
                CartStateClass = "open"; // Abrir pestaña lateral
                ActualizarVistaCarrito();
            }
        }

        // --- MANEJO DE EVENTOS DENTRO DEL CARRITO ---
        protected void rptCarrito_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productoId = Convert.ToInt32(e.CommandArgument);
            var carrito = (List<ItemCarrito>)Session["Carrito"];
            var item = carrito.FirstOrDefault(x => x.Id == productoId);

            if (item != null)
            {
                if (e.CommandName == "SumarQty")
                {
                    item.Cantidad++;
                }
                else if (e.CommandName == "RestarQty")
                {
                    item.Cantidad--;
                    if (item.Cantidad <= 0) carrito.Remove(item);
                }
                else if (e.CommandName == "EliminarItem")
                {
                    carrito.Remove(item);
                }
            }

            Session["Carrito"] = carrito;
            CartStateClass = "open"; // Mantener abierto el carrito al operar dentro
            ActualizarVistaCarrito();
        }

        // --- ACCIONES DE APERTURA / CIERRE ---
        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            CartStateClass = ""; // Remueve la clase 'open'
            upEcommerce.Update();
        }

        protected void btnVerCarrito_Click(object sender, EventArgs e)
        {
            CartStateClass = "open";
            ActualizarVistaCarrito();
        }

        // --- SINCRONIZAR INTERFAZ ---
        private void ActualizarVistaCarrito()
        {
            var carrito = (List<ItemCarrito>)Session["Carrito"];

            rptCarrito.DataSource = carrito;
            rptCarrito.DataBind();

            pnlVacio.Visible = !carrito.Any();

            decimal total = carrito.Sum(x => x.Subtotal);
            litTotal.Text = total.ToString("N0");

            // Forzar al UpdatePanel a redibujar el HTML modificado
            upEcommerce.Update();
        }

        // --- PROCESAR LA COMPRA FINAL ---
        protected void btnFinalizarCompra_Click(object sender, EventArgs e)
        {
            var carrito = (List<ItemCarrito>)Session["Carrito"];

            if (carrito == null || !carrito.Any()) return;

            try
            {
                // Enviar el carrito a la BLL para descontar los stocks en la Base de Datos
                bllproducto.ProcesarReduccionStock(carrito);

                // Vaciar carrito de la sesión
                Session["Carrito"] = new List<ItemCarrito>();
                CartStateClass = ""; // Cerrar panel
                ActualizarVistaCarrito();
                LLenarTarjetas(); // Recargar catálogo por si cambiaron precios o disponibilidad

                // Disparar un Alert nativo de JavaScript desde el servidor sin romper el UpdatePanel
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertCompra", "alert('¡Compra realizada con éxito!');", true);
            }
            catch (Exception ex)
            {
                string msgError = ex.Message.Replace("'", "\\'");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError", $"alert('Error al procesar: {msgError}');", true);
            }
        }


        private void LLenarTarjetas()
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