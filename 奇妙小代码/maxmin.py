times = [1, 3, 3.5, 6.5, 9.5, 10, 10.8]
times=[0]+times
names = ["A", "B", "C", "D", "E", "F", "G"]
e=[]
for p in names:
    e.append(times[names.index(p)+1]-times[names.index(p)])#这里在循环中多次索引位置会影响性能，可以利用range避免反复索引
r=list(zip(e,names))

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
