maxer=[]
miner=[]
max0=max(e)
min0=min(e)
for i in range(len(e)):
    if e[i]==max0:
        maxer.append(r[i])
    elif e[i]==min0:
        miner.append(r[i])
print('最快的是',[name for _,name in maxer],'最快速度是',[sp for sp,_ in maxer])
print('最m的是',miner[:][1],'最m速度是',miner[0][:])#这是错误的用法