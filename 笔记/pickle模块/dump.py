import pickle
a=[1,2,3]
b={"wc":"to","num":254}
c="wdnmd"
with open("tank.pkl", "wb") as f:
    pickle.dump((a,b,c),f)

