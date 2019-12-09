package org.jgroups.docker;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * Simple TCP server replying back to client with connection information (peer address etc)
 * @author Bela Ban
 * @since  4.1.8
 */
public class EchoServer {
    protected ServerSocket srv_sock;

    protected void start(InetAddress bind_addr, int port) throws IOException {
        srv_sock=new ServerSocket(port, 50, bind_addr);
        System.out.printf("%s listening on %s\n", EchoServer.class.getSimpleName(), srv_sock.getLocalSocketAddress());
        while(!srv_sock.isClosed()) {
            try(Socket client_sock=srv_sock.accept();
                OutputStream output=client_sock.getOutputStream()) {
                String s=String.format("srv listening on %s (host: %s)\nclient: local=%s, remote=%s\n",
                                       srv_sock.getLocalSocketAddress(), InetAddress.getLocalHost().getHostName(),
                                       client_sock.getLocalSocketAddress(), client_sock.getRemoteSocketAddress());
                output.write(s.getBytes());
                output.flush();
            }
        }
    }

    public static void main(String[] args) throws Exception {
        InetAddress bind_addr=null;
        int port=12000;
        for(int i=0; i < args.length; i++) {
            if(args[i].startsWith("-bind_addr")) {
                bind_addr=InetAddress.getByName(args[++i]);
                continue;
            }
            if(args[i].startsWith("-port")) {
                port=Integer.parseInt(args[++i]);
                continue;
            }
            System.out.println("EchoServer [-bind_addr addr] [-port port] [-h]");
            return;
        }
        EchoServer es=new EchoServer();
        es.start(bind_addr, port);
    }


}
