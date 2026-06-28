using BE;
using BE.SESION;
using DAL;
using DAL.MULTIIDIOMA;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class BLL_SESION
    {
        DAL_MAPPER_USUARIO dalmapperusuario = new DAL_MAPPER_USUARIO();

        //BLL_TRADUCTOR blltraductor = new BLL_TRADUCTOR();

        public BE_LOGIN_RESULTADO_ENUM LogIn(string nombredeusuario, string contrasenia)
        {
            // Si ya hay alguien logueado, cerramos esa sesión primero
            if (BE_SESION.ObtenerInstancia.Logueado())
            {
                throw new Exception("Ya hay una sesión activa en el sistema.");
            }

            if (BE_SESION.ObtenerInstancia.LoginBloqueado())
            {
                throw new BE_LOGIN_EXCEPCION(BE_LOGIN_RESULTADO_ENUM.BloqueadoTemporalmente);
            }

            var usuario = dalmapperusuario.Buscar(new BE_USUARIO
            {
                NombreDeUsuario = nombredeusuario,
                Contrasenia = contrasenia
            });

            if (usuario.Count != 0)
            {
                BE_USUARIO usuarioaux = usuario[0];

                BE_SESION.ObtenerInstancia.ResetearIntentosLogin();

                new DAL_PERMISO().LlenarUsuarioPermisos(usuarioaux);
                new DAL_MAPPER_IDIOMA().LlenarUsuarioIdioma(usuarioaux);
                BE_SESION.ObtenerInstancia.LogIn(usuarioaux);

                return BE_LOGIN_RESULTADO_ENUM.LogInCorrecto;
            }
            else
            {
                var usuarioExistente = dalmapperusuario.TraerTodos()
                    .FirstOrDefault(x => x.NombreDeUsuario == nombredeusuario);

                if (usuarioExistente == null)
                {
                    throw new BE_LOGIN_EXCEPCION(BE_LOGIN_RESULTADO_ENUM.NombreDeUsuarioIncorrecto);
                }

                BE_SESION.ObtenerInstancia.RegistrarIntentoFallidoLogin();

                if (BE_SESION.ObtenerInstancia.LoginBloqueado())
                {
                    throw new BE_LOGIN_EXCEPCION(BE_LOGIN_RESULTADO_ENUM.BloqueadoTemporalmente);
                }

                throw new BE_LOGIN_EXCEPCION(BE_LOGIN_RESULTADO_ENUM.ContraseniaIncorrecta);
            }
        }

        public void LogOut()
        {
            if (BE_SESION.ObtenerInstancia.Logueado())
            {
                BE_SESION.ObtenerInstancia.LogOut();
                //NotificarObservadoresForms(blltraductor.ObtenerIdiomaPorDefecto());
            }
            else
            {
                throw new Exception("No hay un usuario logueado");
            }
        }
        /*
        public void AgregarObservadorForm(BE_IOBSERVERIDIOMA observador)
        {
            BE_SESION.Observadores.Add(observador);
        }

        public void QuitarObservadorForm(BE_IOBSERVERIDIOMA observador)
        {
            BE_SESION.Observadores.Remove(observador);
        }

        private void NotificarObservadoresForms(BE_IDIOMA idioma)
        {
            foreach (var observador in BE_SESION.Observadores)
            {
                observador.ActualizarIdioma(idioma);
            }
        }

        public void CambiarIdioma(BE_IDIOMA idioma)
        {
            BE_SESION.ObtenerInstancia.Usuario.Idioma = idioma;
            NotificarObservadoresForms(idioma);
        }
        */
    }
}