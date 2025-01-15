﻿using MalusAdmin.Common;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SqlSugar;
using Wechat.Servers;

namespace Wechat.WebApi.Controllers;

/// <summary>
/// 小程序基本服务
/// </summary>
public class WechatController : WxApiControllerBase
{
    private readonly ISqlSugarClient _db;
    private readonly IHttpContextAccessor _httpContext;
    private readonly ITokenService _tokenService;
    private readonly WeChatGetOpenId _wechatService;

    public WechatController(ISqlSugarClient db, WeChatGetOpenId wechatService,
        IHttpContextAccessor httpContext, ITokenService tokenService)
    {
        _db = db;
        _wechatService = wechatService;
        _httpContext = httpContext;
        _tokenService=tokenService;
    }

     

    /// <summary>
    /// 静默授权登录接口
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost]
    [AllowAnonymous]
    public async Task<dynamic> LoginAsync([FromBody] WechatPhoneLoginInput input)
    {
        var customerinfo = await _wechatService.GetOpenID(input.Code);
        var customerentity = await _db.Queryable<BsCustomer>().Where(x => x.OpenID == customerinfo.openid).FirstAsync();
        if (customerentity == null)
        {
            customerentity = new BsCustomer();
            customerentity.OpenID = customerinfo.openid;
            customerentity.NickName = "微信用户";
            customerentity.AvatarUrl = "http://imagesoss.hunji.xyz/conch-net/avatar/1.png";
            customerentity.CreatedDate = DateTime.Now;
            customerentity.UserID = _db.Storageable(customerentity).ExecuteReturnEntity().UserID;
        }

        //生成Token

        var dic = new Dictionary<string, string>
        {
            { "OpenID", customerentity.OpenID },
            { "UserId", customerentity.UserID.ToString() }
        };

        // 生成刷新Token令牌
        var token =await _tokenService.GenerateTokenAsync(dic);
        // 设置Swagger自动登录
        //httpContext.Response.Headers["access-token"] = accessToken;

        return new WxLoginOutput { token = token, userinfo = customerentity };
    }

    /// <summary>
    /// 用户基本信息输出
    /// </summary>
    /// <returns></returns>
    [HttpGet]
    [Authorize]
    public async Task<dynamic> getInfo()
    {  
        var user = await _db.Queryable<BsCustomer>()
            .Where(x => x.UserID == App.User.Info.UserId)
            .FirstAsync();
        if (user != null) return user;
        throw new Exception("获取用户信息失败，请重新登录");
    }

    /// <summary>
    /// 模拟的登录
    /// </summary>
    /// <param name="Password"></param>
    /// <returns>LoginOutput</returns>
    /// <example>Keltsing@123</example>
    [HttpPost("Testlogin")]
    public async Task<WxLoginOutput> Login(string Password = "os0uq5TUMheUQ_IIdEG4fVJ4ORNo")
    {
        var customerentity = await _db.Queryable<BsCustomer>()
            .Where(x => x.OpenID == Password).FirstAsync();
        if (customerentity == null) throw new Exception("获取用户信息失败，请重新登录");


        //生成Token

        var dic = new Dictionary<string, string>
        {
            { "OpenID", customerentity.OpenID },
            { "UserId", customerentity.UserID.ToString() }
        };
        // 生成刷新Token令牌
        var token =await _tokenService.GenerateTokenAsync(dic);

        // 设置Swagger自动登录
        _httpContext.HttpContext.Response.Headers["access-token"] = token;

        return new WxLoginOutput { token = token, userinfo = customerentity };
    }
}