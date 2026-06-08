using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class BE_INSUMO : BE_PRODUCTO
    {
        private BE_MATERIAL_ENUM material;
        public BE_MATERIAL_ENUM Material
        {
            get { return material; }
            set { material = value; }
        }

        private decimal diametromm;
        public decimal Diametromm
        {
            get { return diametromm; }
            set { diametromm = value; }
        }

        private string color;
        public string Color
        {
            get { return color; }
            set { color = value; }
        }

        private string marca;
        public string Marca
        {
            get { return marca; }
            set { marca = value; }
        }

        private decimal kilogramos;
        public decimal Kilogramos
        {
            get { return kilogramos; }
            set { kilogramos = value; }
        }

        private int stock;
        public int Stock
        {
            get { return stock; }
            set { stock = value; }
        }
    }
}
