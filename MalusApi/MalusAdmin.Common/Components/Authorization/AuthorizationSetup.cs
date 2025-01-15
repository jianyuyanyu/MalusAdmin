﻿using MalusAdmin.Common.Components; 
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authentication.OAuth;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;

namespace MalusAdmin.Common;

public static class AuthorizationSetup
{
    public static IServiceCollection AddAuthorizationSetup(this IServiceCollection services)
    {
  
        switch (AppSettings.AuthenMethod)
        {
            case AuthenMethodStatus.Jwt:
                 
                // 启动Jwt授权
                services.AddJwtSetup();
                break;

            default:
                services.AddAuthorization(); 
                services.AddTransient<IAuthorizationPolicyProvider, CustomAuthorizationPolicyProvider>();
                services.AddTransient<IAuthorizationHandler, CustomAuthorizationHandler>();
                services.AddTransient<IPermissionChecker, DefaultPermissionChecker>();
                break;
        } 
        return services;
    }
}