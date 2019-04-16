
# coding: utf-8

# In[5]:


import os
import pandas as pd
import random
import subprocess
import numpy as np
import sys


# In[6]:


def get_instance(cmd):
    print(cmd,"start")
    gen_p = subprocess.Popen(cmd,stdout=subprocess.PIPE,shell=True) 
    gen_out = gen_p.stdout.readlines()
    for i in range(0,len(gen_out)):
        gen_out[i] = gen_out[i].decode("utf-8")
    gen_out = ''.join(gen_out)
    gen_out = gen_out.split("\r\n----------\r\n")
    instance = gen_out[0].split("\r\n")
    print(cmd,"end")
    return instance


# In[7]:


def get_ori(instanc):
    instance = np.array(instanc[0].split(" "))
    instance = [ int(i) for i in instance[0:len(instance)-1] ]
    return instance


# In[8]:


def modify(ori,result):
    index = []
    for i in range(0,len(ori)):
        if ori[i] == -1:
            index.append(i)
    change_index = np.random.choice(index)
    ori[change_index] = result[change_index]
    return ori


# In[9]:


def get_start(instance,dim):
    start = []
    index = np.arange(0,dim*10)
    rep = random.sample(list(index),int(len(index)/2))
    for i in range(0,dim*10):
        if i in rep:
            start.append(-1)
        else:
            start.append(instance[i])
    for i in range(0,10):
        start.append(instance[i+dim*10])
    return start


# In[10]:


def write_ins(file_name,b,dim):
    with open(file_name,"w") as f:
        f.write("h="+ str(dim) + ";\r\n")
        b1 = np.array(b[0:dim*10]).reshape(dim,10)
        b2 = np.array(b[dim*10:dim*10+10]).reshape(1,10)
        f.write("b=" + str(b1).replace("  "," ").replace("[[","[|").replace("]\n [","|").replace(" ",",").replace("]]","|]").replace("|,","|")+";\r\n")
        f.write("s="+str(b2).replace("[[ ","[").replace("  "," ").replace(" ",",").replace("[[","[").replace("]]","]"))


# In[11]:


def write_input(file_name,h):
    with open(file_name,"w") as f:
        f.write("h="+str(h) + ";\r\n")


# In[12]:


def out_num(cmd):
    p = subprocess.Popen(cmd,stdout=subprocess.PIPE,shell=True) 
    out = p.stdout.readlines()
    for j in range(0,len(out)):
        out[j] = out[j].decode("utf-8")
    out = ''.join(out)
    out = out.split("----------")
    return len(out)


# In[13]:


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


# In[17]:

def main(b,game_name,dim,instance_number):
    puzzle,input,solver,instance_path = get_path(b,game_name)
    ins_num = 0
    write_input(input,dim)
    while ins_num <= instance_number:
        out = ""
        seed = random.randint(0,10000000)
        cmd = ' minizinc ' + "-r "+ str(seed) + r" --time-limit 10000 --solver Gecode " + puzzle + " " + input
        instance = get_instance(cmd)
        instance = get_ori(instance)
        path = instance_path + str(dim) +"x" + str(dim) + "_" + str(ins_num) +".dzn"
        cmd_solver = 'PATH=$PATH:/home/jun2/Minizinc/bin && minizinc ' + "-r "+ str(seed) + r" --time-limit 1000 -n 2 --solver Gecode " + solver + " " + path
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

# In[16]:


for i in range(4,10):
    main(1,"Tenner_Grid",i,20)
    print("the dim is: ", i)

