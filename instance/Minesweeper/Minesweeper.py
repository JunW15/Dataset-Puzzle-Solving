
# coding: utf-8

# In[15]:


import os
import pandas as pd
import random
import subprocess
import numpy as np
import sys
import os


# In[2]:


def write_ins(file_name,b,h):
    with open(file_name,"w") as f:
        f.write("h="+str(h) + ";\r\n")
        f.write("w=" + str(h)+ ";\r\n")
        f.write("b = [|")
        for i in range(0,int(len(b)/ h)):
            f.write(str(b[i*h:(i+1)*h]).replace("[","").replace("]","|"))
        f.write("]")


# In[3]:


def write_input(file_name,h):
    with open(file_name,"w") as f:
        f.write("h="+str(h) + ";\r\n")
        f.write("w=" + str(h)+ ";\r\n")


# In[4]:


def get_instance(cmd):
    gen_p = subprocess.Popen(cmd,stdout=subprocess.PIPE,shell=True) 
    gen_out = gen_p.stdout.readlines()
    for i in range(0,len(gen_out)):
        gen_out[i] = gen_out[i].decode("utf-8")
    gen_out = ''.join(gen_out)
    gen_out = gen_out.split("\r\n----------\r\n")
    instance = gen_out[0].split("\r\n")
    return instance


# In[5]:


def get_ori(instanc):
    instance = np.array(instanc[0].split(" "))
    instance = [ int(i) for i in instance[0:len(instance)-1] ]
    return instance


# In[6]:


def get_start(b):
    result =[]
    num = 0
    index = np.arange(0,len(b))
    rep = random.sample(list(index),int(len(index)/2))
    for i in range(0,len(b)):
        if i in rep:
            result.append(-1)
        else:
            result.append(int(b[i]))
    return result


# In[7]:


def modify(start,target,dim):
    index = []
    for i in range(0,len(start)):
        if start[i] != target[i]:
            index.append(i)
    n = max(dim-7,1)
    while n >0:
        change_index = np.random.choice(index)
        start[change_index] = int(target[change_index])
        n -= 1 
    return start


# In[8]:


def out_num(cmd):
    p = subprocess.Popen(cmd,stdout=subprocess.PIPE,shell=True) 
    out = p.stdout.readlines()
    for j in range(0,len(out)):
        out[j] = out[j].decode("utf-8")
    out = ''.join(out)
    out = out.split("----------")
    return len(out)


# In[12]:


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


# In[13]:


def main(b,game_name,dim,instance_number):
    puzzle,input,solver,instance_path = get_path(b,game_name)
    ins_num = 0
    write_input(input,dim)
    while ins_num <= instance_number:
        out = ""
        seed = random.randint(0,10000000)
        cmd = 'PATH=$PATH:/home/jun2/Minizinc/bin &&  minizinc ' + "-r "+ str(seed) + r" --solver Gecode " + puzzle + " " + input
        instance = get_instance(cmd)
        instance = get_ori(instance)
        b = get_start(instance)
        path = instance_path + str(dim) +"x" + str(dim) + "_" + str(ins_num) +".dzn"
        write_ins(path,b,dim)
        cmd_solver = 'PATH=$PATH:/home/jun2/Minizinc/bin && minizinc ' + "-r "+ str(seed) + r" -n 2 --solver Gecode " + solver + " " + path
        while out_num(cmd_solver) != 2:
            modify(b,instance,dim)
            write_ins(path,b,dim)
        ins_num = ins_num+1


# In[14]:


print("Please entry:")
print("1 game_name dimentional instance_number \n entry 'exit' to stop")


for line in sys.stdin:
    if line == "exit\n":
        break
    b = int(line.split(" ")[0])
    game_name = line.split(" ")[1]
    dim = int(line.split(" ")[2])
    instance_number = int(line.split(" ")[3])
    main(b,game_name,dim,instance_number)
    print("1 game_name dimentional instance_number \n entry 'exit' to stop")

