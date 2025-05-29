﻿using System.Configuration;
using System.Reflection;
using MalusAdmin.Common.Components;
using MalusAdmin.Servers;
using MalusAdmin.Servers.Hub;
using MalusAdmin.Servers.SysOnlineUser;
using MalusAdmin.Servers.SysRoleMenu;
using MalusAdmin.Servers.SysUser;
using MalusAdmin.WebApi.Middleware;
using Microsoft.AspNetCore.Builder;
using SqlSugar.Extensions;

namespace MalusAdmin.WebApi
{ 

    // 扩展方法：服务注册
    public static class ServiceCollectionExtensions
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services, IConfiguration configuration)
        {
            //跨域处理
            services.AddCorsSetup();

            //缓存
            services.AddCacheSetup();

            //基础服务注册
            services.AddBaseServices();

            //添加过滤器
            services.AddControllers(options =>
            {
                //授权筛选器 
                //options.Filters.Add<CustomAuthorizationFilter>();
                //全局异常过滤
                //options.Filters.Add<GlobalExceptionFilter>();
                //日志过滤器
                //options.Filters.Add<RequestActionFilter>();
                //结果过滤器
                options.Filters.Add<ResultFilter>();

            }).AddDataValidation();

            //.AddApiJson<CustomApiJsonProvider>();

            //配置Json选项
            //services.AddTextJsonOptions();

            services.AddJsonOptions();

            services.AddSqlsugarSetup();

            services.AddSwaggerBaseSetup();


            var dllnames = new string[] { "MalusAdmin.Servers" };
            services.AddAutoServices(dllnames);
            //services.AddAutoInjection(Assembly.GetExecutingAssembly());

            //添加授权
            //services.AddAuthorization();
            services.AddAuthorizationSetup();

            // 替换默认 PermissionChecker[权限检查]
            //services.Replace(new ServiceDescriptor(typeof(IPermissionChecker), typeof(PermissionChecker), ServiceLifetime.Transient));

            //rabbit
            //services.AddRabbitMqClientExtension();
            //services.AddEasyNetQExtension(); 

            //services.AddDynamicApiControllers(); 

            //
            //services.AddTransient<ISysOnlineUserService, SysOnlineUserService>();
             
            // 打印所有注册的服务
            foreach (var service in services)
            {
                Console.WriteLine($"Service: {service.ServiceType.FullName}, " +
                                  $"Implementation: {service.ImplementationType?.FullName ?? "N/A"}, " +
                                  $"Lifetime: {service.Lifetime}");
            }

            // 将 IServiceCollection 注册为单例，以便在中间件中访问
            services.AddSingleton(services);

            return services;
        }
    }

    // 扩展方法：中间件配置
    public static class ApplicationBuilderExtensions
    {
        public static IApplicationBuilder UseApplicationMiddlewares(this IApplicationBuilder app)
        {
             
            app.ConfigureApplication();

            if (App.Configuration["DisplaySwaggerDoc"].ObjToBool()) app.UseSwaggerExtension();

            // 全局异常中间件
            app.UseMiddleware<GlobalException>();

            //获取远程真实ip,不是nginx代理部署可以不要
            app.UseMiddleware<RealIpMiddleware>();

            app.UseServiceInspector(); // 注册服务查询中间件

            app.UseHttpsRedirection(); // 确保所有请求都通过HTTPS

            app.UseRouting(); // 确定路由

            app.UseCors(); // 配置跨域资源共享

            app.UseAuthentication(); // 启用身份验证中间件

            app.UseAuthorization(); // 启用授权中间件

            app.UseStaticFiles(); // 启用静态文件服务

            app.UseDefaultFiles(); // 提供默认文件支持

            app.UseResponseCaching(); // 应用响应缓存


            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });

            return app;
        }
    }

}
