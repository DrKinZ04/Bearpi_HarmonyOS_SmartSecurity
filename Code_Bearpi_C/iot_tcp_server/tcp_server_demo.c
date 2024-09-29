// /*
//  * Copyright (c) 2020 Nanjing Xiaoxiongpai Intelligent Technology Co., Ltd.
//  * Licensed under the Apache License, Version 2.0 (the "License");
//  * you may not use this file except in compliance with the License.
//  * You may obtain a copy of the License at
//  *
//  *    http://www.apache.org/licenses/LICENSE-2.0
//  *
//  * Unless required by applicable law or agreed to in writing, software
//  * distributed under the License is distributed on an "AS IS" BASIS,
//  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  * See the License for the specific language governing permissions and
//  * limitations under the License.
//  */

// #include <stdio.h>
// #include <unistd.h>

// #include "ohos_init.h"
// #include "cmsis_os2.h"

// #include "lwip/sockets.h"
// #include "wifi_connect.h"

// #define _PROT_ 8888
// #define TCP_BACKLOG 10

// //改造
// #include <string.h>
// #include "E53_IA1.h"
// #include "wifiiot_gpio.h"
// #include "wifiiot_gpio_ex.h"

// #define TASK_STACK_SIZE 1024 * 8
// #define TASK_PRIO 25

// E53_IA1_Data_TypeDef E53_IA1_Data;

// int flag = 0;

// static void F1_Pressed(char *arg)
// {
//     (void)arg;
//     flag = 1;
// }
// static void F2_Pressed(char *arg)
// {
//     (void)arg;
//     flag = 0;
// }

// //改造

// //在sock_fd 进行监听，在 new_fd 接收新的链接
// int sock_fd, new_fd;

// char recvbuf[512];
// char *buf = "Hello! I'm BearPi-HM_Nano TCP Server!";

// static void TCPServerTask(void)
// {
// 	//服务端地址信息
// 	struct sockaddr_in server_sock;

// 	//客户端地址信息
// 	struct sockaddr_in client_sock;
// 	int sin_size;

// 	struct sockaddr_in *cli_addr;

// 	//连接Wifi
// 	WifiConnect("forBearpi", "123456789");

// 	//创建socket
// 	if ((sock_fd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
// 	{
// 		perror("socket is error\r\n");
// 		exit(1);
// 	}

// 	bzero(&server_sock, sizeof(server_sock));
// 	server_sock.sin_family = AF_INET;
// 	server_sock.sin_addr.s_addr = htonl(INADDR_ANY);
// 	server_sock.sin_port = htons(_PROT_);

// 	//调用bind函数绑定socket和地址
// 	if (bind(sock_fd, (struct sockaddr *)&server_sock, sizeof(struct sockaddr)) == -1)
// 	{
// 		perror("bind is error\r\n");
// 		exit(1);
// 	}

// 	//调用listen函数监听(指定port监听)
// 	if (listen(sock_fd, TCP_BACKLOG) == -1)
// 	{
// 		perror("listen is error\r\n");
// 		exit(1);
// 	}

// 	printf("start accept\n");

// 	//改造
// 	E53_IA1_Init();
//     //初始化F1按键，设置为下降沿触发中断
//     IoSetFunc(WIFI_IOT_IO_NAME_GPIO_11, WIFI_IOT_IO_FUNC_GPIO_11_GPIO);

//     GpioSetDir(WIFI_IOT_IO_NAME_GPIO_11, WIFI_IOT_GPIO_DIR_IN);
//     IoSetPull(WIFI_IOT_IO_NAME_GPIO_11, WIFI_IOT_IO_PULL_UP);
//     GpioRegisterIsrFunc(WIFI_IOT_IO_NAME_GPIO_11, WIFI_IOT_INT_TYPE_EDGE, WIFI_IOT_GPIO_EDGE_FALL_LEVEL_LOW, F1_Pressed, NULL);

