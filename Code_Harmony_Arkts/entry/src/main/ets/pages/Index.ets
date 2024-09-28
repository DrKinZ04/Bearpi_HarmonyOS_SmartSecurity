// import { socket } from '@kit.NetworkKit';
// import { BusinessError } from '@kit.BasicServicesKit';
//
// // 模拟从小熊派采集温湿度数据的函数
// function getSensorData(): string {
//   // 假设从小熊派的传感器采集数据
//   let temperature = (Math.random() * 5 + 20).toFixed(2); // 模拟温度数据 20~25°C
//   let humidity = (Math.random() * 10 + 40).toFixed(2);   // 模拟湿度数据 40%~50%
//   return `Temperature: ${temperature}°C, Humidity: ${humidity}%`;
// }
//
// // 定义 SocketInfo 类，用来处理接收到的消息
// class SocketInfo {
//   message: ArrayBuffer = new ArrayBuffer(1);
//   remoteInfo: socket.SocketRemoteInfo = {} as socket.SocketRemoteInfo;
// }
//
// // 创建一个TCPSocket连接，返回一个TCPSocket对象
// let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
//
// // 注册监听器，接收服务器发来的消息
// tcp.on('message', (value: SocketInfo) => {
//   console.log("on message");
//   let buffer = value.message;
//   let dataView = new DataView(buffer);
//   let str = "";
//   for (let i = 0; i < dataView.byteLength; ++i) {
//     str += String.fromCharCode(dataView.getUint8(i));
//   }
//   console.log("on connect received:" + str);
// });
//
// // 监听 Socket 连接成功的事件
// tcp.on('connect', () => {
//   console.log("on connect");
//
//   // 定时发送传感器数据到服务器（手机）
//   let interval = setInterval(() => {
//     let sensorData = getSensorData();
//     console.log("Sending sensor data: " + sensorData);
//
//     let tcpSendOptions: socket.TCPSendOptions = {
//       data: sensorData
//     };
//
//     tcp.send(tcpSendOptions).then(() => {
//       console.log('send success');
//     }).catch((err: BusinessError) => {
//       console.log('send fail');
//     });
//   }, 5000); // 每5秒发送一次数据
//
//   // 30秒后停止发送并关闭连接
//   setTimeout(() => {
//     clearInterval(interval);
//     tcp.close().then(() => {
//       console.log('close success');
//     }).catch((err: BusinessError) => {
//       console.log('close fail');
//     });
//     tcp.off('message');
//     tcp.off('connect');
//     tcp.off('close');
//   }, 30 * 1000); // 30秒后关闭连接
// });
//
// // 监听 Socket 关闭的事件
// tcp.on('close', () => {
//   console.log("on close");
// });
//
// // 绑定本地IP地址和端口
// let ipAddress : socket.NetAddress = {} as socket.NetAddress;
// ipAddress.address = "192.168.xxx.xxx";  // 替换为实际IP地址
// ipAddress.port = 1234; // 替换为实际端口
//
// tcp.bind(ipAddress, (err: BusinessError) => {
//   if (err) {
//     console.log('bind fail');
//     return;
//   }
//   console.log('bind success');
//
//   // 连接到鸿蒙手机的IP地址和端口
//   ipAddress.address = "192.168.xxx.xxx"; // 替换为手机的IP地址
//   ipAddress.port = 5678; // 替换为实际端口
//
//   let tcpConnect : socket.TCPConnectOptions = {} as socket.TCPConnectOptions;
//   tcpConnect.address = ipAddress;
//   tcpConnect.timeout = 6000;
//
//   tcp.connect(tcpConnect).then(() => {
//     console.log('connect success');
//   }).catch((err: BusinessError) => {
//     console.log('connect fail');
//   });
// });
//
//

