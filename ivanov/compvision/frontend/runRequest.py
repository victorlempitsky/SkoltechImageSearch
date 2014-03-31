from __future__ import print_function

import socket
import sys
import time

import struct

import numpy as np

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to the port
server_address = ('127.0.0.1', 30000)
print('[INFO] Connecting to %s port %s' % server_address)
sock.connect(server_address)
time.sleep(0.5)

print('[INFO] Connected to a server.')

try:
    print('[INFO] Sending data to MATLAB...')

    test_array = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]], dtype=np.double)
    size_str = struct.pack('qq', test_array.shape[0], test_array.shape[1])
    data = '\x00' + size_str + test_array.tostring()
    sock.sendall(data)

    test_array = np.array([[7, 7, 7], [7, 7, 7]], dtype=np.double)
    size_str = struct.pack('qq', test_array.shape[0], test_array.shape[1])
    data = '\x00' + size_str + test_array.tostring()
    sock.sendall(data)
    
    data = '\x01'
    sock.sendall(data)

    data = sock.recv(8, socket.MSG_WAITALL)
    str_len = struct.unpack('q', data)[0]

    data = sock.recv(str_len, socket.MSG_WAITALL)
    print('[INFO] Received: %s' % data)
finally:
    # Clean up the connection
    sock.close()
