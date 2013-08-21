from os import listdir
from os.path import isfile, join
import gzip


mypath = "../../data/tweets_clean/"
hashtags = open("../../data/top-hash-tags/top300hashtags","r")

validTags = {tag.strip("#").strip() for tag in hashtags}
listValidTags = list(validTags)
hashtags.close()

for tag in listValidTags:
    print str(listValidTags.index(tag))+": " + tag
