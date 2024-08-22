﻿using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MalusAdmin.BackUpServices.Model;
using Newtonsoft.Json;
using Quartz;
using RabbitMQ.Client;

namespace MalusAdmin.BackUpServices.QuartzJob
{
    /// <summary>
    /// 要继承IJob
    /// </summary>
    public class EveryDayBingQuartzJob : IJob
    {
        /// <summary>
        /// 当前任务执行的Core表达式,meitian8dian1
        /// </summary>
        public static string Cron = "0 0 7 * * ? ";


        public async Task Execute(IJobExecutionContext context)
        {
            try
            {
                await Doing();
            }
            catch (Exception ex)
            {
                FileHelper.Write(ex.Message, "error");
            }
        }

        /// <summary>
        /// 处理当天的必应壁纸
        /// </summary>
        public async Task Doing()
        {

            try
            { 
                //https://blog.csdn.net/qq_40732336/article/details/119144101
                var requrl = "https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1";
                using (var webClient = new System.Net.Http.HttpClient())
                {

                    var response = await webClient.GetStringAsync(requrl);
                    var entity = JsonConvert.DeserializeObject<EveryBingRes>(response);
                    var dayindex = 0;
                    var StartDate = DateTime.ParseExact(entity.images[dayindex].enddate, "yyyyMMdd", new CultureInfo("zh-CN"), DateTimeStyles.AllowWhiteSpaces);
                    var BingPic = "https://cn.bing.com" + entity.images[dayindex].urlbase + "_1920x1080.jpg";
                    var model = SqlsugarHelper.db.Queryable<bs_bingwallpaper>().Where(x => x.StartDate == StartDate).First();
                    if (model != null)
                    {
                        model.Url = BingPic;
                        model.CopyRight = entity.images[dayindex].copyright;
                        model.MobileUrl = BingPic.Replace("1920x1080.jpg", "1080x1920.jpg");
                        model.StartDate = StartDate;
                        model.IsDeleted = false;
                        SqlsugarHelper.db.Updateable(model).ExecuteCommand();
                        var str = "更新照片:" + StartDate + entity.images[dayindex].copyright;
                        Console.WriteLine(str);
                        FileHelper.Write("logs/bingrun" , $"{str} ");

                    }
                    else
                    {
                        model = new bs_bingwallpaper();
                        model.Url = BingPic;
                        model.MobileUrl = BingPic.Replace("1920x1080.jpg", "1080x1920.jpg");
                        model.CopyRight = entity.images[dayindex].copyright;
                        model.StartDate = StartDate;
                        model.IsDeleted = false;
                         SqlsugarHelper.db.Insertable(model).ExecuteCommand();
                        var str = "添加照片:" + StartDate + entity.images[dayindex].copyright;
                        Console.WriteLine(str);
                        FileHelper.Write("logs/bingrun" , $"{str} \r \n");

                    }
                }
            }
            catch (Exception e)
            {
               await FileHelper.Write("logs/error" , $"{e.ToString()}"); 
            }

        }
    }
}