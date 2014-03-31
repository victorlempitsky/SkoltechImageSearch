from __future__ import print_function

import socket
import sys, time, errno, os
import struct

HOST = '127.0.0.1'
PORT = '30000'

def communicate(send_data, method, host=HOST, port=PORT):
    ''' Send n and send_data to server (host, port) and receive recv_data (host, port) from server using sockets.
    INPUT: send_data -- list of urls (list)
            method -- method for server to use (integer)
    OUTPUT: recv_data -- list of paths to images (list) '''
    # check for argument consistency 
    data_lst = send_data.split(os.linesep)
    if len(data_lst) != n:
        raise ArgumentError, 'Number of urls in first argument should correspond to second argument'
    # create socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server = (HOST, PORT)
    # connecting socket to server
    print('[INFO] Connecting to %s port %s...' % server)
    while True:
        try:
            sock.connect(server)
            time.sleep(0.5)
            break 
        except socket.eror, v:
            if v[0] == errno.ECONNREFUSED:
                p = 0.5
                print '[INFO] Matlab is busy right now. Waiting for %s second(s)' %p
                time.sleep(p)
    print('[INFO] Connected to a server.')
    try:
        # send data to server
        send_length = struct.pack('qq', len(send_data))
        method_bytes = struct.pack('qq', method)
        data = send_length + os.linesep + method_bytes + os.linesep + os.linesep.join(send_data)
        sock.sendall(data)
        # receive data from server
        data = sock.recv(8, socket.MSG_WAITALL)
        data_length = struct.unpack('q', data)[0]
        data = sock.recv(data_length, socket.MSG_WAITALL)
        recv_data = data.split(os.linesep)
        print('[INFO] Received data')
    finally:
        # Clean up the connection
        sock.close()
        return recv_data