//
// import socket from '@ohos.net.socket';
//
// // 创建一个TCPSocket连接，返回一个TCPSocket对象。
// let tcp = socket.constructTCPSocketInstance();
//
// // 订阅TCPSocket相关的订阅事件
// tcp.on('message', value => {
//   console.log("on message")
//   let buffer = value.message
//   let dataView = new DataView(buffer)
//   let str = ""
//   for (let i = 0; i < dataView.byteLength; ++i) {
//     str += String.fromCharCode(dataView.getUint8(i))
//   }
//   console.log("on connect received:" + str)
// });
// tcp.on('connect', () => {
//   console.log("on connect")
// });
// tcp.on('close', () => {
//   console.log("on close")
// });
//
// interface IConnectAddress {
//   address: string;
//   port: number;
//   family: number;
// }
//
// // let connectAddress: IConnectAddress = {
// //   address: '192.168.xx.xx',
// //   port: 5678,
// //   family: 1
// // };
//
// // 绑定IP地址和端口。 （本机地址，端口号可以任意，只要没被占用就行）
// let bindAddress: IConnectAddress = {
//   address: '192.168.xx.xx',
//   port: 1234, // 绑定端口，如1234
//   family: 1
// };
// tcp.bind(bindAddress, err => {
//   if (err) {
//     console.log('bind fail');
//     return;
//   }
//   console.log('bind success');
//   // 连接到指定的IP地址和端口。（服务器地址）
//   let connectAddress : IConnectAddress= {
//     address: '192.168.xx.xx',
//     port: 5678, // 连接端口，如5678
//     family: 1
//   };
//   tcp.connect({
//     address: connectAddress, timeout: 6000
//   }, err => {
//     if (err) {
//       console.log('connect fail');
//       return;
//     }
//     console.log('connect success');
//     // 发送数据
//     tcp.send({
//       data: 'Hello, server!'
//     }, err => {
//       if (err) {
//         console.log('send fail');
//         return;
//       }
//       console.log('send success');
//     })
//   });
// });
// // 连接使用完毕后，主动关闭。取消相关事件的订阅。
// setTimeout(() => {
//   tcp.close((err) => {
//     console.log('close socket.')
//   });
//   tcp.off('message');
//   tcp.off('connect');
//   tcp.off('close');
// }, 30 * 1000);
//
//
//
// @Entry
// @Component
// struct Index  {
//   build() {
//   }
// }

// import socket from '@ohos.net.socket';
//
// interface IConnectAddress {
//   address: string;
//   port: number;
//   family: number;
// }
//
// const serverAddress: IConnectAddress = {
//   address: '服务器 IP 地址',
//   port: 8888,
//   family: 1,
// };
//
// @Entry
// @Component
// struct Index {
//   private tcpSocket: socket.TCPSocket;
//   private isConnected: boolean = false;
//   // 用于存储接收到的消息文本
//   private messageText: string = '';
//
//   build() {
//     Column() {
//       // 显示接收到的消息，使用 Text 组件展示消息文本
//       Text(this.messageText)
//         .fontSize(16)
//         .margin({ top: 10 });
//       // 连接按钮
//       Button('连接')
//         .onClick(() => {
//           if (!this.isConnected) {
//             this.startConnection();
//           }
//         })
//         .margin({ top: 20 });
//     }
//   }
//
//   private startConnection() {
//     this.tcpSocket = socket.constructTCPSocketInstance();
//
//     this.tcpSocket.on('message', value => {
//       console.log("on message");
//       let buffer = value.message;
//       let dataView = new DataView(buffer);
//       let str = "";
//       for (let i = 0; i < dataView.byteLength; ++i) {
//         str += String.fromCharCode(dataView.getUint8(i));
//       }
//       console.log("on connect received:" + str);
//       // 将接收到的消息更新到页面显示的文本中
//       this.messageText = str;
//     });
//
//     this.tcpSocket.on('connect', () => {
//       console.log("on connect");
//       this.isConnected = true;
//     });
//
//     let bindAddress: IConnectAddress = {
//       address: '192.168.xx.xx',
//       port: 1234,
//       family: 1,
//     };
//
//     this.tcpSocket.bind(bindAddress, err => {
//       if (err) {
//         console.log('bind fail');
//         return;
//       }
//       console.log('bind success');
//
//       this.tcpSocket.connect({
//         address: serverAddress,
//         timeout: 6000,
//       }, err => {
//         if (err) {
//           console.log('connect fail');
//           return;
//         }
//         console.log('connect success');
//         this.tcpSocket.send({
//           data: 'Hello, server!',
//         }, err => {
//           if (err) {
//             console.log('send fail');
//             return;
//           }
//           console.log('send success');
//         });
//       });
//     });
//   }
// }

import socket from '@ohos.net.socket';

interface IConnectAddress {
  address: string;
  port: number;
  family: number;
}

// const serverAddress: IConnectAddress = {
//   address: '服务器的 IP 地址（如果是本地可尝试 127.0.0.1）',
//   port: 12345,
//   family: 1,
// };
//设置要连接的服务器的IP和端口
let netAddress: socket.NetAddress = {
  address: '192.168.137.181',
  port: 8888
}
let tcpconnectoptions: socket.TCPConnectOptions = {
  address: netAddress,
  timeout: 6000
}

