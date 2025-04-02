using MalusAdmin.Common.Components;
using MalusAdmin.Servers.Hub;
using MalusAdmin.WebApi;


var builder = WebApplication.CreateBuilder(args);
//Appע�� 
builder.ConfigureApplication();

//��������ע�� | ��Ӿ�̬�ļ���ȡ(���ȼ��Ƚϸ�)
AppSettings.AddConfigSteup(builder.Configuration);
builder.Services.AddOptionRegister();
//����
builder.Services.AddCacheSetup();
//��������ע��
builder.Services.AddBaseServices();
//��ӹ�����
builder.Services.AddControllers(options =>
{
    //��Ȩɸѡ�� 
    //options.Filters.Add<CustomAuthorizationFilter>();
    //ȫ���쳣����
    //options.Filters.Add<GlobalExceptionFilter>();
    //��־������
    //options.Filters.Add<RequestActionFilter>();
    options.Filters.Add<ResultFilter>();
}).AddDataValidation();
//.AddApiJson<CustomApiJsonProvider>();
//����Jsonѡ��
//builder.Services.AddTextJsonOptions();
builder.Services.AddJsonOptions();
builder.Services.AddSqlsugarSetup();
builder.Services.AddSwaggerBaseSetup();
var dllnames = new string[] { "MalusAdmin.Servers" };
builder.Services.AddAutoServices(dllnames);

//�����Ȩ
//builder.Services.AddAuthorization();
builder.Services.AddAuthorizationSetup();
// �滻Ĭ�� PermissionChecker[Ȩ�޼��]
builder.Services.Replace(new ServiceDescriptor(typeof(IPermissionChecker), typeof(PermissionChecker), ServiceLifetime.Transient));

builder.Services.AddCorsSetup();
builder.Services.AddResponseCaching();
builder.Services.AddSignalR();
//rabbit
//builder.Services.AddRabbitMqClientExtension();
//builder.Services.AddEasyNetQExtension(); 
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
//app.UseMiddleware<CheckToken>();

app.MapHub<OnlineUserHub>("/hub");// ӳ��SignalR Hub

app.MapControllers(); // ӳ�������

// ����������
app.Run();