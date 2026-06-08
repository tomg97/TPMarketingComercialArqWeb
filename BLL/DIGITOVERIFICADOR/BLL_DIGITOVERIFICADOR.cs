using DAL;
using DAL.DIGITOVERIFICADOR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace BLL.DIGITOVERIFICADOR
{
    public class BLL_DIGITOVERIFICADOR
    {
        DAL_DIGITOVERIFICADOR daldigitoverificador = new DAL_DIGITOVERIFICADOR();
        DAL_ENCRIPTADOR dalencriptador = new DAL_ENCRIPTADOR();

        public bool VerificarDigito(string nombretabla)
        {
            return daldigitoverificador.VerificarDigito(nombretabla);
        }

        public int CalcularDVHTabla(string nombretabla)
        {
            return daldigitoverificador.CalcularDVHTabla(nombretabla);
        }

        public int CalcularDVVTabla(string nombretabla)
        {
            return daldigitoverificador.CalcularDVVTabla(nombretabla);
        }

        public string CalcularDVHObjeto<T>(T objeto)
        {
            StringBuilder cadena = new StringBuilder();
            PropertyInfo[] propiedades = typeof(T).GetProperties();

            foreach (PropertyInfo propiedad in propiedades)
            {
                if (propiedad.Name != "Digitohorizontal") // Excluir la propiedad del DVH si existe
                {
                    object valor = propiedad.GetValue(objeto);
                    if (valor != null)
                    {
                        cadena.Append(valor.ToString());
                    }
                }
            }

            return dalencriptador.EncriptarSHA256(cadena.ToString());
        }

        public IDictionary<string, List<int>> ObtenerInconsistencias()
        {
            return daldigitoverificador.VerificarTodasTablasDetalle();
        }
    }
}