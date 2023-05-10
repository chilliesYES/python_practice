
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#cd C:\Users\不锈钢魔法棒\Desktop\resource_for_final_exam\3.2

data = pd.read_csv("C:/Users/不锈钢魔法棒/Desktop/resource_for_final_exam/3.2/guangdong_guangzhou_2019.txt",sep='\s+',skiprows=1,header=0)
fill1 = 9999.0
data[data == fill1]=np.nan
daily = []
for i in range(24):
    daily.append(np.nanmean(data['NO2'][i::24]))
dout=[]
title = '{0:10s}{1:16s}\n'.format('time','ozone')#0索引第一个即time作为10个字符串输出
dout.append(title)
for i in range(24):
    nlist = '{0:2d}{1:3s}{2:16.8f}\n'.format(i, ":00", daily[i])#2d使i作为2位整数输出3s使
    dout.append(nlist)
with open("year_daily.txt", 'w') as f1:
    f1.writelines(dout)
plt.rcParams['axes.linewidth'] = 2
plt.rcParams['font.sans-serif']=['SimHei']
plt.rcParams['axes.unicode_minus'] = False
font = {'weight': 'bold',
        'size': 12}
plt.rc('font', **font)


#data2 = pd.read_csv('year_daily.txt', sep='\s', header=0, dtype={'time': str, 'ozone': float})
#time = data2['time']
#NO2= data2['ozone']这样不能正确导入数据
data2 = pd.read_csv('year_daily.txt', delim_whitespace=True, index_col=0)
time = data2.index
NO2 = data2['ozone']
fig = plt.figure(num=1, figsize=(6,4))
p = fig.add_subplot(111)
p.plot(time, NO2, color='green', linestyle='-', label='年平均')
p.grid(True, linestyle='--')
p.set_xlabel('时间')
p.set_ylabel('臭氧浓度(ug m$^{-3}$)')
p.set_xlim(0, 24)
p.set_ylim(0, 70)
p.set_xticks(np.linspace(0, 24, 5))
p.set_yticks(np.linspace(0, 70, 5))
p.set_xticklabels(['00:00', '06:00', '12:00', '18:00', '24:00'])
p.tick_params(direction='in', length=5, width=2, color='k')
p.set_title('2019年NO2浓度日变化')
p.legend(frameon=False)
plt.show()
fig.savefig('pig.png',dpi=1200)

#距平图
av = np.nanmean(NO2)
jp = NO2-av
fig2 = plt.figure(num=2, figsize=(6,4))
ax = fig2.add_subplot(111)
ax.bar(time,jp,color=np.where(jp>0,'red', 'tab:blue'),linewidth=0.6,edgecolor='k')
ax.grid(True, linestyle='--')
ax.set_xlabel('时间')
ax.set_ylabel('浓度距平(ug m$^{-3}$)')
ax.set_xlim(-0.5,24.5)
ax.set_ylim(-50,50)
ax.set_xticks(np.linspace(0,24,5))
ax.set_yticks(np.linspace(-50,50,7))
ax.set_xticklabels(['00:00', '06:00', '12:00','18:00', '24:00'])
ax.tick_params(direction='in', length=5, width=1.5, color='k')
ax.set_title('2019年NO2浓度距平')
plt.show()
ax.legend(frameon=False)
fig2.savefig('距平.png',dpi=1200)