from os import listdir
from os.path import isfile, join
import gzip


mypath = "../../data/tweets_clean/"
hashtags = open("../../data/top-hash-tags/top300hashtags","r")
wordsToRemove = open("../../data/top-words/unwanted-words","r")
saida = gzip.open("../../data/entradaLDA/userDocument","w")

validTags = {tag.strip("#").strip() for tag in hashtags}
invalidWords = {word.strip() for word in wordsToRemove}
listValidTags = list(validTags)

hashtags.close()
wordsToRemove.close()

onlyfiles = [ f for f in listdir(mypath) if isfile(join(mypath,f)) ]

for f in onlyfiles:
    tags  = set()
    words = set()
    entradaTweets = gzip.open(mypath+f,"r")
    for line in entradaTweets:
        tags = tags.union({tag.strip("#").strip() for tag in line.split() if tag.startswith("#")})
        words = words.union({tweet.strip() for tweet in line.split()})
    tagsUsed = validTags & tags
    tagUsedTranformed = {str(listValidTags.index(tag)) for tag in tagsUsed}
    wordsUsed = words - invalidWords
    if (tagUsedTranformed):
        saida.write("["+' '.join(tagUsedTranformed) +"] " + ' '.join(wordsUsed)+"\n")
    elif (wordsUsed):
        saida.write(' '.join(wordsUsed).strip()+"\n")
saida.close()
