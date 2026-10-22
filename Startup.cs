using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Salarizare.Startup))]
namespace Salarizare
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
