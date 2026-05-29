using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public abstract class BE_PRODUCTO
    {
        private int id;
        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        private string nombre;
        public string Nombre
        {
            get { return nombre; }
            set { nombre = value; }
        }

        private decimal precioBase;

        public decimal PrecioBase
        {
            get { return precioBase; }
            set { precioBase = value; }
        }

        private byte[] imagen;
        public byte[] Imagen
        {
            get { return imagen; }
            set { imagen = value; }
        }
    }
}
