
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
let tcpConnectOptions: socket.TCPConnectOptions = {
  address: netAddress,
  timeout: 6000
}

@Entry
@Component
struct Index {
  //private tcpSocket: socket.TCPSocket = undefined;
  private isConnected: boolean = false;
  @State receivedData: string = 'Null';
  @State luxValues: number = 0;
  @State humidityValues: number = 0;
  @State temperatureValues: number = 0;
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
      // let lux = parts[0].split(':')[1];
      // let humidity = parts[1].split(':')[1];
      // let temperature = parts[2].split(':')[1];
      // let Led = parts[3].split(':')[1];
      // this.receivedData = `光照: ${lux}, 湿度: ${humidity}, 温度: ${temperature}`;
      //this.receivedData = str;
      this.luxValues = parseFloat(parts[0].split(':')[1]);
      this.humidityValues = parseFloat(parts[1].split(':')[1]);
      this.temperatureValues = parseFloat(parts[2].split(':')[1]);
      this.LedStatus = parseInt(parts[3].split(':')[1]);
    });

    this.tcpSocket.on('connect', () => {
      console.log("on connect");
      this.isConnected = true;
    });

    this.tcpSocket.connect(tcpConnectOptions, (err) => {
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