@Entry
@Component
struct Index {
  //private tcpSocket: socket.TCPSocket = undefined;
  private isConnected: boolean = false;
  @State receivedData: string = 'Null';
  @State printStr: string = 'Null'
  @State luxValues: number = 0;
  @State humidityValues: number = 0;
  @State temperatureValues: number = 0;
  @State message: string = this.humidityValues.toString()
  private tcpSocket: socket.TCPSocket | undefined; // 存储连接时的 socket
  @State openLedDown: string = 'opend'
  @State openLedUp: string = 'openu'
  @State openFan: string = 'openf'
  @State close: string = 'off'
  @State LedStatus:number = 0

  build() {
    Column({space:10}) {

      Row({space:10}) {
        // 连接按钮
        Button('连接服务器')
          .onClick(() => {
            if (!this.isConnected) {
              this.connectToServer();
              //this.changeSTR();
            }
          })
          .margin({ top: 20 });
      }

      Row() {
        Button('开下灯')
          .margin(10)
          .onClick(() => {
            this.sendDataToServer(this.openLedDown)
          })
        Button('开上灯')
          .onClick(() => {
            this.sendDataToServer(this.openLedUp)
          })
        Button('开风扇')
          .onClick(() => {
            this.sendDataToServer(this.openFan)
          })
        Button('关闭器件')
          .onClick(() => {
            this.sendDataToServer(this.close)
          })
      }.justifyContent(FlexAlign.SpaceEvenly)
      Column({space:10}) {
        Text('温度：'+this.temperatureValues)
        Text('湿度：'+this.humidityValues)
        Text('光照：'+this.luxValues)
        if (this.LedStatus === 1){
          Text('Led下亮')
        }else {
          Text('Led下灭')
        }
      }

      Column() {
        Gauge({ value: this.humidityValues, min: 0, max: 100 }) {
          Column() {
            Text('湿度：' + `${this.humidityValues}`)
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor("#ff182431")
              .width('40%')
              .height('30%')
              .textAlign(TextAlign.Center)
              .margin({ top: '30%' })
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
          }.width('100%').height('100%')
        }
        .startAngle(225)
        .endAngle(135)
        .colors(new LinearGradient([{ color: "#e84026", offset: 0 },
          { color: "#f7ce00", offset: 0.6 },
          { color: "#64bb5c", offset: 1 }]))
        .width('80%')
        .height('80%')
        .strokeWidth(18)
        .trackShadow({ radius: 7, offsetX: 7, offsetY: 7 })
        .padding(18)
      }.margin({ top: 40 }).width('100%').height('100%')
    }
  }

  private connectToServer() {
    this.tcpSocket = socket.constructTCPSocketInstance();

    this.tcpSocket.on('message', value => {
      console.log("on message");
      let buffer = value.message;
      let dataView = new DataView(buffer);
      let str = "";
      for (let i = 0; i < dataView.byteLength; ++i) {
        str += String.fromCharCode(dataView.getUint8(i));
      }
      console.log("on connect received:" + str);


      let parts = str.split(',');
      let lux = parts[0].split(':')[1];
      let humidity = parts[1].split(':')[1];
      let temperature = parts[2].split(':')[1];
      let Led = parts[3].split(':')[1];
      this.receivedData = `光照: ${lux}, 湿度: ${humidity}, 温度: ${temperature}`;
      //this.receivedData = str;
      let luxs = parseFloat(parts[0].split(':')[1]);
      let humiditys = parseFloat(parts[1].split(':')[1]);
      let temperatures = parseFloat(parts[2].split(':')[1]);
      this.luxValues = luxs;
      this.humidityValues = humiditys;
      this.temperatureValues = temperatures;
      this.LedStatus = parseInt(parts[3].split(':')[1]);
    });

    this.tcpSocket.on('connect', () => {
      console.log("on connect");
      this.isConnected = true;
    });

    this.tcpSocket.connect(tcpconnectoptions, (err) => {
      if (err) {
        console.log('connect fail');
        return;
      }
      console.log('connect success');
    });
  }
  private sendDataToServer(status: string) {
    if (this.isConnected && this.tcpSocket) {
      let tcpSendOptions: socket.TCPSendOptions = {
        data: status
      }
      this.tcpSocket.send(tcpSendOptions, (err, BusinessError) => {
        if (err) {
          console.log("Error sending data: " + err);
          return;
        }
        console.log("Data sent successfully.");
      });
    } else {
      console.log('Not connected to server. Cannot send data.');
    }
  }
}
