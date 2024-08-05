import pickle
with open("tank.pkl","rb") as f:
    c,d,e = pickle.load(f)
print(c,d,e)