using BE;
using DAL.MULTIIDIOMA;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class DAL_PRODUCTO
    {
        internal DAL_ACCESOBD acceso = new DAL_ACCESOBD();

        public DAL_PRODUCTO()
        {
            acceso.AbrirConexion();
        }

        public List<BE_PRODUCTO> TraerTodos()
        {
            List<BE_PRODUCTO> productos = new List<BE_PRODUCTO>();
            DataTable tabla = acceso.Leer("PRODUCTO_LISTAR", null);
            //
            foreach (DataRow dr in tabla.Rows)
            {
                productos.Add(Convertir(dr));
            }
            return productos;

        }

        internal BE_PRODUCTO Convertir(DataRow registro)
        {
            switch (registro["tipoproducto"].ToString())
            {
                case "Insumo":
                    BE_INSUMO insumo = new BE_INSUMO();
                    insumo.Id = int.Parse(registro["id"].ToString());
                    insumo.Nombre = registro["nombre"].ToString();
                    insumo.PrecioBase = decimal.Parse(registro["preciobase"].ToString());
                    if (registro.IsNull("imagen"))
                    {
                        insumo.Imagen = new byte[0];
                    }
                    else
                    {
                        insumo.Imagen = (byte[])registro["imagen"];
                    }
                    
                    insumo.Material = (BE_MATERIAL_ENUM)Enum.Parse(typeof(BE_MATERIAL_ENUM), registro["material"].ToString());
                    insumo.Diametromm = decimal.Parse(registro["diametromilimetros"].ToString());
                    insumo.Color = registro["color"].ToString();
                    insumo.Marca = registro["marca"].ToString();
                    insumo.Kilogramos = decimal.Parse(registro["kilogramos"].ToString());
                    insumo.Stock = int.Parse(registro["stock"].ToString());
                    
                    return insumo;
                case "PiezaImpresa":
                    BE_PIEZAIMPRESA piezaimpresa = new BE_PIEZAIMPRESA();
                    piezaimpresa.Id = int.Parse(registro["id"].ToString());
                    piezaimpresa.Nombre = registro["nombre"].ToString();
                    piezaimpresa.PrecioBase = decimal.Parse(registro["preciobase"].ToString());
                    if (registro.IsNull("imagen"))
                    {
                        piezaimpresa.Imagen = new byte[0];
                    }
                    else
                    {
                        piezaimpresa.Imagen = (byte[])registro["imagen"];
                    }

                    piezaimpresa.TiempoImpresionMin = int.Parse(registro["tiempoimpresionminutos"].ToString());
                    piezaimpresa.CostoDiseno = decimal.Parse(registro["costodiseno"].ToString());
                    piezaimpresa.InsumoBase = new BE_INSUMO() { Id = int.Parse(registro["insumoid"].ToString()) };
                    piezaimpresa.Stock = int.Parse(registro["stock"].ToString());

                    //llenar pieza impresa con insumo base

                    return piezaimpresa;
                default:
                    return null;
            }
        }
    }
}
