package udptest;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Scanner;

public class UdpClient {

	/**
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		int serverPort = 2345;
		int clientPort = 2346;
		while (true) {

			System.out.println("输入半径：");
			Scanner sio = new Scanner(System.in);
			int radius = sio.nextInt();
			if (radius < 0) {
				System.out.println("输入错误");
				continue;
			}
			;

			DatagramSocket sendSocket = new DatagramSocket();
			DatagramPacket dataPack = new DatagramPacket(Integer.toString(
					radius).getBytes(), Integer.toString(radius).length(),
					InetAddress.getByName("127.0.0.1"), new Integer(serverPort));
			sendSocket.send(dataPack);
			System.out.println("Client发送:\t" + radius);
			sendSocket.close();

			byte[] buffer = new byte[2048];
			DatagramSocket datagramSocket = new DatagramSocket(clientPort);
			DatagramPacket datagramPacket = new DatagramPacket(buffer,
					buffer.length);
			for (int i = 0; i < 10; i++) {
				datagramSocket.receive(datagramPacket);
				System.out.println("Client收到:\t"
						+ new String(datagramPacket.getData()).trim());
			}
		}
	}

}
