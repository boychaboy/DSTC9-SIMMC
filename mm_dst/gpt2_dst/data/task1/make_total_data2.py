import json

domain = 'furniture'
# domain = 'fashion_to'
# domain2 = 'fashion'
# domain = 'fashion'
domain2 = domain

f_train = open(f"./{domain}/{domain2}_train_dials_target.txt", 'r')
f_dev = open(f"./{domain}/{domain2}_dev_dials_target.txt", 'r')
# f_devtest = open(f"./{domain}/{domain2}_devtest_dials_target.txt", 'r')

w_train = open(f"./{domain}_total/{domain2}_train_dials_target.txt", 'w')
w_dev = open(f"./{domain}_total/{domain2}_dev_dials_target.txt", 'w')
# w_devtest = open(f"./{domain}_total/{domain2}_devtest_dials_target.txt", 'w')

special_to_token = open(f"./../../utils/{domain}/special_to_token.json", 'r')
special_to_token = json.load(special_to_token)

def convert_data(reader, writer):
    for line in reader.readlines():
        line = line.split(" => Belief State : ")

        sp = line[1].split(" <EOR> ")
        for key in special_to_token.keys():
            if key in sp[0]:
                sp[0] = sp[0].replace(key, special_to_token[key])
        writer.write(line[0]+" => Belief State : " + sp[0] + " <EOR> " + sp[1]) 

convert_data(f_train, w_train)
convert_data(f_dev, w_dev)
# convert_data(f_devtest, w_devtest)
