entrada = open("./top-hashtags-global","r")
saida = open("./top300hashtags","w")
invalidHashtags = open ("./unwanted-hashtags","r")

unWantedHashtags = set()
for tag in invalidHashtags:
    unWantedHashtags.add(tag.strip())

hashtags =[]

for tag in entrada:
    tag = tag.split()[1]
    if tag not in unWantedHashtags:
        hashtags.append(tag)
    if len(hashtags) == 300:
        break

saida.write("\n".join(hashtags))



