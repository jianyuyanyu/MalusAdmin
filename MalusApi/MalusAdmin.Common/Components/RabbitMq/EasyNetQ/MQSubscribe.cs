﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EasyNetQ;
using MalusAdmin.Repository.Model;

namespace MalusAdmin.Common.Components
{
    public class MQSubscribe
    {
        // MQ消息总线
        private readonly IBus bus;
        private readonly ISqlSugarClient db;
        public MQSubscribe(IBus bus,ISqlSugarClient db)
        {
            this.bus = bus;
            this.db = db;
        }

        /// <summary>
        /// 处理消息的总入口
        /// </summary>
        /// <returns></returns>
        public Task Init()
        {
            SubscribeTSysLogVis();
            //程序不结束，等待输入
            Console.WriteLine($"已启动（处理消息） {DateTime.UtcNow}");

            return Task.CompletedTask;
        }

        private Task SubscribeTSysLogVis()
        {
            var advancedBus = bus.Advanced;
            //订阅TSysLogVis日志
            var queue = advancedBus.QueueDeclare("TSysLogVis");

            advancedBus.Consume(queue, async (body, properties, info) =>
            {
                var message = Encoding.UTF8.GetString(body.ToArray());

                var data = JsonConvert.DeserializeObject<TSysLogVis>(message);
            
                Console.WriteLine($"消息处理 {DateTime.Now} : {JsonConvert.SerializeObject(message)}");
                db.Insertable(data).SplitTable().ExecuteReturnSnowflakeId();

            });

            return Task.CompletedTask;
        }
    }
}