//     //初始化F2按键，设置为下降沿触发中断
//     IoSetFunc(WIFI_IOT_IO_NAME_GPIO_12, WIFI_IOT_IO_FUNC_GPIO_12_GPIO);

//     GpioSetDir(WIFI_IOT_IO_NAME_GPIO_12, WIFI_IOT_GPIO_DIR_IN);
//     IoSetPull(WIFI_IOT_IO_NAME_GPIO_12, WIFI_IOT_IO_PULL_UP);
//     GpioRegisterIsrFunc(WIFI_IOT_IO_NAME_GPIO_12, WIFI_IOT_INT_TYPE_EDGE, WIFI_IOT_GPIO_EDGE_FALL_LEVEL_LOW, F2_Pressed, NULL);


// 	printf("\r\n=======================================\r\n");
//     printf("\r\n************张金龙_202141040226**********\r\n");
//     printf("\r\n=======================================\r\n");

// 	//改造

// 	//调用accept函数从队列中
// 	while (1)
// 	{
// 		sin_size = sizeof(struct sockaddr_in);

// 		if ((new_fd = accept(sock_fd, (struct sockaddr *)&client_sock, (socklen_t *)&sin_size)) == -1)
// 		{
// 			perror("accept");
// 			continue;
// 		}

// 		cli_addr = malloc(sizeof(struct sockaddr));

// 		printf("accept addr\r\n");

// 		if (cli_addr != NULL)
// 		{
// 			memcpy(cli_addr, &client_sock, sizeof(struct sockaddr));
// 		}

// 		//处理目标
// 		ssize_t ret;
// 					char bufTmp[512];  // 定义一个更大的缓冲区用于存储传感器数据

// 		while (1)
// 		{
// 			E53_IA1_Read_Data();

// 			sprintf(bufTmp, "Lux: %.2f, Humidity: %.2f, Temperature: %.2f", E53_IA1_Data.Lux, E53_IA1_Data.Humidity, E53_IA1_Data.Temperature);

// 			*buf = bufTmp;
// 			//sprintf(*buf,"the Hum is %.2f,Tem is %.2f",E53_IA1_Data.Humidity,E53_IA1_Data.Temperature);
// 			if ((ret = recv(new_fd, recvbuf, sizeof(recvbuf), 0)) == -1)
// 			{
// 				printf("recv error \r\n");
// 			}
// 			printf("recv :%s\r\n", recvbuf);
// 			sleep(2);
// 			if ((ret = send(new_fd, buf, strlen(buf) + 1, 0)) == -1 && flag == 0)
// 			{
// 				// perror("send : ");
// 				printf("暂停……\r\n");
// 			}
// 			sleep(2);
// 			if(flag)
//         {
//             //E53_IA1_Read_Data();

//             printf("\r\n******************************Lux Value is  %.2f\r\n", E53_IA1_Data.Lux);
//             printf("\r\n******************************Humidity is  %.2f\r\n", E53_IA1_Data.Humidity);
//             printf("\r\n******************************Temperature is  %.2f\r\n", E53_IA1_Data.Temperature);

//         }//else
//         // {
//         //     printf("暂停打印\r\n");
//         // }
        

//         usleep(1000000);
// 		}

// 		close(new_fd);
// 	}
// }

// static void TCPServerDemo(void)
// {
// 	osThreadAttr_t attr;

// 	attr.name = "TCPServerTask";
// 	attr.attr_bits = 0U;
// 	attr.cb_mem = NULL;
// 	attr.cb_size = 0U;
// 	attr.stack_mem = NULL;
// 	attr.stack_size = 10240;
// 	attr.priority = osPriorityNormal;

// 	if (osThreadNew((osThreadFunc_t)TCPServerTask, NULL, &attr) == NULL)
// 	{
// 		printf("[TCPServerDemo] Falied to create TCPServerTask!\n");
// 	}
// }

// APP_FEATURE_INIT(TCPServerDemo);



