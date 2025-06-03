﻿using MalusAdmin.Servers;
using Microsoft.AspNetCore.Mvc.Infrastructure;
using Microsoft.AspNetCore.Routing;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.DependencyInjection;
using Simple.DynamicWebApi.Abstractions;

namespace MalusAdmin.Servers;

/// <summary>
/// 测试服务
/// </summary>

[ApiExplorerSettings(GroupName = nameof(ApiVersionGropInfo.Default))]
public class TestService: ApiControllerBase
{
    private readonly IActionDescriptorCollectionProvider _actionDescriptorCollectionProvider;
    private readonly ISqlSugarClient _db;
    private readonly IHttpContextAccessor _httpContext; 
    private readonly SqlSugarRepository<TSysOnlineUser> _rep; // 仓储

    public TestService(ISqlSugarClient db, IActionDescriptorCollectionProvider actionDescriptorCollectionProvider,  SqlSugarRepository<TSysOnlineUser> rep)

    {
        _rep = rep;
        _db = db;
        _actionDescriptorCollectionProvider = actionDescriptorCollectionProvider; 
    }

    /// <summary>
    /// 获取接口所有的路由信息
    /// </summary>
    /// <returns></returns>
    [NonAction]
    public async Task<dynamic> GetAllButton()
    { 
        // 获取所有路由信息
        var actionDescriptors = _actionDescriptorCollectionProvider.ActionDescriptors.Items;

        // 创建一个列表来存储路由信息
        var routeInfoList = new List<dynamic>();

        // 遍历所有路由信息
        foreach (var actionDescriptor in actionDescriptors)
            // 检查路由是否是HTTP动作
            if (actionDescriptor.EndpointMetadata.Any(m => m is HttpMethodMetadata))
            {
                // 创建一个字典来存储路由信息
                var routeInfo = new Dictionary<string, object>
                {
                    {
                        "permissionName",
                        actionDescriptor.EndpointMetadata.OfType<PermissionAttribute>().FirstOrDefault()?.PermissionName
                    },
                    {
                        "ApiPath",
                        "api:" + actionDescriptor.RouteValues["controller"] + ":" +
                        actionDescriptor.RouteValues["action"]
                    },
                    { "ActionName", actionDescriptor.DisplayName },
                    { "RouteTemplate", actionDescriptor.RouteValues["action"] },
                    { "ControllerName", actionDescriptor.RouteValues["controller"] },
                    {
                        "HttpMethods",
                        actionDescriptor.EndpointMetadata.OfType<HttpMethodMetadata>()
                            .Select(m => m.HttpMethods.FirstOrDefault())
                    }
                };

                // 将字典添加到列表中
                routeInfoList.Add(routeInfo);
            }

        // 将列表转换为动态类型返回
        return routeInfoList;
    }


   
    public async Task<bool> GetException207BadBad()
    {
        //throw new Exception("Exception207Bad");
        throw ApiException.Exception207Bad("sdasd,asdasd");
    
    }

    public async Task<bool> GetException()
    {
        throw new Exception("error12312");
    }
}