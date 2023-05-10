pool = []
for x in range(1600,1901):
    if x%4 == 0:
        if x%400 == 0:
            pool.append(x)
        elif x%100 != 0:
            pool.append(x)
print(pool)
print(len(pool))

