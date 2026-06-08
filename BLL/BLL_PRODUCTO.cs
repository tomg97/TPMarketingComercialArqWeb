using BE;
using DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class BLL_PRODUCTO
    {
        DAL_PRODUCTO dalproductos = new DAL_PRODUCTO();

        public List<BE_PRODUCTO> ListarProductos()
        {
            return dalproductos.TraerTodos();
        }

        public void ProcesarReduccionStock(List<ItemCarrito> itemsComprados)
        {
            foreach (var item in itemsComprados)
            {
                dalproductos.DescontarStock(item.Id, item.Cantidad);
                /*
                if (item.TipoProducto == "Insumo")
                {
                    // Si compra el rollo cerrado (1kg), descontamos el peso total por la cantidad comprada
                    // Para simplificar, asumimos que reduce el PesoDisponibleGramos
                    dalproductos.DescontarStockInsumo(item.Id, item.Cantidad);
                }
                else if (item.TipoProducto == "PiezaImpresa")
                {
                    // Si compra una pieza, la DAL debe buscar cuánto pesa esa pieza 
                    // y restar (PesoConsumidoGramos * Cantidad) del filamento asociado
                    dalproductos.DescontarStockPieza(item.Id, item.Cantidad);
                }
                */
            }
        }
    }
}
