using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    [Serializable] // Es buena práctica para objetos que se guardan en Session
    public class ItemCarrito
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public int Cantidad { get; set; }
        public byte[] Imagen { get; set; }
        public string TipoProducto { get; set; } // "Insumo" o "PiezaImpresa"
        public decimal Subtotal => Precio * Cantidad;
    }
}
