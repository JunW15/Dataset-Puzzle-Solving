
# coding: utf-8

# In[2]:


import os
import pandas as pd
import random
import subprocess
import numpy as np
import sys

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
        if ori[i] != result[i]:
            index.append(i)
    change_index = np.random.choice(index)
    ori[change_index] = result[change_index]
    return ori

def get_start(instance,dim):
    start = []
    index = np.arange(0,dim*dim)
    rep = random.sample(list(index),int(len(index)/3*2))
    for i in range(0,dim*dim):
        if i in rep:
            start.append(0)
        else:
            start.append(instance[i])
    return start

def write_ins(file_name,b,dim):
    with open(file_name,"w") as f:
        f.write("h="+ str(dim) + ";\r\n")
        f.write("w=" + str(dim)+ ";\r\n")
        b1 = np.array(b).reshape(dim,dim)
        f.write("b=" + str(b1).replace("[[","[|").replace("]\n [","|").replace("  "," ").replace(" ",",").replace("]]","|]").replace("|,","|")+";\r\n")
        
def write_input(file_name,h):
    with open(file_name,"w") as f:
        f.write("h="+str(h) + ";\r\n")
        f.write("w="+str(h)+";\r\n")
        
def out_num(cmd):
    p = subprocess.Popen(cmd,stdout=subprocess.PIPE,shell=True) 
    out = p.stdout.readlines()
    for j in range(0,len(out)):
        out[j] = out[j].decode("utf-8")
    out = ''.join(out)
    out = out.split("----------")
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
        cmd = 'PATH=$PATH:/home/jun2/Minizinc/bin && minizinc ' + "-r "+ str(seed) + r" --solver Gecode " + puzzle + " " + input
        instance = get_instance(cmd)
        instance = get_ori(instance)
        b = get_start(instance,dim)
        path = instance_path + str(dim) + "x" + str(dim) + "_" + str(ins_num) +".dzn"
        write_ins(path,b,dim)
        cmd_solver = 'PATH=$PATH:/home/jun2/Minizinc/bin && minizinc ' + "-r "+ str(seed) + r" -n 2 --solver Gecode " + solver + " " + path
        while out_num(cmd_solver) != 2:
            modify(b,instance)
            write_ins(path,b,dim)
        ins_num = ins_num+1


# In[5]:


for i in range(4,10):
    main(1,"Sentinels",i,20)


# In[21]:


ins_num = 0
dim = 5
puzzle = r"C:\Users\Brainless\ResearchProject\Minizinc\Sentinels\Sentinels-gen.mzn"
input = r"C:\Users\Brainless\ResearchProject\Minizinc\Sentinels\input.dzn"
solver = r"C:\Users\Brainless\ResearchProject\Minizinc\Sentinels\Sentinels.mzn"
write_input(input,dim)


# In[22]:


ins_num=0
while ins_num<=10:
    out = ""
    seed = random.randint(0,10000000)
    cmd = 'minizinc ' + "-r "+ str(seed) + r" --solver Gecode " +puzzle + " " + input
    instance = get_instance(cmd)
    instance = get_ori(instance)
    b = get_start(instance,dim)
    path = r"C:\Users\Brainless\ResearchProject\Minizinc\Sentinels\instance"+str(ins_num)+".dzn"
    write_ins(path,b,dim)
    cmd_solver = 'minizinc ' + "-r "+ str(seed) + r" -n 2 --solver Gecode " + solver + " " + path
    while out_num(cmd_solver) != 2:
        modify(b,instance)
        write_ins(path,b,dim)
    ins_num = ins_num+1

