using MalusAdmin.Common.Components;
using MalusAdmin.Servers.Hub;
using MalusAdmin.WebApi.Filter;
using Microsoft.AspNetCore.HttpOverrides;

namespace MalusAdmin.WebApi;

public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args); 

        //��������ע�� | ��Ӿ�̬�ļ���ȡ(���ȼ��Ƚϸ�)
        AppSettings.AddConfigSteup(builder.Configuration); 

        //��ӡ����̨��ʾ
        builder.Services.AddLogo();

        //����ѡ��ע��
        builder.Services.AddConfigureSetup(builder.Configuration); 

        //����
        builder.Services.AddCacheSetup(); 
         
        //��������ע��
        builder.Services.AddBaseServices();

        // ��ӹ�����
        builder.Services.AddControllers(options =>
            {
                // ȫ���쳣����
                options.Filters.Add<GlobalExceptionFilter>();
                // ��־������
                options.Filters.Add<RequestActionFilter>();
            })
            .AddDataValidation()
            .AddApiResult<CustomApiResultProvider>(); 

        // ����Jsonѡ��
        builder.Services.AddJsonOptions();

        // ���sqlsugar
        builder.Services.AddSqlsugarSetup();

        // ���swagger�ĵ�
        builder.Services.AddSwaggerSetup();
         
        var dllnames =new string[] { "MalusAdmin.Servers", "MalusAdmin.Common" };
        // �Զ���ӷ����
        builder.Services.AddAutoServices(dllnames);
          
        //�����Ȩ
        //builder.Services.AddAuthorization();
        // ����Զ�����Ȩ
        builder.Services.AddAuthorizationSetup();

        // �滻Ĭ�� PermissionChecker
        //builder.Services.Replace(new ServiceDescriptor(typeof(IPermissionChecker), typeof(PermissionChecker), ServiceLifetime.Transient));

        // ��ӿ���֧��
        builder.Services.AddCorsSetup();

        //��Ӧ�����м��
        builder.Services.AddResponseCaching();

        //ʵʱӦ��
        builder.Services.AddSignalR();

        // ���EndpointsApiExplorer
        builder.Services.AddEndpointsApiExplorer();


        var app = builder.Build();
        //д�뾲̬�๩ȫ�ֻ�ȡ
        App.ServiceProvider = app.Services;
        App.Configuration = builder.Configuration;

        //ForwardedHeaders�м�����Զ��ѷ�����������ת��������X-Forwarded-For���ͻ�����ʵIP���Լ�X-Forwarded-Proto���ͻ��������Э�飩
        //�Զ���䵽HttpContext.Connection.RemoteIPAddress��HttpContext.Request.Scheme�У�����Ӧ�ô����ж�ȡ���ľ�����ʵ��IP����ʵ��Э���ˣ�����ҪӦ�������⴦��
        app.UseForwardedHeaders(new ForwardedHeadersOptions
        {
            ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto
        });


        // Configure the HTTP request pipeline.
        if (AppSettings.DisplaySwaggerDoc) app.UseSwaggerExtension();


        app.UseDefaultFiles(); // �ṩĬ���ļ�֧��
        app.UseStaticFiles(); // ���þ�̬�ļ�����

        app.UseHttpsRedirection(); // ����ǰ�棬ȷ����������ͨ��HTTPS

        app.UseRouting(); // ȷ��·��

        app.UseCors(); // ���ÿ�����Դ����

        app.UseAuthentication(); // ���������֤�м��

        app.UseAuthorization(); // ������Ȩ�м��

        app.UseResponseCaching(); // Ӧ����Ӧ����

        app.UseMiddleware<CheckToken>(); // ���CheckToken�������֤�м����������֤֮ǰ

        app.MapHub<OnlineUserHub>("/hub"); // ӳ��SignalR Hub

        app.MapControllers(); // ӳ�������

        app.Run(); // ����������
    }
}