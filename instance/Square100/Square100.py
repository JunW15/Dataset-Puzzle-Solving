
# coding: utf-8

# In[1]:


import os
import pandas as pd
import random
import subprocess
import numpy as np
import sys


# In[1]:


def get_instance(cmd):
    gen_p = subprocess.Popen(cmd,stdout=subprocess.PIPE,shell=True) 
    gen_out = gen_p.stdout.readlines()
    for i in range(0,len(gen_out)):
        gen_out[i] = gen_out[i].decode("utf-8")
    gen_out = ''.join(gen_out)
    gen_out = gen_out.split("\r\n----------\r\n")
    instance = gen_out[0].split("\r\n")
    return instance
def get_ori(instanc):
    instance = np.array(instanc[0].split(" "))
    instance = [ int(i) for i in instance[0:len(instance)-1] ]
    return instance
def modify(ori,result):
    index = []
    for i in range(0,len(ori)):
        if ori[i] == 0:
            index.append(i)
    change_index = np.random.choice(index)
    ori[change_index] = result[change_index]
    return ori
def get_start(instance,dim):
    start = []
    index = np.arange(0,dim*2)
    rep = random.sample(list(index),int(len(index)/2))
    for i in range(0,dim*2):
        if i in rep:
            start.append(0)
        else:
            start.append(instance[i])
    return start
def write_ins(file_name,b,dim):
    with open(file_name,"w") as f:
        f.write("h="+ str(dim) + ";\r\n")
        f.write("w="+ str(dim) + ";\r\n")
        f.write("height=" + str(b[0:dim]) + ";\r\n")
        f.write("width=" + str(b[dim:dim*2]) + ";\r\n")
def write_input(file_name,h):
    with open(file_name,"w") as f:
        f.write("h="+str(h) + ";\r\n")
        f.write("w="+str(h) + ";\r\n")
def out_num(cmd):
    p = subprocess.Popen(cmd,stdout=subprocess.PIPE,shell=True) 
    out = p.stdout.readlines()
    for j in range(0,len(out)):
        out[j] = out[j].decode("utf-8")
    out = ''.join(out)
    out = out.split("----------")
    print(out)
    return len(out)
def get_path(b,game_name):
    if b == 0:
        path = r"C:\Users\Brainless\ResearchProject\Minizinc" + "\\"+game_name + "\\"
    else:
        path = "/home/jun2/Workspace/" + game_name +"/"
    puzzle = path + game_name + "-gen.mzn"
    input = path + "input.dzn"
    solver = path  + game_name + ".mzn"
    instance_path = path + "instance_"
    return puzzle,input,solver,instance_path
def main(b,game_name,dim,instance_number):
    puzzle,input,solver,instance_path = get_path(b,game_name)
    ins_num = 0
    write_input(input,dim)
    while ins_num <= instance_number:
        out = ""
        seed = random.randint(0,10000000)
        cmd = ' minizinc ' + "-r "+ str(seed) + r" --solver Gecode " + puzzle + " " + input
        instance = get_instance(cmd)
        instance = get_ori(instance)
        path = instance_path + str(dim) +"x" + str(dim) + "_" + str(ins_num) +".dzn"
        cmd_solver = 'PATH=$PATH:/home/jun2/Minizinc/bin && minizinc ' + "-r "+ str(seed) + r" -n 2 --solver Gecode " + solver + " " + path
        write_ins(path,instance,dim)
        while out_num(cmd_solver) != 2:
            seed = random.randint(0,10000000)
            cmd = 'PATH=$PATH:/home/jun2/Minizinc/bin && minizinc ' + "-r "+ str(seed) + r" --solver Gecode " + puzzle + " " + input
            instance = get_instance(cmd)
            instance = get_ori(instance)
            write_ins(path,instance,dim)
        b = get_start(instance,dim)
        write_ins(path,b,dim)
        while out_num(cmd_solver) != 2:
            modify(b,instance)
            write_ins(path,b,dim)
        ins_num = ins_num+1


# In[5]:


import random
import subprocess
n = 40
num = 0
while num < n:
    seed = random.randint(0,10000000)
    cmd = 'PATH=$PATH:/home/jun2/Minizinc/bin && minizinc -n 10 ' + "-r "+ str(seed) + r" --solver Gecode /home/jun2/Workspace/Square100/square100_generator.mzn /home/jun2/Workspace/Square100/input.dzn"
    gen_p = subprocess.Popen(cmd,stdout=subprocess.PIPE,shell=True) 
    gen_out = gen_p.stdout.readlines()
    for i in range(0,len(gen_out)):
        gen_out[i] = gen_out[i].decode("utf-8")
    gen_out = ''.join(gen_out)
    gen_out = gen_out.split("\n----------\n")
    for i in range(0,10):
        with open("/home/jun2/Workspace/Square100/instance.dzn","w") as f:
            f.write(gen_out[i])
        p = subprocess.Popen('PATH=$PATH:/home/jun2/Minizinc/bin && minizinc -n 2 --solver Gecode /home/jun2/Workspace/Square100/square100_solver.mzn /home/jun2/Workspace/Square100/instance.dzn',stdout=subprocess.PIPE,shell=True) 
        out = p.stdout.readlines()
        for j in range(0,len(out)):
            out[j] = out[j].decode("utf-8")
        out = ''.join(out)
        out = out.split("\n----------\n")
        if (len(out) ==2):
            output = "/home/jun2/Workspace/Square100/instance" + "4x4_"+str(num)+".dzn"
            with open(output,"w") as f:
                f.write(gen_out[i])
            num = num+1



