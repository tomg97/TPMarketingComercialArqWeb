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
            if (BE_SESION.ObtenerInstancia.Logueado())
            {
                throw new Exception("Ya hay un usuario logueado");
            }

            // 1) Buscar usuario por nombre (sin validar contraseña)
            var usuarioPorNombre = dalmapperusuario.BuscarPorNombre(nombredeusuario);
            if (usuarioPorNombre == null)
            {
                // No existe usuario -> no incrementamos intentos porque no sabemos id
                throw new BE_LOGIN_EXCEPCION(BE_LOGIN_RESULTADO_ENUM.NombreDeUsuarioIncorrecto);
            }

            // 2) Si está bloqueado, no permitir login
            if (usuarioPorNombre.Bloqueado)
            {
                throw new Exception("Usuario bloqueado. Contactar al administrador.");
            }

            // 3) Intentar validar contraseña (usa el método Buscar existente que compara hash)
            var usuarios = dalmapperusuario.Buscar(new BE_USUARIO { NombreDeUsuario = nombredeusuario, Contrasenia = contrasenia });
            if (usuarios.Count != 0)
            {
                // Login correcto -> resetear intentos y cargar permisos/idioma
                dalmapperusuario.ResetearIntentos(usuarioPorNombre.Id);

                BE_USUARIO usuarioaux = usuarios[0];
                new DAL_PERMISO().LlenarUsuarioPermisos(usuarioaux);
                new DAL_MAPPER_IDIOMA().LlenarUsuarioIdioma(usuarioaux);
                BE_SESION.ObtenerInstancia.LogIn(usuarioaux);
                return BE_LOGIN_RESULTADO_ENUM.LogInCorrecto;
            }
            else
            {
                // Contraseña incorrecta -> registrar fallo e intentar bloquear si corresponde
                dalmapperusuario.RegistrarFalloLogin(usuarioPorNombre.Id, 3);

                // Releer usuario para ver si se bloqueó ahora
                var actualizado = dalmapperusuario.BuscarConId(usuarioPorNombre.Id);
                if (actualizado.Bloqueado)
                {
                    throw new Exception("Usuario bloqueado por intentos fallidos. Contacte al administrador.");
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
        public void DesbloquearUsuario(int idUsuario)
        {
            dalmapperusuario.DesbloquearUsuario(idUsuario);
            // Registrar en bitácora (recomiendo)
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