#include <stdio.h>
#include <unistd.h>
#include "ohos_init.h"
#include "cmsis_os2.h"
#include "lwip/sockets.h"
#include "wifi_connect.h"

#define _PROT_ 8888
#define TCP_BACKLOG 10

// 包含必要的头文件
#include <string.h>
#include "E53_IA1.h"
#include "wifiiot_gpio.h"
#include "wifiiot_gpio_ex.h"

#define TASK_STACK_SIZE 1024 * 8
#define TASK_PRIO 25

E53_IA1_Data_TypeDef E53_IA1_Data;

int flag = 0;

static void F1_Pressed(char *arg)
{
    (void)arg;
    flag = 1;
}

static void F2_Pressed(char *arg)
{
    (void)arg;
    flag = 0;
}

// Socket和新的连接描述符
int sock_fd, new_fd;

char recvbuf[512];
char sendbuf[512];  // 用于存储要发送的动态数据

// TCP 服务器任务
static void TCPServerTask(void)
{
    // 服务端和客户端的地址信息
    struct sockaddr_in server_sock;
    struct sockaddr_in client_sock;
    int sin_size;

    // 连接Wifi
    WifiConnect("forBearpi", "123456789");

    // 创建Socket
    if ((sock_fd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
    {
        perror("socket is error\r\n");
        exit(1);
    }

    bzero(&server_sock, sizeof(server_sock));
    server_sock.sin_family = AF_INET;
    server_sock.sin_addr.s_addr = htonl(INADDR_ANY);
    server_sock.sin_port = htons(_PROT_);

    // 绑定Socket和地址
    if (bind(sock_fd, (struct sockaddr *)&server_sock, sizeof(struct sockaddr)) == -1)
    {
        perror("bind is error\r\n");
        exit(1);
    }

    // 监听端口
    if (listen(sock_fd, TCP_BACKLOG) == -1)
    {
        perror("listen is error\r\n");
        exit(1);
    }

    printf("start accept\n");

    // 初始化E53_IA1
    E53_IA1_Init();

    // 初始化F1按键
    IoSetFunc(WIFI_IOT_IO_NAME_GPIO_11, WIFI_IOT_IO_FUNC_GPIO_11_GPIO);
    GpioSetDir(WIFI_IOT_IO_NAME_GPIO_11, WIFI_IOT_GPIO_DIR_IN);
    IoSetPull(WIFI_IOT_IO_NAME_GPIO_11, WIFI_IOT_IO_PULL_UP);
    GpioRegisterIsrFunc(WIFI_IOT_IO_NAME_GPIO_11, WIFI_IOT_INT_TYPE_EDGE, WIFI_IOT_GPIO_EDGE_FALL_LEVEL_LOW, F1_Pressed, NULL);

    // 初始化F2按键
    IoSetFunc(WIFI_IOT_IO_NAME_GPIO_12, WIFI_IOT_IO_FUNC_GPIO_12_GPIO);
    GpioSetDir(WIFI_IOT_IO_NAME_GPIO_12, WIFI_IOT_GPIO_DIR_IN);
    IoSetPull(WIFI_IOT_IO_NAME_GPIO_12, WIFI_IOT_IO_PULL_UP);
    GpioRegisterIsrFunc(WIFI_IOT_IO_NAME_GPIO_12, WIFI_IOT_INT_TYPE_EDGE, WIFI_IOT_GPIO_EDGE_FALL_LEVEL_LOW, F2_Pressed, NULL);

    // 打印信息
    printf("\r\n=======================================\r\n");
    printf("\r\n************张金龙_202141040226**********\r\n");
    printf("\r\n=======================================\r\n");

    // 接受客户端连接
    // while (1)
    // {
    //     sin_size = sizeof(struct sockaddr_in);

    //     if ((new_fd = accept(sock_fd, (struct sockaddr *)&client_sock, (socklen_t *)&sin_size)) == -1)
    //     {
    //         perror("accept");
    //         continue;
    //     }

    //     printf("accept addr\r\n");

    //     // 处理客户端消息和传感器数据
    //     ssize_t ret;

    //     while (1)
    //     {
    //         // 读取E53_IA1传感器数据
    //         E53_IA1_Read_Data();

    //         // 格式化数据
    //         snprintf(sendbuf, sizeof(sendbuf), "Lux: %.2f, Humidity: %.2f, Temperature: %.2f",
    //                  E53_IA1_Data.Lux, E53_IA1_Data.Humidity, E53_IA1_Data.Temperature);

    //         // 接收客户端消息
    //         if ((ret = recv(new_fd, recvbuf, sizeof(recvbuf), 0)) == -1)
    //         {
    //             printf("recv error \r\n");
    //             break;
    //         }
    //         printf("recv :%s\r\n", recvbuf);

    //         // 发送传感器数据
    //         if ((ret = send(new_fd, sendbuf, strlen(sendbuf), 0)) == -1)
    //         {
    //             printf("send error\r\n");
    //             break;
    //         }

    //         // 如果按下F1键，则打印传感器数据
    //         if (flag)
    //         {
    //             printf("\r\n******************************Lux Value:  %.2f\r\n", E53_IA1_Data.Lux);
    //             printf("\r\n******************************Humidity:   %.2f\r\n", E53_IA1_Data.Humidity);
    //             printf("\r\n******************************Temperature: %.2f\r\n", E53_IA1_Data.Temperature);
    //         }

    //         usleep(1000000);  // 延迟1秒
    //     }

    //     //close(new_fd);
    // }

    while (1)
    {
        sin_size = sizeof(struct sockaddr_in);

        if ((new_fd = accept(sock_fd, (struct sockaddr *)&client_sock, (socklen_t *)&sin_size)) == -1)
        {
            perror("accept");
            continue;
        }

        printf("accept addr\r\n");

        // 处理客户端消息和传感器数据
        ssize_t ret;

        while (1)
        {
            // 读取E53_IA1传感器数据
            E53_IA1_Read_Data();

            // 格式化数据
            snprintf(sendbuf, sizeof(sendbuf), "Lux: %.2f, Humidity: %.2f, Temperature: %.2f",
                     E53_IA1_Data.Lux, E53_IA1_Data.Humidity, E53_IA1_Data.Temperature);

            // 接收客户端消息
            // if ((ret = recv(new_fd, recvbuf, sizeof(recvbuf), 0)) == -1)
            // {
            //     printf("recv error \r\n");
            //     break;
            // }
            // printf("recv :%s\r\n", recvbuf);

            // 发送传感器数据
            

            // 如果按下F1键，则打印传感器数据
            if (flag)
            {
                printf("\r\n******************************Lux Value:  %.2f\r\n", E53_IA1_Data.Lux);
                printf("\r\n******************************Humidity:   %.2f\r\n", E53_IA1_Data.Humidity);
                printf("\r\n******************************Temperature: %.2f\r\n", E53_IA1_Data.Temperature);
                if ((ret = send(new_fd, sendbuf, strlen(sendbuf), 0)) == -1)
                {
                printf("send error\r\n");
                break;
                }
            }

            usleep(1000000);  // 延迟1秒
        }

        //close(new_fd);
    }

}

// 启动TCP服务器任务
static void TCPServerDemo(void)
{
    osThreadAttr_t attr;

    attr.name = "TCPServerTask";
    attr.attr_bits = 0U;
    attr.cb_mem = NULL;
    attr.cb_size = 0U;
    attr.stack_mem = NULL;
    attr.stack_size = 10240;
    attr.priority = osPriorityNormal;

    if (osThreadNew((osThreadFunc_t)TCPServerTask, NULL, &attr) == NULL)
    {
        printf("[TCPServerDemo] Failed to create TCPServerTask!\n");
    }
}

APP_FEATURE_INIT(TCPServerDemo);
