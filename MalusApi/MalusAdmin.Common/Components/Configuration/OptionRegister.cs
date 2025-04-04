﻿using System.Reflection;
using MalusAdmin.Common;
using Microsoft.Extensions.DependencyInjection;


public static class OptionRegister
{
    /// <summary>
    /// 注册配置选项
    /// </summary>
    /// <param name="services"></param>
    /// <exception cref="ArgumentNullException"></exception>
    public static void AddOptionRegister(this IServiceCollection services)
    {
        if (services == null) throw new ArgumentNullException(nameof(services));

        var optionTypes = Assembly.LoadFrom(Path.Combine(AppContext.BaseDirectory, "MalusAdmin.Common.dll") )
        .GetTypes().Where(x=>x.IsPublic) 
        .Where(x => x.GetCustomAttribute<OptionsSettingsAttribute>() != null).ToList();

        foreach (var optionType in optionTypes)
        {
            services.AddConfigurableOptions(optionType);
        }
    }
}

