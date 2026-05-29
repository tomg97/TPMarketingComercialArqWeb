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
    }
}
