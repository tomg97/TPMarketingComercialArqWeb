using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class BE_PIEZAIMPRESA : BE_PRODUCTO
    {
        public BE_PIEZAIMPRESA()
        {
            InsumoBase = new BE_INSUMO();
        }
        private int tiempoImpresonMin;
        public int TiempoImpresionMin
        {
            get { return tiempoImpresonMin; }
            set { tiempoImpresonMin = value; }
        }

        private decimal costoDiseno;
        public decimal CostoDiseno
        {
            get { return costoDiseno; }
            set { costoDiseno = value; }
        }

        private BE_INSUMO insumoBase;
        public BE_INSUMO InsumoBase
        {
            get { return insumoBase; }
            set { insumoBase = value; }
        }

        private int stock;
        public int Stock
        {
            get { return stock; }
            set { stock = value; }
        }
    }
}
