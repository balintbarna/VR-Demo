import requests
import shutil
urls = ["https://ambientcg.com/get?file=Ground001_2K-JPG.zip"]

for i, url in enumerate(urls):
    r = requests.get(url)
    filename = "res{}.zip".format(i)
    with open(filename, 'wb') as f:
        f.write(r.content) 

    shutil.unpack_archive(filename)
