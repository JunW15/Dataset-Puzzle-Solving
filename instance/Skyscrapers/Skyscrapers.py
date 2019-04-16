
# coding: utf-8

# In[10]:


import os
import pandas as pd
import random
import subprocess
import numpy as np
import sys
import os


# In[11]:


def get_instance(cmd):
    gen_p = subprocess.Popen(cmd,stdout=subprocess.PIPE,shell=True) 
    gen_out = gen_p.stdout.readlines()
    for i in range(0,len(gen_out)):
        gen_out[i] = gen_out[i].decode("utf-8")
    gen_out = ''.join(gen_out)
    gen_out = gen_out.split("\r\n----------\r\n")
    instance = gen_out[0].split("\r\n")
    return instance


# In[12]:


def get_ori(instanc):
    instance = np.array(instanc[0].split(" "))
    instance = [ int(i) for i in instance[0:len(instance)-1] ]
    return instance


# In[13]:


def modify(ori,result):
    index = []
    for i in range(0,len(ori)):
        if ori[i] == 0:
            index.append(i)
    change_index = np.random.choice(index)
    ori[change_index] = result[change_index]
    return ori


# In[14]:


def get_start(instance,dim):
    start = []
    for i in range(0,dim*dim):
        start.append(0)
    index = np.arange(0,dim*4)
    rep = random.sample(list(index),int(len(index)/2))
    for i in range(0,dim*4):
        if i in rep:
            start.append(0)
        else:
            start.append(instance[i+dim*dim])
    return start


# In[15]:


def write_ins(file_name,b,dim):
    with open(file_name,"w") as f:
        f.write("h="+ str(dim) + ";\r\n")
        f.write("w=" + str(dim) + ";\r\n")
        f.write("left=" + str(b[dim*dim:dim*dim+dim]) +";\r\n")
        f.write("right=" + str(b[dim*dim+dim:dim*dim+dim*2]) + ";\r\n")
        f.write("top=" + str(b[dim*dim+dim*2:dim*dim+dim*3])+";\r\n")
        f.write("down=" + str(b[dim*dim+dim*3:dim*dim+dim*4])+";\r\n")
        b1 = np.array(b[0:dim*dim]).reshape(dim,dim)
        f.write("b=" + str(b1).replace("[[","[|").replace("]\n [","|").replace(" ",",").replace("]]","|]"))


# In[16]:


def write_input(file_name,h):
    with open(file_name,"w") as f:
        f.write("h="+str(h) + ";\r\n")
        f.write("w=" + str(h)+ ";\r\n")


# In[17]:


def out_num(cmd):
    p = subprocess.Popen(cmd,stdout=subprocess.PIPE,shell=True) 
    out = p.stdout.readlines()
    for j in range(0,len(out)):
        out[j] = out[j].decode("utf-8")
    out = ''.join(out)
    out = out.split("----------")
    print(out)
    print(len(out))
    return len(out)


# In[18]:


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


# In[22]:


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
        b = get_start(instance,dim)
        path = instance_path + str(dim) +"x" + str(dim) + "_" + str(ins_num) +".dzn"
        write_ins(path,b,dim)
        cmd_solver = '	PATH=$PATH:/home/jun2/Minizinc/bin &&  minizinc ' + "-r "+ str(seed) + r" -n 2 --solver Gecode " + solver + " " + path
        while out_num(cmd_solver) != 2:
            modify(b,instance)
            write_ins(path,b,dim)
        ins_num = ins_num+1


# In[23]:


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

