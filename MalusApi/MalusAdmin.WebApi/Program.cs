using MalusAdmin.Common.Components;
using MalusAdmin.Common.Components.JsonOptionsExtensions;
using MalusAdmin.Servers.Hub;
using MalusAdmin.WebApi.Filter;
using Microsoft.AspNetCore.HttpOverrides;

namespace MalusAdmin.WebApi;

public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);
        //Appע�� 
        builder.ConfigureApplication();
        builder.Configuration.ConfigureApplication();

        //��������ע�� | ��Ӿ�̬�ļ���ȡ(���ȼ��Ƚϸ�)
        AppSettings.AddConfigSteup(builder.Configuration); 
           
        //����
        builder.Services.AddCacheSetup(); 
         
        //��������ע��
        builder.Services.AddBaseServices();

        //��ӹ�����
        builder.Services.AddControllers(options =>
            {
                //��Ȩɸѡ�� 
                //options.Filters.Add<CustomAuthorizationFilter>();
                // ȫ���쳣����
                //options.Filters.Add<GlobalExceptionFilter>();
                // ��־������
                //options.Filters.Add<RequestActionFilter>();

                options.Filters.Add<ResultFilter>();
            })
            .AddDataValidation();
            //.AddApiJson<CustomApiJsonProvider>();

        //����Jsonѡ��
        //builder.Services.AddTextJsonOptions();
        builder.Services.AddJsonOptions();

        // ���sqlsugar
        builder.Services.AddSqlsugarSetup();

        // ���swagger�ĵ�
        builder.Services.AddSwaggerBaseSetup();
         
        var dllnames =new string[] { "MalusAdmin.Servers" };
        // �Զ���ӷ����
        builder.Services.AddAutoServices(dllnames);
         
        //�����Ȩ
        //builder.Services.AddAuthorization();

        // ����Զ�����Ȩ
        builder.Services.AddAuthorizationSetup();
 
        // ��ӿ���֧��
        builder.Services.AddCorsSetup();

        //��Ӧ�����м��
        builder.Services.AddResponseCaching();

        //ʵʱӦ��
        builder.Services.AddSignalR();
         
        //rabbit
        //builder.Services.AddRabbitMqClientExtension();
        //builder.Services.AddEasyNetQExtension(); 

        // ���EndpointsApiExplorer
        builder.Services.AddEndpointsApiExplorer();

        var app = builder.Build();

        app.ConfigureApplication();
         
        if (AppSettings.DisplaySwaggerDoc) app.UseSwaggerExtension();

        // ȫ���쳣�м��
        app.UseMiddleware<GlobalException>();

        //��ȡԶ����ʵip,����nginx��������Բ�Ҫ
        app.UseMiddleware<RealIpMiddleware>();
          
        app.UseHttpsRedirection(); // ȷ����������ͨ��HTTPS

        app.UseRouting(); // ȷ��·��

        app.UseCors(); // ���ÿ�����Դ����

        app.UseAuthentication(); // ���������֤�м��

        app.UseAuthorization(); // ������Ȩ�м��

        app.UseStaticFiles(); // ���þ�̬�ļ�����

        app.UseDefaultFiles(); // �ṩĬ���ļ�֧��

        app.UseResponseCaching(); // Ӧ����Ӧ����

        // �����֤�м�����ڿ�����֮ǰִ���ض��ļ�飩
        app.UseMiddleware<CheckToken>();
         
        app.MapHub<OnlineUserHub>("/hub");// ӳ��SignalR Hub
         
        app.MapControllers(); // ӳ�������

        // ����������
        app.Run(); 
    }
}