using System.Linq.Expressions;
using MalusAdmin.Common.Components;
using MalusAdmin.Servers.Hub;
using MalusAdmin.WebApi;


try
{
    var builder = WebApplication.CreateBuilder(args);
    //Appע�� 
    builder.ConfigureApplication();
    // ע�����
    builder.Services.AddApplicationServices(builder.Configuration);

    var app = builder.Build();

    // �����м��
    app.UseApplicationMiddlewares();

    //
    app.MapHub<OnlineUserHub>("/hub");

    app.Run();
}
catch (Exception e)
{
    Console.WriteLine("�����쳣��"+e.Message);
	throw;
}

