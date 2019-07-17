#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2019-07-17 12:25:19
# @Author  : Guosheng Kang (guoshengkang@gmail.com)
# @Link    : https://guoshengkang.github.io
# @Version : $Id$

import os
import sys
import time
import datetime
import random
import threading
import os
import base64
import requests
url = r'http://10.108.255.249/include/auth_action.php'
d = Decode()
def login():
    print("logining................")

    payload = {
        'action':'login',
        'username':d.decode("username"),
        'password':d.decode("password"),
        'ac_id':1,
        'ajax':1
    }
    response = requests.post(url,data=payload)
    response_str = response.content.decode('utf-8')
    if(response_str.find("login_ok") == -1):
        return False
    return True

if __name__ == "__main__":

    print
    if login() == True:
        print "login ok"
    else:
        print "login false"